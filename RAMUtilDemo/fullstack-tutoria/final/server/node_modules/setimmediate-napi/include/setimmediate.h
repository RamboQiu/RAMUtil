#ifndef _SETIMMEDIATE_NAPI_H
#define _SETIMMEDIATE_NAPI_H

#include <napi.h>
#include <uv.h>
#include <stdlib.h>
#include <memory>
#include <get-symbol-from-current-process.h>
#include <get-uv-event-loop-napi.h>

static void* __setimmediate_napi_get_data_default(const uv_handle_t* handle) {
  return *reinterpret_cast<void* const*>(handle);
}

static void __setimmediate_napi_set_data_default(uv_handle_t* handle, void* data) {
  *reinterpret_cast<void**>(handle) = data;
}

template<typename T>
void SetImmediate(napi_env env, T&& cb) {
  typedef void* (*__get_data)(const uv_handle_t* handle);
  typedef void (*__set_data)(uv_handle_t* handle, void* data);

  static __get_data get_data = nullptr;
  static __set_data set_data = nullptr;

  if (get_data == nullptr) {
    if (uv_version() >= 0x011300) {
      get_data = reinterpret_cast<__get_data>(
          get_symbol_from_current_process("uv_handle_get_data"));
      set_data = reinterpret_cast<__set_data>(
          get_symbol_from_current_process("uv_handle_set_data"));
    }
    if (get_data == nullptr) {
      get_data = __setimmediate_napi_get_data_default;
      set_data = __setimmediate_napi_set_data_default;
    }
  }

  struct SetImmediateData {
    explicit inline SetImmediateData(T&& cb) : callback(std::move(cb)) {
      check = static_cast<uv_check_t*>(malloc(uv_handle_size(UV_CHECK)));
      idle = static_cast<uv_idle_t*>(malloc(uv_handle_size(UV_IDLE)));
    }
    ~SetImmediateData() {
      free(check);
      free(idle);
    }
    T callback;
    // uv_check_t + uv_idle_t is what Node.js itself does.
    uv_check_t* check;
    uv_idle_t* idle;
    napi_env env;
  };

  uv_loop_t* loop = get_uv_event_loop(env);
  SetImmediateData* data = new SetImmediateData(std::move(cb));
  set_data(reinterpret_cast<uv_handle_t*>(data->check), data);
  set_data(reinterpret_cast<uv_handle_t*>(data->idle), data);
  data->env = env;

  uv_check_init(loop, data->check);
  uv_idle_init(loop, data->idle);
  uv_idle_start(data->idle, [](uv_idle_t* idle) { /* spin the event loop */ });
  uv_check_start(data->check, [](uv_check_t* check) {
    SetImmediateData* data = static_cast<SetImmediateData*>(
        get_data(reinterpret_cast<uv_handle_t*>(check)));
    T cb = std::move(data->callback);
    uv_close(reinterpret_cast<uv_handle_t*>(data->check),
             [](uv_handle_t* handle) {
      SetImmediateData* data = static_cast<SetImmediateData*>(
          get_data(handle));
      uv_close(reinterpret_cast<uv_handle_t*>(data->idle),
               [](uv_handle_t* handle) {
        SetImmediateData* data = static_cast<SetImmediateData*>(
            get_data(handle));
        delete data;
      });
    });

    Napi::HandleScope scope(data->env);

    try {
      cb();
    } catch (Napi::Error& e) {
      // This is going to crash, but it's not like we really have a choice.
      e.ThrowAsJavaScriptException();
    }
  });
}

#endif
