"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const apollo_server_env_1 = require("apollo-server-env");
const CachePolicy = require("http-cache-semantics");
const apollo_server_caching_1 = require("apollo-server-caching");
class HTTPCache {
    constructor(keyValueCache = new apollo_server_caching_1.InMemoryLRUCache()) {
        this.keyValueCache = keyValueCache;
    }
    fetch(request, options = {}) {
        return __awaiter(this, void 0, void 0, function* () {
            const cacheKey = options.cacheKey ? options.cacheKey : request.url;
            const entry = yield this.keyValueCache.get(`httpcache:${cacheKey}`);
            if (!entry) {
                const response = yield apollo_server_env_1.fetch(request);
                const policy = new CachePolicy(policyRequestFrom(request), policyResponseFrom(response));
                return this.storeResponseAndReturnClone(response, request, policy, cacheKey, options.cacheOptions);
            }
            const { policy: policyRaw, ttlOverride, body } = JSON.parse(entry);
            const policy = CachePolicy.fromObject(policyRaw);
            policy._url = undefined;
            if ((ttlOverride && policy.age() < ttlOverride) ||
                (!ttlOverride &&
                    policy.satisfiesWithoutRevalidation(policyRequestFrom(request)))) {
                const headers = policy.responseHeaders();
                return new apollo_server_env_1.Response(body, {
                    url: policy._url,
                    status: policy._status,
                    headers,
                });
            }
            else {
                const revalidationHeaders = policy.revalidationHeaders(policyRequestFrom(request));
                const revalidationRequest = new apollo_server_env_1.Request(request, {
                    headers: revalidationHeaders,
                });
                const revalidationResponse = yield apollo_server_env_1.fetch(revalidationRequest);
                const { policy: revalidatedPolicy, modified } = policy.revalidatedPolicy(policyRequestFrom(revalidationRequest), policyResponseFrom(revalidationResponse));
                return this.storeResponseAndReturnClone(new apollo_server_env_1.Response(modified ? yield revalidationResponse.text() : body, {
                    url: revalidatedPolicy._url,
                    status: revalidatedPolicy._status,
                    headers: revalidatedPolicy.responseHeaders(),
                }), request, revalidatedPolicy, cacheKey, options.cacheOptions);
            }
        });
    }
    storeResponseAndReturnClone(response, request, policy, cacheKey, cacheOptions) {
        return __awaiter(this, void 0, void 0, function* () {
            if (cacheOptions && typeof cacheOptions === 'function') {
                cacheOptions = cacheOptions(response, request);
            }
            let ttlOverride = cacheOptions && cacheOptions.ttl;
            if (!(ttlOverride && (policy._status >= 200 && policy._status <= 299)) &&
                !(request.method === 'GET' && policy.storable())) {
                return response;
            }
            let ttl = ttlOverride || Math.round(policy.timeToLive() / 1000);
            if (ttl <= 0)
                return response;
            if (canBeRevalidated(response)) {
                ttl *= 2;
            }
            const body = yield response.text();
            const entry = JSON.stringify({
                policy: policy.toObject(),
                ttlOverride,
                body,
            });
            yield this.keyValueCache.set(`httpcache:${cacheKey}`, entry, {
                ttl,
            });
            return new apollo_server_env_1.Response(body, {
                url: response.url,
                status: response.status,
                statusText: response.statusText,
                headers: response.headers,
            });
        });
    }
}
exports.HTTPCache = HTTPCache;
function canBeRevalidated(response) {
    return response.headers.has('ETag');
}
function policyRequestFrom(request) {
    return {
        url: request.url,
        method: request.method,
        headers: headersToObject(request.headers),
    };
}
function policyResponseFrom(response) {
    return {
        status: response.status,
        headers: headersToObject(response.headers),
    };
}
function headersToObject(headers) {
    const object = Object.create(null);
    for (const [name, value] of headers) {
        object[name] = value;
    }
    return object;
}
//# sourceMappingURL=HTTPCache.js.map