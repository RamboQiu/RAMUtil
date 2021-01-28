'use strict';
const uvloop = require('get-uv-event-loop-napi-h');
const symbol = require('get-symbol-from-current-process-h');
const path = require('path');
exports.includeRaw = path.resolve(__dirname, 'include') + ' ' + uvloop.includeRaw + ' ' + symbol.includeRaw;
exports.include = exports.includeRaw.replace(/\\/g, '\\\\');
exports.gyp = uvloop.gyp;
