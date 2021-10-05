## Runtime

### 一、数据结构

![基础数据结构](https://i.loli.net/2021/10/05/k5ZYCv874G1TxVt.png)

#### 1、objc_object

id = objc_object  : isa_t为共用体

![objc_objcet](https://i.loli.net/2021/10/05/BqUr5b2s4PHyfgx.png)

#### 2、objc_class

Class = objc_class: Class也是对象,称之为类对象，因为它继承自onjc_object

![objc_class](https://i.loli.net/2021/10/05/96TzaBrUOuoAW1Q.png)

#### 3、isa_t

有两种类型，指针型isa、非指针型isa

![isa_t](https://i.loli.net/2021/10/05/rgE9czvs3J6yxCf.png)

![isa指向](https://i.loli.net/2021/10/05/oyTMviZmdszLREg.png)

#### 4、cach_t

![cach_t](https://i.loli.net/2021/10/05/cExRizbj62LloA1.png)

![cache_t](https://i.loli.net/2021/10/05/rdGFNZHqzm3toPR.png)

#### 5、class_data_bits_t

![class_data_bits_t](https://i.loli.net/2021/10/05/Fr1BKkTq6L98Dvg.png)

#### 6、class_rw_t

例如分类1中添加的方法会在methods二维数组中的某个数组中存储

![class_rw_t](https://i.loli.net/2021/10/05/5o6qUTp9XNWBVEM.png)

#### 7、class_ro_t

name：类名，可以通过NSClassFromString(name)获取该类

ivars：成员变量

properties：属性

![class_ro_t](https://i.loli.net/2021/10/05/1SNGjw9IhBruiPo.png)

#### 8、method_t

Const char* types: 函数的返回和参数的组合

![method_t](https://i.loli.net/2021/10/05/JIVylEUSMqgPh3Q.png)

#### 9、Type Encodings

第一个参数@代表一个对象，第一个参数和第二个参数是固定的，@代表的是谁调用的，也就是self，第二个：表达的是方法选择器

![Type Encodings](https://i.loli.net/2021/10/05/vElCU3xgPSYsFI5.png)

10、对象、类对象、元类对象

![对象、类对象、元类对象](https://i.loli.net/2021/10/05/OUuhYZS2DR8GQzx.png)

Root class指的就是NSObject

如果一个实例方法在元类对象以及根元类对象中都没有，会查找根类对象中的同名实例方法，并调用。

![指向](https://i.loli.net/2021/10/05/AfQsIj6wYoPBJ2p.png)

### 问题

[self class];

[super class];

![[self class]](https://i.loli.net/2021/10/05/fzAinHM9poqtsLw.png)

![[super class]](https://i.loli.net/2021/10/05/axkEvo2JruzlPnV.png)

## 二、消息传递

![消息传递](https://i.loli.net/2021/10/05/iYLwWvt7N5Raprd.png)

#### 1、缓存查找

哈希查找

![哈希查找](https://i.loli.net/2021/10/05/lxwdspjvgL6X1nK.png)

#### 2、在类对象中查找

![类查找](https://i.loli.net/2021/10/05/6HxtuUXRAYFv53j.png)

#### 3、父类逐级查找

![父类逐级查找](https://i.loli.net/2021/10/05/3rfBFtZ29v4jdXq.png)

#### 4、消息转发

![消息转发](https://i.loli.net/2021/10/05/GhXmVRbH185qCeO.png)

a、动态解析

​	我们可以根据方法类型(实例方法or类方法)重写一下方法，为类动态添加方法

 	 +(BOOL)resolveInstanceMethod:(SEL)sel

​	  +(BOOL)resolveClassMethod:(SEL)sel

​	  在方法中调用一下方法来动态添加方法的实现

​	  ** 参数1:给哪个类添加

​	  ** 参数2:给哪个方法添加

​	  ** 参数3:方法的实现地址

​	  ** 参数4:方法的编码类型

​	  BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)

![动态解析](https://i.loli.net/2021/10/05/cP6snXZOho9jzlv.png)

![动态解析](https://i.loli.net/2021/10/05/BDuKvdVW3LgJ8Uz.png)

b、消息转发

消息转发分为两步进行: Fast forwarding和 Normal forwarding

  1> Fast forwarding : 将消息转发给一个其他的OC对象(找一个备用接收者)

​    重写以下方法,返回一个其他对象即可

​    +/- (id)forwardingTargetForSelector:(SEL)aSelector

![Fast forwarding](https://i.loli.net/2021/10/05/wASjFZbsdIUKm68.png)

  2> Normal forwarding : 实现一个完整的消息转发过程

​    如果Fast forwarding没有解决可以重写以下两个方法启动完整的消息的转发

​    +/- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector

​    Runtime 会根据这个方法签名，创建一个NSInvocation对象（NSInvocation封装了未知消息的全部内容，

​    包括：方法调用者 target、方法名 selector、方法参数 argument 等），

​    然后调用第二个方法并将该NSInvocation对象作为参数传入。

​    +/- (void)forwardInvocation:(NSInvocation *)invocation

​    在该方法中：将未知消息转发给其它对象；改变未知消息的内容(如方法名、方法参数)再转发给其它对象；甚至可以定义任何逻辑。

![Normal forwarding](https://i.loli.net/2021/10/05/Jjs4XDIFGK1lgkp.png) 

​    ⚠️如果第一个方法中没有返回方法签名，或者我们没有重写第二个方法，系统就会认为我们彻底不想处理这个消息了，

​    这时候就会调用以下方法

​    +/- (void)doesNotRecognizeSelector:(SEL)sel

​    方法并抛出经典的 crash:unrecognized selector sent to instance/class，结束 objc_msgSend 的全部流程。