

var o = {a: 1};

function f(key, value) {
    console.log("["+ key +"]:" + value);
  if (typeof value === 'object') {
    return {b: 2};
  }
  return value * 2;
}

console.log(JSON.stringify(o, f));