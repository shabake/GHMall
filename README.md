# GHMall - Flutter 电商应用

![GHMall](https://upload-images.jianshu.io/upload_images/668798-fe7c1d5f80822290.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一个完整的 Flutter 电商应用，基于最新的 Flutter 3.41.7 构建，所有核心功能已完成并测试。

## ✨ 项目特性

- ✅ **用户认证** - 手机号登录/注册
- ✅ **商品浏览** - 轮播图、分类浏览、商品详情
- ✅ **智能搜索** - 商品搜索和筛选
- ✅ **购物车** - 添加、删除、修改数量
- ✅ **订单系统** - 提交订单、订单管理、支付
- ✅ **地址管理** - 收货地址的增删改查
- ✅ **响应式设计** - 完美适配各种 iOS 设备

## 🛠️ 技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| Flutter | 3.41.7 | 跨平台框架 |
| Dart | 3.11.5 | 编程语言 |
| null safety | ✅ | 完全支持空安全 |

## 📦 核心依赖

| 插件 | 用途 |
|------|------|
| **dio** | HTTP 网络请求 |
| **sqflite** | 本地数据库存储 |
| **flutter_screenutil** | 屏幕适配和响应式设计 |
| **fluttertoast** | 消息提示 |
| **transparent_image** | 图片加载动画 |
| **event_bus** | 事件通信 |
| **shared_preferences** | 本地轻量级存储 |

## 🚀 快速开始

### 环境要求

```
- Flutter SDK: 3.41.7 或更高
- Dart SDK: 3.11.5 或更高
- iOS: 12.0+ (使用 Xcode 构建)
- 或 Android: API 21+ (使用 Android Studio)
```

### 安装步骤

1. **克隆项目**
```bash
git clone https://github.com/shabake/GHMall.git
cd GHMall
```

2. **获取依赖**
```bash
flutter pub get
```

3. **运行应用**

**iOS 模拟器：**
```bash
flutter run -d "iPhone 16e"
```

**Android 模拟器：**
```bash
flutter run
```

**真实设备（iOS）：**
```bash
# 需要先在 Xcode 中配置代码签名
open ios/Runner.xcworkspace
# 配置后运行
flutter run -d <device-name>
```

## 📁 项目结构

```
lib/
├── main.dart                 # 应用入口
├── pages/                    # 页面
│   ├── tabs/                # 底部导航页面
│   │   ├── GHHomePage.dart         # 首页 (轮播图、推荐商品)
│   │   ├── GHCategoryPage.dart     # 分类页面
│   │   ├── GHShopCartPage.dart     # 购物车
│   │   └── GHMePage.dart           # 个人中心
│   ├── GHLoginPage.dart          # 登录注册
│   ├── GHGoodsList.dart          # 商品列表
│   ├── GHGoodsDetails.dart       # 商品详情
│   ├── GHCheckOutPage.dart       # 订单确认
│   ├── GHOnlinePayments.dart     # 支付
│   ├── GHOrderList.dart          # 订单列表
│   ├── GHAddressList.dart        # 地址列表
│   └── GHAddressEdit.dart        # 地址编辑
├── model/                    # 数据模型
├── services/                 # 服务层
│   ├── httptool.dart             # HTTP 请求封装
│   ├── ScreenAdaper.dart         # 屏幕适配工具
│   ├── GHToast.dart              # 消息提示
│   └── gh_sqflite.dart           # 数据库服务
├── widget/                   # 自定义组件
├── routers/                  # 路由配置
└── res/                      # 资源文件
    └── images/               # 图片资源
```

## 🔑 API 配置

项目使用 LeanCloud 作为后端服务：

**Base URL:** `https://api.leancloud.cn/1.1`

**关键端点：**
- `/classes/shopCarousel` - 轮播图
- `/classes/shopCategory` - 商品分类
- `/classes/shopGoodsList` - 商品列表
- `/classes/shopCartList` - 购物车
- `/classes/shopOrderList` - 订单
- `/classes/shopAddress` - 收货地址

## 🎨 UI 亮点

- **轮播图** - 支持手指滑动，底部圆点指示器
- **响应式布局** - 自动适配各种屏幕尺寸
- **图片加载动画** - FadeInImage 平滑加载效果
- **加载状态** - 优雅的加载提示

## ✅ 已实现功能

- [x] 用户登录和注册（手机号 + 验证码）
- [x] 首页轮播图和推荐商品
- [x] 商品分类浏览
- [x] 商品搜索和多条件筛选
- [x] 商品详情页
- [x] 购物车（增删改）
- [x] 收货地址管理
- [x] 订单创建和查看
- [x] 支付方式选择
- [x] 屏幕适配（所有 iOS 设备）

## 📋 计划功能

- [ ] 用户评价和评分
- [ ] 优惠券管理
- [ ] 订单物流追踪
- [ ] 退货售后服务
- [ ] 商品收藏
- [ ] 推荐系统优化

## 🐛 常见问题

**Q: 如何修复 "Waiting for another flutter command to release the startup lock" 错误？**

A: 删除 Flutter SDK 中的 lockfile：
```bash
rm -f ~/flutter/bin/cache/lockfile
flutter pub get
```

**Q: iOS 应用无法在真实设备上运行？**

A: 需要在 Xcode 中配置开发者团队：
1. 打开 `ios/Runner.xcworkspace`
2. 选择 Runner 项目
3. 进入 Signing & Capabilities
4. 选择你的开发者团队

**Q: 网络请求失败？**

A: 确保：
1. 设备连接到互联网
2. LeanCloud 服务正常运行
3. API 密钥配置正确（查看 `lib/services/httptool.dart`）

## 📸 功能演示

| 首页 | 商品详情 | 购物车 | 订单 |
|------|----------|--------|------|
| 轮播图<br/>分类导航<br/>推荐商品 | 商品信息<br/>属性选择<br/>加入购物车 | 商品列表<br/>数量修改<br/>结算 | 订单确认<br/>地址选择<br/>支付 |

## 🔄 最近更新 (2026)

- ✨ 升级到 Flutter 3.41.7 和 Dart 3.11.5
- ✨ 完全适配 Null Safety
- ✨ 替换废弃的 flutter_swiper 为原生 PageView
- ✨ 优化 API 配置和网络请求
- ✨ 改进轮播图指示器 UI
- ✨ 增强错误处理和加载状态

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

如果觉得这个项目对你有帮助，请给我一个 ⭐ Star，谢谢！

## 📄 许可证

MIT License - 详见 LICENSE 文件

## 📞 联系方式

有任何问题或建议，欢迎通过 GitHub Issues 与我联系。

---

**最后更新时间：** 2026年4月  
**Flutter 版本：** 3.41.7  
**项目状态：** ✅ 功能完整，可生产
