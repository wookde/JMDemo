## 背景
- 最近公司有了一个创新项目，就是在视频视图之上添加一层视图，视图设计涉及到了复杂的控件动画，会根据视频的播放，显示一些控件，控件有位移、缩放、旋转、shake等动画。
- 在网上调研了一下，对比了苹果的CoreAnimation，觉得Facebook_Pop使用起来更加简单一些，并且有很多优点。
- 在使用中，遇到了一个bug，Pop的kPOPLayerRotationY存在Bug，大于90度就会出错。

![pop bug](https://img-blog.csdnimg.cn/img_convert/40b186944c21fd85f86c7404829a8bae.gif#pic_center =248x440) 

## Pop介绍
![pop](https://img-blog.csdnimg.cn/img_convert/6a560d31f382663a39224aad5fdf8ef4.gif#pic_center)

-  [Pop的Github](https://github.com/facebookarchive/pop)

- Facebook 在发布了 Paper 之后，似乎还不满足于只是将其作为一个概念性产品，更进一步开源了其背后的动画引擎 [POP](https://github.com/facebook/pop)，此举大有三年前发布的 iOS UI 框架 [Three20](https://github.com/facebookarchive/three20) 的意味。而 POP 开源后也不负 Facebook 的厚望。

- POP背后的开发者是 [Kimon Tsinteris](http://kimtsi.com/)， Push Pop Press 的联合创始人，曾经在Apple担任高级工程师，并参与了 iPhone 和 iPad 上软件的研发(iPhone的指南针以及地图)。2011年的时候 Facebook 收购了他的公司，此后他便加入了 Facebook 负责 Facebook iOS 版本的开发。

- 如果你打开 Push Pop Press 开发的 AI Gore 这款 App，你会发现交互和动画与Paper几乎如出一辙。对，他们都是 Kimon Tsinteris 开发的。

- 不满于 Apple 自身动画框架的单调，Push Pop Press 致力于创造一个逼真的、充满物理效应的体验。 POP 就是这个理念下最新一代的成果。

- POP 使用 Objective-C++ 编写，Objective-C++ 是对 C++ 的扩展，就像 Objective-C 是 C 的扩展。而至于为什么他们用 Objective-C++ 而不是纯粹的 Objective-C，原因是他们更喜欢 Objective-C++ 的语法特性所提供的便利。

## 继承关系
![WX20210804-160255@2x.png](https://img-blog.csdnimg.cn/img_convert/cb81842111eb59e2c566338bff6da1e0.png)

## POPAnimation
- 属性
```
// 动画名称
@property (copy, nonatomic) NSString *name;
// 开始时间，默认立即开始
@property (assign, nonatomic) CFTimeInterval beginTime;

// 代理
@property (weak, nonatomic) id delegate;

// 事件追踪
@property (readonly, nonatomic) POPAnimationTracer *tracer;

// 开始的block
@property (copy, nonatomic) void (^animationDidStartBlock)(POPAnimation *anim);

// 动画触发toValue值的block
@property (copy, nonatomic) void (^animationDidReachToValueBlock)(POPAnimation *anim);

// 动画完成的回调
@property (copy, nonatomic) void (^completionBlock)(POPAnimation *anim, BOOL finished);

// 动画每一帧的回调
@property (copy, nonatomic) void (^animationDidApplyBlock)(POPAnimation *anim);

// 动画是否在结束后移除，默认为YES
@property (assign, nonatomic) BOOL removedOnCompletion;

// 暂停
@property (assign, nonatomic, getter = isPaused) BOOL paused;

// 动画是否返回原来的状态，以动画形式返回
@property (assign, nonatomic) BOOL autoreverses;

// 重复次数
@property (assign, nonatomic) NSInteger repeatCount;

// 是都永远重复
@property (assign, nonatomic) BOOL repeatForever;
```

## POPPropertyAnimation
- 属性
```
// 动画的属性，我们可以借助此属性，做一些自定义
@property (strong, nonatomic) POPAnimatableProperty *property;

// 动画开始的值
@property (copy, nonatomic) id fromValue;

// 动画结束的值
@property (copy, nonatomic) id toValue;

// 动画的细腻度，设置很大的值会有bug 【0,1】
@property (assign, nonatomic) CGFloat roundingFactor;

// 没理解
@property (assign, nonatomic) NSUInteger clampMode;

// 没理解
@property (assign, nonatomic, getter = isAdditive) BOOL additive;
```

## POPBaseAnimation
- 初始化方法，一般使用下面的初始化方法
```
+ (instancetype)animationWithPropertyNamed:(NSString *)name;
```

- 动画方式属性：timingFunction
````
// 线性的
kCAMediaTimingFunctionLinear
// 慢->快
kCAMediaTimingFunctionEaseIn
// 快->慢
kCAMediaTimingFunctionEaseOut
// 慢->快->慢
kCAMediaTimingFunctionEaseInEaseOut
````
- 动画时长：duration

- 例子1：简单的位移
```
POPBasicAnimation *baseAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
baseAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
    NSLog(@"动画完成”);
};

baseAnim.duration = 0.5;
baseAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
baseAnim.fromValue = @(self.demoView.center);
baseAnim.toValue = @(self.view.center);
[self.demoView pop_addAnimation:baseAnim forKey:@"baseAnim”];
```
- 效果图1
![效果1](https://img-blog.csdnimg.cn/img_convert/693b43dfd10cbf879ffcb16f55b587e9.gif#pic_center =248x440)

- 例子2：倒计时
```
POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
    prop.writeBlock = ^(id obj, const CGFloat *values) {
        NSLog(@"%d", (int)values[0]);
        int value = (int)values[0];
        NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", value/60, value%60,(int)(values[0]*100)%100];
        self.label.text = timeStr;
    };
}];

POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
anBasic.property = prop;    //自定义属性
anBasic.fromValue = @(1*60);   //从0开始
anBasic.toValue = @(0);  //180秒
anBasic.duration = 3*60;    //持续3分钟
anBasic.beginTime = CACurrentMediaTime();    //延迟1秒开始
[self.label pop_addAnimation:anBasic forKey:@"countdown”];
```
- 效果图2
![效果图2](https://img-blog.csdnimg.cn/img_convert/4d899980aad4e11372b1bb09623f7ce0.gif#pic_center =248x440)

## POPSpringAnimation
- 构造方法
```
+ (instancetype)animationWithPropertyNamed:(NSString *)name;
```
- 属性
```
// 初始速度
@property (copy, nonatomic) id velocity;

// 弹力 [0,20]，默认为4
@property (assign, nonatomic) CGFloat springBounciness;

// 弹簧速度 [0,20]，默认为12
@property (assign, nonatomic) CGFloat springSpeed;

// 拉力，张力
@property (assign, nonatomic) CGFloat dynamicsTension;

// 摩擦力
@property (assign, nonatomic) CGFloat dynamicsFriction;

// 质量
@property (assign, nonatomic) CGFloat dynamicsMass;
```
- 例子3：弹性移动
```
POPSpringAnimation *anSpr = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
anSpr.completionBlock = ^(POPAnimation *anim, BOOL finished) {
    NSLog(@"动画完成”);
};
anSpr.springSpeed = 100;
anSpr.springBounciness = 20.0;
anSpr.fromValue = @(self.demoView.center);
anSpr.toValue = @(self.view.center);
[self.demoView pop_addAnimation:anSpr forKey:@"anSpr”];
```
- 效果图3
![效果图3](https://img-blog.csdnimg.cn/img_convert/b25f5183bf3b533faf7c66be3e21c92c.gif#pic_center =248x440)

## POPDecayAnimation
- Decay Animation 就是 POP 提供的另外一个非常特别的动画，他实现了一个衰减的效果。这个动画有一个重要的参数 velocity（速率），一般并不用于物体的自发动画，而是与用户的交互共生。这个和 iOS7 引入的 UIDynamic 非常相似，如果你想实现一些物理效果，这个也是非常不错的选择。

- Decay 的动画没有 toValue 只有 fromValue，然后按照 velocity 来做衰减操作。

-例子4：衰减转动
```
- (void)jumpAnimation {
    
    [self.demoView.layer pop_removeAllAnimations];
    POPDecayAnimation *anRotaion=[POPDecayAnimation animation];
    anRotaion.property = [POPAnimatableProperty propertyWithName:kPOPLayerRotation];
    
    if (self.animated) {
        anRotaion.velocity = @(-150);
    }else{
        anRotaion.velocity = @(150);
        anRotaion.fromValue =  @(25.0);
    }
    
    self.animated = !self.animated;
    
    anRotaion.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self jumpAnimation];
        }
    };
    
    [self.demoView.layer pop_addAnimation:anRotaion forKey:@"myRotationView”];
}
```
- 效果图4
![效果图4](https://img-blog.csdnimg.cn/img_convert/1939ce5684bbbcc170a055aa422a6d7c.gif#pic_center =248x440)

## 值得关注的 POP 周边

- [POP-HandApp ](https://github.com/kevinzhow/pop-handapp) 这就是本文的示例App，包含了大量动画的操作方法和上述介绍的实例。

- [AGGeometryKit-POP](https://github.com/hfossli/aggeometrykit-pop)  通过 POP 对图片进行变形操作，非常酷。

- [POP-MCAnimate](https://github.com/matthewcheok/POP-MCAnimate)  POP 的一个封装，可以让你更方便的使用 POP。

- [Rebound](http://facebook.github.io/rebound/)  POP 的 Android 部分实现，主要是 Spring 的效果，移植自 Facebook 的rebound-js。
