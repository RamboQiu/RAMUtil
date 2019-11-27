console.log("-------test2--------");


if (isFinite('a')) {
    console.log('true');
} else {
    console.log('false');
}


var string = 'Hello World';
console.log(btoa(string));
console.log(atob('SGVsbG8gV29ybGQh'));

var obj = {
1: 'a',
3.2: 'b',
1e2: true,
1e-2: true,
.234: true,
0xFF: true
};

console.log(obj);


var obj1 = {
    p: function (x) {
        return 2 * x;
    }
};

console.log(obj1.p(1));

var o1 = {};
var o2 = { bar: '1111' };

o1.foo = o2;
o1.tt = o2;
console.log(o1.tt.bar); // "hello"

console.log(eval('{foo: 123}'));
console.log(eval('({foo: 123})'));

console.log(Object.keys(o1));

if (delete o1.tt) {
    console.log(Object.keys(o1));
}

var obj = Object.defineProperty({}, 'p', {
    value: 123,
    configurable: false
});

obj.p // 123
delete obj.p // false

var obj = { p: 1 };
console.log('p' in obj); // true
console.log('toString' in obj); // true

if ('toString' in obj) {
    console.log(obj.hasOwnProperty('toString')) // false
}

var obj = {a: 1, b: 2, c: 3};

for (var i in obj) {
  console.log('键名：', i);
  console.log('键值：', obj[i]);
}

var person = { name: '老张' };

for (var key in person) {
  if (person.hasOwnProperty(key)) {
    console.log(key);
  }
}
// name