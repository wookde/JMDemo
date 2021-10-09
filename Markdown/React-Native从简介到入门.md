# React-Native入门

## 一、介绍

|     种类     |   实现技术    |         编程语言         |   公司   |
| :----------: | :-----------: | :----------------------: | :------: |
|   Cordova    |  JavaScript   | 使用HTML,CSS和JavaScript |  Adobe   |
| React-Native |  JavaScript   |          React           | FaceBook |
|   Flutter    | 原生编码/渲染 |           Dart           |  Google  |
|     Weex     |  JavaScript   |           Vue            | Alibaba  |

## 二、React-Natve环境搭建

- #### **[安装Node.js](https://nodejs.org/zh-cn/)**

  ```
  brew install node
  ```

  

- #### **安装watchman**

  ```
  brew install watchman
  ```

- #### **Yarn**

  npm为Node.js的一个包管理工具，类此于Linux的apt等，Node.js内置了npm无需单独下载。

  [Yarn](http://yarnpkg.com/)是 Facebook 提供的替代 npm 的工具，可以加速 node 模块的下载。

  ```
  npm install -g yarn
  ```

- #### **Android Studio / Xode(Cocopods)**

- #### **Visual Studio Code**

## 三、创建一个新项目

- 普通的

  ```
  npx react-native init RNProject
  ```

- 指定RN版本的

  ```
  npx react-native init RNProject --version X.XX.X
  ```

- 还可以使用`--template`来使用一些社区提供的模板，例如带有`TypeScript`配置的：

  ```
  npx react-native init AwesomeTSProject --template react-native-template-typescript
  ```

## 四、已有项目的集成

- #### react-native在0.60 及以上版本的原生依赖是通过 CocoaPods 集成安装的。

- 详情可以看之前的文章： [传送门](https://www.jianshu.com/p/3fa352d41698)

## 五、Debug

#### 1、项目运行起来，摇一摇，选择Debug，系统默认浏览器，会自动打开一个网页，使用Chrome，因为Safari会出现乱码

```
http://localhost:8081/debugger-ui/
```

#### 2、在Chrome中右击，选择检查

![web检查器](https://i.loli.net/2021/08/31/DOZFdCbwlypfgRu.png)

使用command + o 搜索对应Debug的js文件，打断点，并运行

![Debug](https://i.loli.net/2021/08/31/u4irvbhx1NQYmPd.png)

## 六、Flexbox布局

|      属性      |           解释           |                            值                             |   默认值   |
| :------------: | :----------------------: | :-------------------------------------------------------: | :--------: |
| flexDirection  |     子组件的排列方向     |         column、row、column-reverse、row-reverse          |   column   |
| justifyContent | 子组件在主轴方向排列位置 | flex-start、flex-end、center、space-between、space-around | flex-start |
|   alignItem    | 子组件在侧轴方向排列位置 |        auto、flex-start、flex-end、center、stretch        |  stretch   |
|   alignSelf    |       组件自己本身       |        auto、flex-start、flex-end、center、stretch        |            |
|    flexWrap    |  子组件单行还是多行显示  |                       wrap、nowrap                        |    wrap    |
|      flex      |  子组件占用父组件的比例  |                                                           |     0      |

如果不了解CSS布局的，可能会比较懵，这里再具体解释一下，我们先来了解一下主轴和侧轴的概念

![主轴和侧轴](https://i.loli.net/2021/08/31/UnM2dtCNwJlz7su.png)

- 如果flexDirection为row，那么主轴就是x轴0 -> ∞ 方向，此时侧轴就是y轴 0 -> ∞ 方向

  justifyContent：控制在x轴方向的位置，flex-start就是靠左，flex-end就是靠右。

  alignItem：控制y轴方向的位置，flex-start就是靠上，flex-end就是靠下。

- 如果flexDirection为column，那么主轴就是y轴0 -> ∞ 方向，此时侧轴就是x轴 0 -> ∞ 方向

  justifyContent：控制y轴方向的位置，flex-start就是靠上，flex-end就是靠下。

  alignItem：控制在x轴方向的位置，flex-start就是靠左，flex-end就是靠右。

## 七、常用的组件

- #### **View**

- #### **Text**

- #### **TextInput**

- #### **Image**

  ```
  <Image source={require('./img/icon.png')} style={styles.imageStyle} />
  ```

- #### **ScrollView**

- #### **WebView**

- #### **FlaList**

## 八、其他

#### 1、**接口**

- props：对外的接口
- state：对内的接口

#### 2、**声明周期**

- React-Nativ组件的声明周期大体分为3个阶段，挂载、更新、卸载，其中挂载和更新阶段都会调用render()方法绘制视图

  组件的每个声明周期都提供了一些方法供我们调用，用来实现相应的需求和功能。

  ![组件的声明周期](https://i.loli.net/2021/08/31/ebxTNl5nj9ay8Qk.png)

- **挂载阶段**

  指的是组件的实例被创建到将其插入到DOM的过程

  |       函数名称       |                             解释                             |
  | :------------------: | :----------------------------------------------------------: |
  |    defaultProps()    | 此阶段主要用于初始化一些默认属性，在ES6语法中，则统一使用static成员来定义。 |
  |    constructor()     | 此方法是组件的构造方法，可以在此阶段对组件的一些状态进行初始化。不同于defaultProps(),此方法定义的变量可以通过this.setState进行修改。 |
  | componentWillMount() | 在挂载前被立即调用。它在render()方法之前被执行，因此在此方法中设置 state 不会导致重新渲染。 |
  |       render()       | 此方法主要用于渲染组件，返回JSX或其他组件构成DOM.同时，此方法 |
  | componentDidMount()  | 此方法在挂载结束之后立马调用，也就是在render()方法后执行。开发者可以在此方法中获取元素或者子组件，也可以在层次方法中执行网络请求操作 |

- **运行阶段**

  当组件经过初始化后，程序就运行起来了，运行阶段无论是修改props还是state，系统都会调用shouldComponentUpdate()方法来判断视图是都需要渲染，如果需要渲染就会执行render()方法执行视图重绘，修改props的会比修改state多一个步骤，props会先调用componentWillReceiveProps()方法接收props后，再判断是否需要执行更新

  运行阶段的声明周期

  |          函数名称           |                             解释                             |
  | :-------------------------: | :----------------------------------------------------------: |
  | componentWillReceiveProps() | 在挂载的组件接收到新的props时被调用。它接收一个 Object类型的参数 nextProps，然后调用 this setState来更新组件的状态。 |
  |   shouldComponentUpdate()   | 当组件接收到新的 props或 state时此方法就会被调用。此方法默认返回true，用来保证数据变化时组件能够重新渲染。当然，开发者也可以重载此方法来决定组件是否需要执行重新渲染。 |
  |    componentWillUpdate()    | 如果shouldComponentUpdate()方法返回为true，则此方法会在组件重新渲染前被调用。 |
  |    componentDidUpdate()     |    在组件重新渲染完成后被调用，可以在此函数中得到渲染完。    |

- **卸载阶段**

  主要指组件从挂载阶段到将其从DOM中删除的过程，是组件生命周期的终点。

  除了正常移除组件外，组件的销毁还可能是由其他情况引起的，如系统遇到错误崩溃、系统内存空间不足，以及用户退出应用等。

  |        函数名称        |                        解释                        |
  | :--------------------: | :------------------------------------------------: |
  | componentWillUnmount() | 在组件卸载和销毁之前被立即调用。可以在此方法中执行 |

- **函数的调用次数**

  在组件的整个生命周期中，每一个生命周期函数并不是只被调用一次，有的生命周期函数在整个生命周期阶段可能被调用多次

  |         函数名称          |   调用次数   | 是否更新状态 |
  | :-----------------------: | :----------: | :----------: |
  |       defaultProps        | 1(全局仅1次) |      否      |
  |        constructor        |      1       |      否      |
  |    componentWillMount     |      1       |      是      |
  |          render           |      ≥1      |      否      |
  |     componentDidMount     |      1       |      是      |
  | componentWillReceiveProps |      ≥0      |      是      |
  |   shouldComponentUpdate   |      ≥0      |      否      |
  |    componentWillUpdate    |      ≥0      |      否      |
  |    componentDidUpdate     |      ≥0      |      否      |
  |   componentWillUnmount    |      1       |      否      |

- **虚拟DOM**
 &ensp;&ensp;&ensp;&ensp;众所周知，Web界面本质上是由DOM树构成的，当其中某个部分发生变化时，其实就是对应的DOM节点发生了变化。
  &ensp;&ensp;&ensp;&ensp;在 jQuery出现以前，前端开发人员如果要修改界面，需要直接操作DOM节点。在这一时期，程序的代码结构混乱，复杂度高、可维护性和兼容性都较差。不过，随着 jQuery以及高度封装AP的出现，开发人员慢慢地从烦琐的DOM操作中解脱出来。MVM使用的数据双向绑定和自动更新技术使得前端开发效率大幅提升，但是大量的事件绑定导致的执行性能低下的问题依然存在。
  &ensp;&ensp;&ensp;&ensp;那么有没有一种兼顾开发效率和执行效率的方案呢？答案是有的。 ReactJS就是这么一种同时兼顾开发效率和执行效率的技术框架虽然其JSX语法受到很多开发者的质疑，但是它的虚拟DOM技术却得到了开发者的一致认可。此外，Vue框架也在2.0版本引入了这一机制。
  &ensp;&ensp;&ensp;&ensp;React中的组件并不是真实的DOM节点，而是存在于内存之中的一种数据结构，叫作虚拟DOM。只有当它被插入文档以后，才会变成真实的DOM 

  ![虚拟DOM](https://i.loli.net/2021/08/31/Elgt5GajTesDPxd.png)


  根据 React的设计，所有的DOM变动都需要先反映在虚拟DOM上，再将实际发生变动的部分反映在真实DOM上，而这一过程的核心就是 DOM diff算法它可以减少不必要的DOM渲染，极大地提高组件的渲染性能。

  
