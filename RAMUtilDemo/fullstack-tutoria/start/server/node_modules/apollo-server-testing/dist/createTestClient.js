"use strict";
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
Object.defineProperty(exports, "__esModule", { value: true });
const graphql_1 = require("graphql");
exports.default = (server) => {
    const executeOperation = server.executeOperation.bind(server);
    const test = (_a) => {
        var { query, mutation } = _a, args = __rest(_a, ["query", "mutation"]);
        const operation = query || mutation;
        if (!operation || (query && mutation)) {
            throw new Error('Either `query` or `mutation` must be passed, but not both.');
        }
        return executeOperation(Object.assign({ query: typeof operation === 'string' ? operation : graphql_1.print(operation) }, args));
    };
    return { query: test, mutate: test };
};
//# sourceMappingURL=createTestClient.js.map