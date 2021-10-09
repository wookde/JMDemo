## 一、背景

我们想要实现RN的热更新，这里使用CodePush

React-native-code-push`是微软针对React-native推出的热更新服务。[CodePush官方文档](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2FMicrosoft%2Freact-native-code-push)。

## 二、CodePush的使用

### 1、CodePush CLI安装

安装CodePush指令，直接在终端上输入如下命令即可，注意：这个CodePush指令只需要全局安装一次即可，如果第一次安装成功了，那后面就不在需要安装

```shell
npm install -g code-push-cli
```

### 2、注册CodePush账号

注册CodePush账号也很简单，同样是只需简单的执行下面的命令，同样这个注册操作也是全局只需要注册一次即可。

```shell
code-push register
```

当执行完上面的命令后，会自动打开一个授权网页，让你选择使用哪种方式进行授权登录，这里我们统一就选择使用GitHub即可。

![登录方式](https://upload-images.jianshu.io/upload_images/4758483-e66c77f5ec21ace0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


当注册成功后，CodePush会给我们一个key。然后把这个key复制下来填入终端即可登录成功。

![登录的key](https://upload-images.jianshu.io/upload_images/4758483-cdf94d8083822e98.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![登录成功](https://upload-images.jianshu.io/upload_images/4758483-cd3ed9465c6c8c5c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


当然你可以使用以下命令验证是否登录成功：

```shell
code-push login
```

当有如下报错时，说明你已经登录成功了。

```shell
[error] You are already logged in from this machine.
```

下面是一些常用操作指令：

```shell
code-push login 登陆
code-push loout 注销
code-push access-key ls 列出登陆的token
code-push access-key rm <accessKye> 删除某个 access-key
```

### 3、在CodePush服务器注册App

为了让CodePush服务器有我们的App，我们需要CodePush注册App，输入下面命令即可完成注册，这里需要注意如果我们的应用分为iOS和Android两个平台，这时我们需要分别注册两套key 应用添加成功后就会返回对应的production 和 Staging 两个key，production代表生产版的热更新部署，Staging代表开发版的热更新部署，在ios中将staging的部署key复制在info.plist的CodePushDeploymentKey值中，在android中复制在Application的getPackages的CodePush中。

注册iOS APP：

```shell
code-push app add RNDemo_iOS ios react-native
```

![iOS](https://upload-images.jianshu.io/upload_images/4758483-c6bd6f5ca17a8f3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


注册Android APP：

![Android](https://upload-images.jianshu.io/upload_images/4758483-98b3145de18236f3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

查看注册过的APP：

```shell
code-push app list
```

![已注册的App](https://upload-images.jianshu.io/upload_images/4758483-71bbdf7cd355dc4c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


其它CodePush管理APP指令：

```shell
code-push app add 在账号里面添加一个新的app
code-push app remove 或者 rm 在账号里移除一个app
code-push app rename 重命名一个存在app
code-push app list 或则 ls 列出账号下面的所有app
code-push app transfer 把app的所有权转移到另外一个账号
```

### 4、RN代码中集成CodePush

上面都是一些准备工作，从这里开始才是真正的集成到项目中。首先我们需要安装CodeoPush组件，然后通过link命令添加原生依赖，最后在RN根组件中添加热更新逻辑代码.

安装组件：

```shell
npm install react-native-code-push --save
```



添加依赖：

```shell
react-native link react-native-code-push
```



### 5、配置iOS工程

打开Podfile文件加入

```ruby
pod 'CodePush', :path => '../RNCode/node_modules/react-native-code-push'
```

 执行pod install

```shell
pod install
```

打开info.plist文件

添加CodePushDeploymentKey：值为Production的值

Bundle version string (short)的值改为1.0.0

打开KGRNManager.m

导入

```objective-c
#import <CodePush/CodePush.h>
```

修改下面的方法

```objective-c
#pragma mark - RCTBridgeDelegate
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
# if DEBUG
    //模拟器
   // return [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    return [NSURL URLWithString:@"http://192.168.2.102:8081/index.bundle?platform=ios"];
    
  //真机，真机和电脑处于同一ip地址
//  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"main" fallbackResource:nil];
# else
//    return [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"jsbundle"];
    return [CodePush bundleURL];
