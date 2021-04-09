# GHMall

![2f7f1a6d17a91f4167b85af5a47c65b131f3a64268732-eYhpx3_fw658副本.png](https://upload-images.jianshu.io/upload_images/668798-fe7c1d5f80822290.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一个练习的flutter电商项目，基本功能已经完成。

环境

```
Flutter 2.0.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 60bd88df91 (10 hours ago) • 2021-03-03 09:13:17 -0800
Engine • revision 40441def69
Tools • Dart 2.12.0

```
如果还没有配置环境，[跳转](https://github.com/shabake/Configure-the-Flutter-environment)配置`Flutter`环境


#### 体验demo
![](https://oscimg.oschina.net/oscnet/up-ce4747b9241fd24f078e0b269925672b53d.png)


#### 安装方法:

```
cd 你要存放的目录
```

```
git clone https://github.com/shabake/GHMall.git
```

```
flutter pub get 
```

如果终端输出

```
Waiting for another flutter command to release the startup lock
```
找到`flutterSDK`文件夹

如`flutter/bin/cache`

删除`lockfile`

重新执行`flutter pub get `

运行一个`iOS`或安卓模拟器

如果连接真机`iOS`打开在`GHMall/ios/Runner.xcworkspace`

配置开发者账户

最后执行`flutter run`



##  项目中用到的插件

| 名称                          | 描述         |
| ----------------------------- | ------------ |
| dio                           | 网络请求     |
| fluttertoast                       | 提示 toast   |
| sqflite                       | 数据持久化   |
| flutter_swiper                | 轮播图       |
| flutter_screenutil             | 屏幕适配     |
| cached_network_image          | 缓存网络图片 |
| shared_preferences | 本地存储    |
| event_bus                    | 事件通知  |
| provider              | 状态管理     |
| flutter_screenutil             | 屏幕适配     |
| city_pickers         | 城市选择器 |
| flutter_easyrefresh | 刷新控件   |
| transparent_image         | 图片动画 |

```diff
已经实现
+ 实现用户注册登录
+ 商品浏览
+ 商品属性筛选
+ 添加商品
+ 购物车增加减少商品
+ 提交订单
+ 已经适配iOS,测试模拟器iPhone11

计划实现
- 用户登录验证码倒计时
- 用户地址
- 用户订单列表查看
- 用户订单详情

```



### 在使用中如有任何问题欢迎骚扰我,如果对你有帮助请点帮我一个✨,小弟感激不尽:blush:





