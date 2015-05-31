# Concrete Syntax Tree(CST)
我们先来看看维基百科对[Concrete Syntax Tree](http://en.wikipedia.org/wiki/Parse_tree)的定义：
> A **concrete syntax tree** or **parse tree** or **parsing tree** or **derivation tree** is an ordered, 
> rooted tree that represents the syntactic structure of a string according to some context-free grammar.

这段定义告诉我们CST是由Grammar导出的树，表示了源代码的语法结构。

考虑如下的C语言代码：
```C
struct A {
    int a;
} b, c;
```

如果采取该[Grammar](http://acm.sjtu.edu.cn/wiki/Compiler_2014:_Grammar)，那么对应的CST为：
```
[program]
`---[declaration]
    |---[type-specifier]
    |   `---[struct-or-union ? (...)+ ]
    |       |---[struct-or-union]
    |       |   `---['struct']
    |       |---[identifier: 'A']
    |       `---[(...)+]
    |           `---[(...)]
    |               |---[type-specifier]
    |               |   `---['int']
    |               `---[declarators]
    |                   `---[declarator]
    |                       `---[plain-declarator]
    |                           `---[identifier: 'a']
    `---[init-declarators]
        |---[init-declarator]
        |   `---[declarator]
        |       `---[plain-declarator]
        |           `---[identifier: 'b']
        `---[init-declarator]
            `---[declarator]
                `---[plain-declarator]
                    `---[identifier: 'c']
```

我们注意到：即使源代码很简单，对应的CST也可能非常复杂。
同时，对于一段代码，如果采用不同的Grammar，那么对应的CST可能也会不同。

编译器的工作是把高级语言翻译为机器指令，并且保证正确性。此处的正确性，指的是机器指令的语义要与源代码的语义一致。

从上面的例子可以看到，CST体现了源代码的语法结构，同时也蕴含着语义相关的信息，但并未按照更符合语义的方式组织。 
因此，为了更容易地实现编译器，我们需要一个能够更好地表示语义的工具，这就是Abstract Syntax Tree。

# Abstract Syntax Tree(AST)
先来看看维基百科对[Abstract Syntax Tree](http://en.wikipedia.org/wiki/Abstract_syntax_tree)的定义：
> In computer science, an **abstract syntax tree**, or just **syntax tree**, is a tree representation of the 
> abstract syntactic structure of source code written in a programming language.

再来看看维基百科对[Abstract Syntax](http://en.wikipedia.org/wiki/Abstract_syntax)的定义：
> The **abstract syntax** of data is its structure described as a data type (possibly, but 
> not necessarily, an abstract data type), independent of any particular representation or encoding.

再来看一个例子
```C
int nfactor(int n) {
  if (n == 0) return 1;
  else return n * nfactor(n - 1);
}

int main() {
  int a = nfactor(6);
  printf("%d\n", a);
  return a;
}
```

上述代码对应的AST为
```
[root]
`---[FunctionDecl : nfactor]
|   `---[IntType]
|   `---[Params]
|   |   `---[VarDecl : n]
|   |       `---[IntType]
|   `---[CompoundStmt]
|       `---[IfStmt]
|           `---[BinaryExpr : ==]
|           |   `---[Identifier : n]
|           |   `---[IntConst : 0]
|           `---[ReturnStmt]
|           |   `---[IntConst : 1]
|           `---[ReturnStmt]
|               `---[BinaryExpr : *]
|                   `---[Identifier : n]
|                   `---[FunctionCall]
|                       `---[nfactor]
|                       `---[Arguments]
|                           `---[BinaryExpr : -]
|                               `---[Identifier : n]
|                               `---[IntConst : 1]
`---[FunctionDecl : main]
    `---[IntType]
    `---[Params]
    `---[CompoundStmt]
        `---[VarDecl : a]
        |   `---[IntType]
        |   `---[InitValue]
        |       `---[FunctionCall]
        |           `---[nfactor]
        |           `---[Arguments]
        |               `---[IntConst : 6]
        `---[FunctionCall]
        |   `---[printf]
        |   `---[Arguments]
        |       `---[StringConst : "%d\n"]
        |       `---[Identifier : a]
        `---[ReturnStmt]
            `---[Identifier : a]
```

可以发现，AST比CST简洁了许多，因为AST体现的是语义相关的信息。同时，因为AST是人为设计的，所以不同的设计会有不同的AST，下面将介绍TA所设计的AST作为参考。
你可以原封不动地采用TA的设计，也可以修改你认为不合理的地方，如果你使用了不同的设计，可以通过上台做Presentation的方式获取bonus。

# TA's Framework
下面只是对TA的设计进行了一个简单的介绍，有很多细节都没有涉及到，需要各位同学自行理解。同时，TA还提供了一个[工具](https://github.com/zeonsgtr/compiler2015/tree/master/tools/ast)，
可以输出源代码对应的AST，但不保证正确性。如遇问题，请联系TA。

## Declaration
对于任何的一个C程序，我们都可以把它看做一系列Declarations，Declaration可以分为三类：

- Function Declaration
```C
int square(int a, int b) {
    return (a - b) * (a - b);
}
```
- Type Declaration
```C
struct Tuple {
    int first, second;
};
```
- Variable Declaration
```C
int o_o;
```

与此同时，为了方便，C语言还允许混合Type Declaration和Variable Declaration:
```C
struct Tuple {
    union Triple {
        int a;
        char b;
        struct Tuple* c;
    } d;
    int e;
} f, g;
```

从语义的角度来说，我们应该把上面的代码视作如下的形式：
```C
union Triple {
    int a;
    char b;
    struct Tuple* c;
};
struct Tuple {
    union Triple d;
    int e;
};
struct Tuple f;
struct Tuple g;
```

基于上述的理解，我们进行了如下的设计：

| Class | Description |
|------|-------------|
|[AST](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/AST.java) | 表示AST的根 |
|[Decl](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/Decl.java) | 没有任何成员和方法的抽象类，设计它是为了方便，下面四个类均继承自它。|
|[FunctionDecl](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/FunctionDecl.java) | Function Declaration |
|[StructDecl](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/StructDecl.java) | Type Declaration |
|[UnionDecl](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/UnionDecl.java) | Type Declaration |
|[VarDecl](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/VarDecl.java) | Variable Declaration |

## Type
在C语言中，变量的类型可能非常复杂，例如下面的例子
```C
char *(*(**foo[][8])())[];
```

在继续设计AST的设计之前，必须对类型有清楚地认识。请先阅读[How to read C type declarations?](http://unixwiz.net/techtips/reading-cdecl.html)

和Declaration的设计类似，为了方便，设计一个空的抽象类[Type](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/Type.java)，
该节中的其它类均直接或间接地继承它。

### Basic Type
为了方便，设计一个空的抽象类[BasicType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/BasicType.java)，下面的五个类均继承自它。

| Class | Example | Description |
|------|---------|-------------|
|[IntType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/IntType.java) | `int a;` | |
|[CharType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/CharType.java) | `char a;` | |
|[VoidType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/VoidType.java) | `void f() {}` | 只有函数返回值允许这种类型 |
|[StructType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/StructType.java) | `struct A a;` | StructType仅有成员tag，表示类型名。该例中tag应为`A`，为什么不把struct也算作类型名的一部分？|
|[UnionType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/UnionType.java) | `union B a;` | 为什么要把StructType和UnionType分开？|

### PointerType
```C
struct A* a;
int*** b;
```
以[PointerType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/PointerType.java)表示。

### ArrayType
```C
struct Tuple a[2][33];
```
以[ArrayType](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/ArrayType.java)表示。

## Statement
接下来考虑每条语句应该如何表示。和前面的设计类似，为了方便，先设计一个空的抽象类[Stmt](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/Stmt.java)。

所有的语句可以由下面的类表示：

| Class | Example |
|-------|---------|
|[BreakStmt](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/BreakStmt.java) | `break;` |
|[ContinueStmt](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/ContinueStmt.java) | `continue;` |
|[IfStmt](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/IfStmt.java) |`if (o > o + v) {} ` |
|[ForLoop](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/ForLoop.java) | `for (int i = 0; i < 10; i++) {}` |
|[WhileLoop](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/WhileLoop.java) | `while (x > 0) { x--; }` |
|[ReturnStmt](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/ReturnStmt.java) | `return 2 + 3 + 3;` |
|[CompoundStmt](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/CompoundStmt.java) |`{ int t = x; x = y; y = t; } ` |
|[Expr](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/Expr.java) | `a = 2 + 3 + 3;` |

## Expression
表达式可以划分为以下的类别：

| Class | Example | Description |
|-------|---------|-------------|
|[EmptyExpr](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/EmptyExpr.java) | `for (;;) {}` | 空表达式 |
|[BinaryExpr](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/BinaryExpr.java) |`a = b % c;` | 二元表达式，操作符以[BinaryOp](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/BinaryOp.java)表示。|
|[UnaryExpr](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/UnaryExpr.java) | `a = ~b;` | 一元表达式，操作符以[UnaryOp](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/UnaryOp.java)表示。`sizeof(a[10])`这种情况也被视作一元表达式。|
|[SizeofExpr](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/SizeofExpr.java) | `sizeof(int)` | sizeof表达式，与一元表达式中的`sizeof(a[10])`不同，此处的sizeof后面接的必须是某个类型 |
|[CastExpr](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/CastExpr.java) | `(struct A*)x` | 手动类型转化 |
|[PointerAccess](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/PointerAccess.java) | `a->first` | 指针表达式 |
|[RecordAccess](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/RecordAccess.java) | `a.second` | 记录表达式 |
|[SelfIncrement](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/SelfIncrement.java) | `a++` | 自增表达式 |
|[SelfDecrement](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/SelfDecrement.java) | `a--` | 自减表达式 |
|[ArrayAccess](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/ArrayAccess.java) | `a[2]` | 数组表达式 |
|[FunctionCall](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/FunctionCall.java) |`f(2, 3, 4)` | 函数调用 |
|[Identifier](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/Identifier.java) | `a` | 变量 |
|[IntConst](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/IntConst.java) | `3` | 整数常量 |
|[CharConst](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/CharConst.java) | 
|[StringConst](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/StringConst.java) | `"213"` | 字符串常量 |

## Symbol
在TA设计的AST中，有一个特殊的类，名为[Symbol](https://github.com/zeonsgtr/compiler2015/blob/master/framework/ast/Symbol.java)，这个类有什么用呢？
设计这个类是为了更方便的使用字符串，考虑下面的一段代码：
```Java
System.out.println(new String("aaaa") == new String("aaaa"));
```
这段代码会输出`false`，因为这样做比较的是两个指针。要想获得期望的结果，应该这样写
```Java
System.out.println(new String("aaaa").intern() == new String("aaaa").intern());
```
Symbol这个类就是为了方便比较字符串设计的，同时也提高了字符串比较的效率。

# Futher Reading
- [What is the difference between an Abstract Syntax Tree and a Concrete Syntax Tree?](http://stackoverflow.com/questions/1888854/what-is-the-difference-between-an-abstract-syntax-tree-and-a-concrete-syntax-tre)
- [How to view clang AST?](http://stackoverflow.com/questions/18560019/how-to-view-clang-ast)
- [Language Implementation Patterns](https://www.dropbox.com/s/oe5ycye26vee8cu/Language%20Implementation%20Patterns.pdf?dl=0),
    Chapter 4. Building Intermediate Form Trees
- [Modern Complier Implementation in Java](https://www.dropbox.com/s/dwlvimgu4f1ouyj/Modern%20Compiler%20Implementation%20in%20Java%2C%202nd%20ed.%28Andrew%20Appel_%20Cambrdige%20University%20Press%29%282004%29.pdf?dl=0)
    Chapter 4. Abstract Syntax