#endif
}
```

### 6、index.js文件配置

一般常见的应用内更新时机分为两种，一种是打开App就检查更新，一种是放在设置界面让用户主动检查更新并安装。

###### 打开APP就检查更新：

最为简单的使用方式在React Natvie的根组件的componentDidMount方法中通过 codePush.sync()（需要先导入codePush包：import codePush from 'react-native-code-push'）方法检查并安装更新，如果有更新包可供下载则会在重启后生效。不过这种下载和安装都是静默的，即用户不可见。如果需要用户可见则需要额外的配置。具体可以参考codePush官方API文档。

```javascript
import codePush from "react-native-code-push";

class App extends Component {
    ...
    componentDidMount () {
        codePush.sync({
          updateDialog: true, // 是否打开更新提示弹窗
          installMode: codePush.InstallMode.IMMEDIATE,
          mandatoryInstallMode: codePush.InstallMode.IMMEDIATE,
          deploymentKey: 'Pay3W7Nfaa3bLG9C9ZXTwMgS7zMD68d21987-8919-4d4e-8062-52c8293250cb',
          //对话框
          updateDialog : {
            //是否显示更新描述
            appendReleaseDescription : true ,
            //更新描述的前缀。 默认为"Description"
            descriptionPrefix : "更新内容：" ,
            //强制更新按钮文字，默认为continue
            mandatoryContinueButtonLabel : "立即更新" ,
            //强制更新时的信息. 默认为"An update is available that must be installed."
            mandatoryUpdateMessage : "必须更新后才能使用" ,
            //非强制更新时，按钮文字,默认为"ignore"
            optionalIgnoreButtonLabel : '稍后' ,
            //非强制更新时，确认按钮文字. 默认为"Install"
            optionalInstallButtonLabel : '后台更新' ,
            //非强制更新时，检查到更新的消息文本
            optionalUpdateMessage : '有新版本了，是否更新？' ,
            //Alert窗口的标题
            title : '更新提示'
          },
       });
    }
    ...
}
export default App;
```

###### 用户点击检查更新按钮

在用户点击检查更新按钮后进行检查，如果有更新则弹出提示框让用户选择是否更新，如果用户点击立即更新按钮，则会进行安装包的下载（实际上这时候应该显示下载进度，这里省略了）下载完成后会立即重启并生效（也可配置稍后重启），部分代码如下

```javascript
codePush.checkForUpdate(deploymentKey).then((update) => {
    if (!update) {
        Alert.alert("提示", "已是最新版本--", [
            {
                text: "Ok", onPress: () => {
                console.log("点了OK");
            }
            }
        ]);
    } else {
        codePush.sync({
                deploymentKey: deploymentKey,
                updateDialog: {
                    optionalIgnoreButtonLabel: '稍后',
                    optionalInstallButtonLabel: '立即更新',
                    optionalUpdateMessage: '有新版本了，是否更新？',
                    title: '更新提示'
                },
                installMode: codePush.InstallMode.IMMEDIATE,

            },
            (status) => {
                switch (status) {
                    case codePush.SyncStatus.DOWNLOADING_PACKAGE:
                        console.log("DOWNLOADING_PACKAGE");
                        break;
                    case codePush.SyncStatus.INSTALLING_UPDATE:
                        console.log(" INSTALLING_UPDATE");
                        break;
                }
            },
            (progress) => {
                console.log(progress.receivedBytes + " of " + progress.totalBytes + " received.");
            }
        );
    }
 }
```

###### CodePush高阶组件实现更新

```javascript
import codePush from "react-native-code-push";

class App extends Component {
}

export default codePush(App);
```

更新时机：

```javascript
codePush.InstallMode.IMMEDIATE ：安装完成立即重启更新
codePush.InstallMode.ON_NEXT_RESTART ：安装完成后会在下次重启后进行更新
codePush.InstallMode.ON_NEXT_RESUME ：安装完成后会在应用进入后台后重启更新
```

### 7、提交更新包

我们可以通过`code-push release-react`命令发布更新包。多次发布更新包也是如此。

```javascript
code-push release-react <Appname> <Platform> --t <本更新包面向的客户端版本号> --des <本次更新说明>
```

**注意： CodePush默认是更新Staging 环境的，如果发布生产环境的更新包，需要指定--d参数：--d Production，如果发布的是强制更新包，需要加上 --m true强制更新**

```
code-push release-react RNDemo ios --t 1.0.0 --des "hello world" --m true
```

查询提交过哪些更新包:

-  查询Production

  ```
  code-push deployment history RNDmo_iOS Production
  ```

  

-  查询Staging 
 ```
  code-push deployment history RNDmo_iOS Staging
 ```