## RunLoop

### 1、概念

​		RunLoop是通过内部维护的**事件循环**，来对**事件/消息**进行管理的一个对象

### 2、事件循环：

   - 没有消息需要处理时，休眠以避免资源占用
   - 有消息需要处理时，立刻被唤醒

![事件循环](https://i.loli.net/2021/10/06/ZYxirwVnN1K9DOG.png)

![RunLoop](https://i.loli.net/2021/10/06/sOTMpIzx58wcQLg.png)

### 3、数据结构

NSRunLoop是不开源的，CDRunLoop是开源的

![数据结构](https://i.loli.net/2021/10/06/odXT3jpaBcqRVEm.png)

- CFRunLoop

![CFRunLoop](https://i.loli.net/2021/10/06/vFT4Bgc6XU9MrRu.png)

- CFRunLoopMode

![CFRunLoopMode](https://i.loli.net/2021/10/06/XF1mnYVgHTKrN6S.png)

- CFRunLoopSource

![CFRunLoopSource](https://i.loli.net/2021/10/06/XH8qyEQ6p5gR7zD.png)

- CFRunLoopTimer

![CFRunLoopTimer](https://i.loli.net/2021/10/06/LjRbxqfMd3pVkz2.png)

- CFRunLoopObserver

  可以观测6个时间点

  - kCFRunLoopEntry                   进入RunLoop
  - kCFRunLoopBeforeTimers      即将处理Timers一些事件
  - kCFRunLoopBeforeSources   即将处理Sources一些事件
  - kCFRunLoopBeforeWaiting    即将进入休眠 **即将从用户态->内核态切换**
  - kCFRunLoopAfterWaiting       **内核态->用户态**切换后的不久
  - kCFRunLoopExit                     RunLoop退出

![数据关系](https://i.loli.net/2021/10/06/4RxQMYskIu7hGzi.png)

### 4、RunLoop的Mode

- 如果运行在一个Mode上，只能接受当前Mode的事件，其他Mode不会运行

![多Mode](https://i.loli.net/2021/10/06/mEOha5CeoxJ6K7b.png)

- CommonMode的特殊性

![CommonMode](https://i.loli.net/2021/10/06/m3rx2CvaZDdG1Fb.png)

### 5、事件循环的实现机制

- 启动会调用CDRunLoopRun( )方法

![实现机制](https://i.loli.net/2021/10/06/5i7nxr3gjSTshoQ.png)

🌰：main函数调用后会调用UIApplicationMain方法，方法内部会启动主线程的RunLoop，经过一系列处理，主线程的RunLoop处于休眠状态，此时点击一下屏幕会产生一个mach-port，会转换成一个Source1，唤醒主线程，然后运行处理，当程序被杀死就会退出RunLoop，线程被杀死。

### 6、RunLoop的核心

![RunLoop的核心](https://i.loli.net/2021/10/06/X3apHhluIMUvWst.png)

### 7、RunLoop与NSTimer

![RunLoop与NSTimer](https://i.loli.net/2021/10/06/vYBmzUD7hp1io8M.png)

- void CFRunLoopAddTimer(runLoop, timer, commonMode)

![CFRunLoopAddTimer](https://i.loli.net/2021/10/06/S4ib6GMyOsKgDaV.png)

- **void** __CFRunLoopAddItemToCommonModes(**const** **void** *value, **void** *ctx)

![CFRunLoopAddItemToCommonModes](https://i.loli.net/2021/10/06/lf9YFCywdxLQGp6.png)

### 8、RunLoop与多线程

![RunLoop与多线程](https://i.loli.net/2021/10/06/4F5K7XYDjatbue1.png)

- 常驻线程

  获取当前线程的RunLoop，如果当前线程没有RunLoop会自动创建一个

```objective-c
[NSRunLoop currentRunLoop];
```

![image-20211006121545588](https://i.loli.net/2021/10/06/NZg3n9Ty2KmFIGi.png)

- 创建一个常驻线程

![常驻线程](https://i.loli.net/2021/10/06/N16PgMA8H5LzmOX.png)

