console.log("-------test1--------");
var string = "我说：\"你是好人'";
var number = 12.222;

string = number;

console.log(string); //12.222
console.log(typeof string);//number

console.log(Number.MAX_VALUE);//1.7976931348623157e+308

number = Number.MAX_VALUE *Number.MAX_VALUE;
console.log(number);//Infinity

var a = Infinity;
console.log(typeof a);//number

a = "abc" * "abc";
console.log(a);//NaN

a = NaN;
console.log(typeof a);//number

a = Number.MIN_VALUE;
console.log(a);//5e-324


a = false;
console.log(a);//false
console.log(typeof a);//boolean

a = null;
console.log(a);//null
console.log(typeof a);//object

var c;
console.log(c);//undefined
console.log(typeof c);//undefined

// 强制类型转换
// 转换为string
var testN = 123;
var testS = testN.toString();
console.log(testS); // 123
console.log(typeof testS); // string

a = true;
a = a.toString(); // true
console.log(a);

a = null;
// a = a.toString();//报错 TypeError: Cannot read property 'toString' of null
a = String(a);
console.log(a); //null
console.log(typeof a);//string


a = undefined;
// a = a.toString();//报错 TypeError: Cannot read property 'toString' of undefined
a = String(a);
console.log(a); //undefined
console.log(typeof a);//string

a = String(testN);
console.log(a);//123
console.log(typeof a);//string

// 转换为number
a = "123";
a = Number(a); // undefined -> NaN


a = "123a2323epx";
a = parseInt(a);
console.log(a); //123
console.log(typeof a);//number

a = "123.232asdf";
a = parseFloat(a);
console.log(a); //123.232 
console.log(typeof a);//number

// 如果对非String使用parseInt()或parseFloat()
// 它会先将其转换为String，然后再操作
a = true;
a = parseInt(a);
console.log(a); //Nan
console.log(typeof a);//number


/// 其他进制的数字
a = 0x10; // 十六进制
console.log(a);// 16
a = 010; // 八进制
console.log(a);// 8
a = 0b10;// 二进制
console.log(a);// 2

/// 使用parseInt(a)，有些浏览器会当成八进制解析，有些浏览器会当成十进制解析
a = "070";
/// 第二个参数指定解析的进制
a = parseInt(a, 10);

// 转换为boolean
a = 123; //true
a = -123;// true
a = 0; //false
a = NaN; // false
a = Infinity; // true
a = "flase";// true
a = "";//flase
a = null;//false
a = undefined;//false
a = Boolean(a);
console.log(a);

a = 123;
var result = typeof a;
console.log(typeof result);// string

// 一元运算符
// 对于非Number类型的值，
//      他会先转换为Number，然后再运算
//      可以对一个其他的数据类型使用+，来将其转为number
//      他的原理和Number()函数一样
a = 1 + "12" + 1;
console.log(a); // 1121
a = 1 + +"12" + 1;
console.log(a);// 14