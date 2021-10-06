## Block

#### 1、介绍

   Block是将**函数**及其**执行上下文**封装起来的**对象**

#### 2、代码编译

```shell
clang -rewrite-objc -fobjc-arc JMBlock.m
```

- 源码

![源码](https://i.loli.net/2021/10/06/7oiBS3IqWOYpz42.png)

- 编译后

![image-20211006180213262](https://i.loli.net/2021/10/06/4E3BHUpAke8aKQ2.png)

JMBlock__method_block_impl_0

![JMBlock__method_block_impl_0](https://i.loli.net/2021/10/06/5P4VlbLvsxjtCSy.png)

![__block_imp](https://i.loli.net/2021/10/06/E6tWdqPiHa7Ycz5.png)

__JMBlock__method_block_func_0：blcok内部具体实现部分

![__JMBlock__method_block_func_0](https://i.loli.net/2021/10/06/yZPUxuc1q4SpYgf.png)

- 调用

![调用](https://i.loli.net/2021/10/06/Iycd9KMiQxzSk73.png)

#### 3、截获变量

- 局部变量：

  基本数据类型：截获其值

  静态变量：截获其指针

  对象类型：连同所有权修饰符一起截获

- 不截获全局变量、静态全局变量

  编译

  ```
  clang -rewrite-objc -fobjc-arc JMBlock.m
  ```

  编译前

  ![编译前](https://i.loli.net/2021/10/06/qrLuh9MBnASklHt.png)

  编译后

  ![编译后](https://i.loli.net/2021/10/06/35t4wQyBgDFO7dK.png)

  方法实现

  ![方法实现](https://i.loli.net/2021/10/06/GgnA2EcYsPVTlaH.png)

#### 4、__block修饰符

- **一般情况下**，对被截获变量进行**赋值**操作需要添加__block修饰符(赋值 != 使用 )

- 需要用__block修饰的

  局部变量：基本数据类型、对象类型进行赋值

- 不需要__block修饰的

  静态局部变量、全局变量、静态全局变量进行赋值

- 问题1：

  ![问题1](https://i.loli.net/2021/10/06/ltGLDpUPSsjrHTn.png)

- 问题2

  ![问题2](https://i.loli.net/2021/10/06/Erx1lCYKgFSGJa3.png)

- 问题3

  ![问题3](https://i.loli.net/2021/10/06/l6rJCE4WesBGLUc.png)

​		分析：		![分析](https://i.loli.net/2021/10/06/UHg419bMtBqE2LR.png)

![分析2](https://i.loli.net/2021/10/06/OLz45tWZpm8Ss12.png)

#### 5、Block的类型

栈上的、堆上的、全局的，三种类型

![Block的类型](https://i.loli.net/2021/10/06/6TDAuteUjowdkln.png)

#### 6、Block的Copy操作

![Block的Copy操作](https://i.loli.net/2021/10/06/PXaqK9rHEwyU1Bh.png)

- 栈上Block的销毁

![image-20211006215418733](https://i.loli.net/2021/10/06/Hyapnv5WUs8MeKG.png)

- 堆上面的Block的销毁

  在MRC环境下，如果对栈上的Block进行Copy，会在堆上Copy一份，相当于alloc了一个对象，如果没有其他成员变量指向这个block，并且不进行release，那么会造成内存泄漏。

![堆上面的Block的销毁](https://i.loli.net/2021/10/06/q63jYHhsJN2f8zR.png)

#### 7、__forwarding的作用

- 如果栈上的block未被copy到堆上，则multiplier.__forwarding->multiplier = 4，是修改的栈上的值
- 如果栈上的block被copy到堆上，则multiplier.__forwarding->multiplier = 4，是修改的堆上的值使用栈上的block变量的时候，也是会查找堆上的变量值。

![copy](https://i.loli.net/2021/10/06/w2BpgyaT173Wzvs.png)

#### 8、block的循环引用

属性 != 成员变量 != 全局变量

成员变量_array会被block捕获

- 问题1：

![循环引用](https://i.loli.net/2021/10/06/76yk94GpBoLrzwQ.png)

答案

![答案](https://i.loli.net/2021/10/06/J2gGeLO48twBEzT.png)

- 问题2

![问题2](https://i.loli.net/2021/10/06/Ew8LIxh3jUczl2W.png)

答案：

![答案1](https://i.loli.net/2021/10/06/7niCkwgpWMLVx8f.png)

![答案2](https://i.loli.net/2021/10/06/KvSLQ8l2dmxnG97.png)

如果block长时间不调用，循环引用就会一直存在

![答案3](https://i.loli.net/2021/10/06/9nc8UlICBYZMpLz.png)