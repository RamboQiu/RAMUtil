setimmediate-napi
=================
### `setImmediate()` for N-API code

[![Greenkeeper badge](https://badges.greenkeeper.io/node-ffi-napi/setimmediate-napi.svg)](https://greenkeeper.io/)

[![NPM Version](https://img.shields.io/npm/v/setimmediate-napi.svg?style=flat)](https://npmjs.org/package/setimmediate-napi)
[![NPM Downloads](https://img.shields.io/npm/dm/setimmediate-napi.svg?style=flat)](https://npmjs.org/package/setimmediate-napi)
[![Build Status](https://travis-ci.org/node-ffi-napi/setimmediate-napi.svg?style=flat&branch=master)](https://travis-ci.org/node-ffi-napi/setimmediate-napi?branch=master)
[![Coverage Status](https://coveralls.io/repos/node-ffi-napi/setimmediate-napi/badge.svg?branch=master)](https://coveralls.io/r/node-ffi-napi/setimmediate-napi?branch=master)
[![Dependency Status](https://david-dm.org/node-ffi-napi/setimmediate-napi.svg?style=flat)](https://david-dm.org/node-ffi-napi/setimmediate-napi)

Installation
------------

Install with `npm`:

``` bash
$ npm install setimmediate-napi
```

Usage
-----

In your `binding.gyp`:

```python
    'include_dirs': ["<!@(node -p \"require('node-addon-api').include\")",
                     "<!@(node -p \"require('setimmediate-napi').include\")"],
```

(Just have `"<!@(node -p \"require('setimmediate-napi').include\")"` somewhere in that list, ok?)

In your C++ code:

```c++
#include <setimmediate.h>

int a = 10;
SetImmediate(env, [a]() {
  /* do something with a ... */
});
```

Keep in mind:
- You need to use `Reference`s to keep track of JS objects, since this code runs asynchronously.
- Use `MakeCallback` rather than `Call` to make sure Node.js can track your async context.
- This function can be invoked even when executing JS code itself is not allowed.
