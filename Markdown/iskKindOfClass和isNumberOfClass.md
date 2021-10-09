```objective-c
- (BOOL)isKindOfClass:(Class)aClass;
- (BOOL)isMemberOfClass:(Class)aClass;
```

我们来看看这两个方法有什么不同，首先看看问题

```objective-c
BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
BOOL res3 = [(id)[JMObjectA class] isKindOfClass:[JMObjectA class]];
BOOL res4 = [(id)[JMObjectA class] isMemberOfClass:[JMObjectA class]];
```

输出结果为

```
YES
NO
NO
NO
```

那么为什么呢？我们来看一下两个方法的源码实现

![源码实现](https://i.loli.net/2021/10/08/s51Z2JIPB6ALvnd.png)

先把Runtime的对象模型拿出来，方便后面的分析。

![对象模型](https://i.loli.net/2021/10/08/abLTH4fPcNoG5qh.png)

- 1

```objective-c
BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
```

[NSObject class]，是个类方法，上面源码中直接返回self，也就是NSObject，代码简化成

```
[NSObject isKindOfClass NSObject]
```

isKindOfClass源码实现中：

第一次for循环：NSObject -> ISA( )，也就是NSObject的根元类，肯定不等于NSObject

第二次循环：NSObject的根元类的getSuperclass( )，就是NSObject，所以相等，返回YES.

- 2

```
BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
```

同样简化为

```
[NSObject isMemberOfClass NSObject]
```

isMemberOfClass源码实现中：

NSObject -> isa 等于 根元类 不等于 NSObject，返回NO.

- 3

```objective-c
BOOL res3 = [(id)[JMObjectA class] isKindOfClass:[JMObjectA class]];
```

简化

```
[JMObjectA isKindOfClass JMObjectA]
```

第一次for循环：JMObjectA -> ISA( )，为JMObjectA的元类，不等于JMObjectA

第二次for循环：JMObjectA的元类 -> ISA( )，为根元类，不等于JMObjectA

第三次for循环：根元类 -> ISA( )，还是根元类，不等于JMObjectA 所以返回NO.

- 4

```
BOOL res4 = [(id)[JMObjectA class] isMemberOfClass:[JMObjectA class]];
```

简化

```
[JMObjectA isMemberOfClass JMObjectA]
```

JMObjectA -> isa，为JMObjectA的元类，不等于JMObjectA，所以返回NO.