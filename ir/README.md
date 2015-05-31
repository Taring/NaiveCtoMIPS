此处的中间表示(Intermediate Representation, a.k.a. IR)主要参考了龙书6.2.1节的设计。
在龙书提供的设计的基础上，添加了一些这个编译器需要的内容。

如果你对于这部分内容有任何疑问，可以邮件(zeonsgtr@gmail.com)或者QQ(982389131)联系我，我会尽快回复。

# Address
Address指的是中间代码中涉及到的操作数，分为以下三类：
- 常量(const)：例如`a = b + 3`中的`3`。
- 变量(name)：源程序或编译器生成的变量，有内存地址。例如下面代码中的`a,b,c`
```C
int a, b, c;
int main() {
    a = (b + c) - (b - c); 
    /*
     * t0 = b + c
     * t1 = b - c
     * a = t0 + t1
     */
}
```
- 临时变量(temp)：指编译器生成的临时变量，相当于寄存器。例如上面代码中的`t0,t1`。

| Class | Example | Description |
|-------|---------|-------------|
|[Address](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Address.java) | | 空的抽象类，其它所有可能的操作数继承自该类 |
|[Const](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Const.java) | | 表示常量，常量包括字符串常量和整形常量 |
|[StringAddressConst](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/StringAddressConst.java) | `a = "acm"` | 字符串常量 |
|[IntegerConst](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/IntegerConst.java) | `a = 3` | 整形常量|
|[Name](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Name.java) | `a = b` | 变量 |
|[Temp](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Temp.java) | `a = t4` | 编译器生成的临时变量|

# [IR](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/IR.java)
整个IR由多个函数构成。同时约定一个特殊的函数`__start`，所有的全局变量以及相关的初始化信息均记录在该函数中，在执行完初始化后，该函数调用`main`。

# [Function](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Function.java)
对于每个函数，除了正式的语句，还需要记录一些metadata，包括：
- `String name` 函数名
- `int size` 返回值大小（字节）
- `List<Variable> args` 参数
- `List<Variable> vars` 变量

对于全局变量，它的相关信息记录在`__start`的`vars`中。

# [Variable](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/ArrayVariable.java)
变量分为两类：
- [BasicVariable](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/BasicVariable.java)：非数组、struct/union类型的变量。
- [ArrayVariable](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/ArrayVariable.java)：数组、struct/union类型的变量。在此处的中间表示中，struct/union被视作一个数组。

# [Quadruple](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Quadruple.java)
表示所有的四元组。

# Expression
表达式分为赋值表达式、一元表达式和二元表达式等。对于struct/union的赋值，建议进行拆分，例如
```C
strcut A {int x, y} a, b;
int main() {
    a = b;
    /*
     * t1 = a[0], 4
     * b[0] = t1, 4
     * t1 = a[4], 4
     * b[4] = t1, 4
     */
}
```

| Class | Example | Description |
|-------|---------|-------------|
|[Assign](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Function.java) | `a = b` | 赋值语句|
|[ArithmeticExpr](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Arithmetic.java) | `a = b * c` `a = ~b` | 算术运算，运算符类型记录在[ArithmeticOp](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/ArithmeticOp.java) |
|[ArrayRead](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/ArrayRead.java) | `a = b[4], 4` | 从数组、struct/union中某个部分取值，因为数组储存在内存中，所以需要记录该部分的大小（int为4字节、char为1字节）|
|[ArrayWrite](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/ArrayWrite.java) | `b[4] = a, 4` | 赋值给数组、struct/union中某个部分 |
|[PointerRead](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/PointerRead.java) | `t0 = *a, 4` | 从`a`所记录的内存地址中取值，同样需要记录被取值部分的大小 |
|[PointerWrite](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/PointerWrite.java) | `*a = t0, 4` | 赋值给`a`所记录的内存地址中 |
|[AddressOf](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Arithmetic.java) | `a = &b` | 取地址运算 |

# Control Flow 
| Class | Example | Description |
|-------|---------|-------------|
|[Label](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Label.java) | `Label L1` | 标号，用于辅助跳转|
|[Goto](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Goto.java) | `goto L1` | 无条件跳转 |
|[IfFalseGoto](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/IfFalseGoto.java) | `IfFalse a != b goto L1` | 如果判断为假，则跳转 |
|[IfTrueGoto](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/IfTrueGoto.java) | `IfTrue a != b goto L1` | 如果判断为真，则跳转 |

跳转语句中的关系运算符记录在[RelationalOp](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/RelationalOp.java)。

# Function Call
函数调用采取如下的形式：
```C
struct A {int x, y;};
int f(int a, int b, int c) { }
void g(int a) { }
void h(int a[10]) { }
void e(struct A a) {}
int main() {
    int x;
    x = f(1, 2, 3);
    /*
     * t1 = 1
     * t2 = 2
     * t3 = 3
     * param t1
     * param t2
     * param t3
     * x = call f, 3
     */

    g(x);
    /*
     * param x
     * call g, 1
     */
    
    int arr[10];
    h(arr);
    /*
     * t0 = &arr
     * param t0
     * call h, 1
     */

    struct A* ptr;
    e(*ptr);
    /*
     * param *ptr
     * call e, 1
     */
}
```

函数调用的参数（[Param](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Param.java)）分为三类：
- [BasicParam](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/BasicParam.java)：非struct/union的基本类型。
- [ArrayParam](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/ArrayParam.java)：struct/union类型的变量，这种类型的变量按值传参。
- [MemoryParam](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/MemoryParam.java)：参数是内存中的连续一段。

函数调用对应的类为[Call](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Call.java)，需要注意该类中的`returnValue`变量类型也为Param。

同时注意，函数返回（[Return](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ir/Return.java)）的返回值类型也为Param。
