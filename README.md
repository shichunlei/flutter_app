# Flutter Demos

A new Flutter application.

## Android APK 下载地址

![](https://github.com/shichunlei/flutter_app/blob/master/1562927446.png)


`声明1：本项目仅供学习，如有侵权请联系本人进行删除。`

`声明2：本项目中部分功能页面是别人其他项目中的，但是本人并不是完全照抄原作者代码，再此也特别感谢原作者，部分参考别人页面的功能也已标注出原出处，如有侵犯原作者的地方请联系本人进行删除。`


## 本项目包括：

- 各种基本控件使用（Text、TextField、Icon、Image、Listview、Gridview、Picker、Stepper、Dialog、Slider、Row、Appbar、Sizebox、BottomSheet、Chip、Dismissible、FlutterLogo、Check、Switch、TabBar、BottomNavigationBar、Sliver等）
- 自定义控件及使用
- 各种UI （豆瓣电影、好奇心日报、每日一文、和天气、百姓生活、随机诗词、联系人、句子迷、朋友圈等）


## 运行环境

```
[✓] Flutter (Channel beta, v1.7.8+hotfix.3, on Mac OS X 10.14.5 18F132, locale zh-Hans-CN)
    • Flutter version 1.7.8+hotfix.3 at /Users/14cells/Android/flutter
    • Framework revision b712a172f9 (2 days ago), 2019-07-09 13:14:38 -0700
    • Engine revision 54ad777fd2
    • Dart version 2.4.0

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.0)
    • Android SDK at /Users/14cells/Android/SDK
    • Android NDK location not configured (optional; useful for native profiling support)
    • Platform android-29, build-tools 29.0.0
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)
    • All Android licenses accepted.

[✗] iOS toolchain - develop for iOS devices
    ✗ Xcode installation is incomplete; a full installation is necessary for iOS development.
      Download at: https://developer.apple.com/xcode/download/
      Or install Xcode via the App Store.
      Once installed, run:
        sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
    ✗ libimobiledevice and ideviceinstaller are not installed. To install with Brew, run:
        brew update
        brew install --HEAD usbmuxd
        brew link usbmuxd
        brew install --HEAD libimobiledevice
        brew install ideviceinstaller
    ✗ ios-deploy not installed. To install:
        brew install ios-deploy
    ✗ CocoaPods not installed.
        CocoaPods is used to retrieve the iOS platform side's plugin code that responds to your plugin usage on the Dart side.
        Without resolving iOS dependencies with CocoaPods, plugins will not work on iOS.
        For more info, see https://flutter.dev/platform-plugins
      To install:
        brew install cocoapods
        pod setup

[✓] Android Studio (version 3.4)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 36.0.1
    • Dart plugin version 183.6270
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)
```

## API接口

- [豆瓣电影API接口>>](https://github.com/shichunlei/-Api/blob/master/%E8%B1%86%E7%93%A3%E7%94%B5%E5%BD%B1.md)

- [每日一文API接口>>](https://github.com/shichunlei/-Api/blob/master/OneArticle.md)

- [天气接口>>](https://www.heweather.com/documents/api/)

- [诗词接口>>](https://blog.csdn.net/qq_35695041/article/details/83024632)

- [好奇心日报接口>>](https://github.com/pkuhonker/qdaily/blob/master/src/services/apiService.ts)

- [好奇心日报接口>>](https://github.com/Urwateryi/QDailyNews/blob/master/app/network/Api.js)


## 运行截图


### 基本控件（Widget）及一些自定义控件（Widget）

|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-18-13-58-429.jpg)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-11-913.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-17-05-27-313.jpg)|
| :--: | :--: | :--: |
|[首页](https://github.com/shichunlei/flutter_app/blob/master/lib/home_page.dart)|侧边栏|版本信息|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-44-611.png)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-01-953.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-55-186.png)|
|[随机诗词](https://github.com/shichunlei/flutter_app/blob/master/lib/page/random_poetry_page.dart)|[二维码（生成/扫描）](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/qr_image_wiget.dart)|[设备信息](https://github.com/shichunlei/flutter_app/blob/master/lib/page/device_info_page.dart)|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-39-35-311.jpg)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-39-48-539.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-40-04-052.png)|
|[瀑布流](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/staggered_view_page.dart)|[评分效果](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/star_rating_widget.dart)|[多边形控件](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/rounded_letter_widget.dart)|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-28-563.png)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-47-846.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-11-31-58-569.png)|
|[LikeButton](https://github.com/shichunlei/flutter_app/blob/master/lib/page/like_button_page.dart)|[Chip](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/chip_widget.dart)|[侧滑删除](https://github.com/shichunlei/flutter_app/blob/master/lib/page/swiper_sample.dart)|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-37-42-680.png)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-38-36-857.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-37-13-394.png)|
|Icon|Stepper|AppBar|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-11-31-19-566.jpg)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-27-08-09-22-689.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-27-08-08-59-855.png)|
|仿探探|BottomSheet|TextField|
|![0](https://github.com/rafalbednarczuk/curved_navigation_bar/blob/master/example.gif)|![1](https://github.com/tunitowen/fancy_bottom_navigation/blob/master/fancy_gif.gif)|![2](https://camo.githubusercontent.com/6bdfb12848c7fcac62da5fa8c65c8c24f536d824/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f744b394c6866484a357154373164376c59612f67697068792e676966)|
|CurvedNavigationBar|FancyBottomNavigation|BubbleBottomBar|
|![0](https://github.com/GanZhiXiong/gzx_dropdown_menu/raw/master/preview_images/美团.gif)|![1](https://github.com/divyanshub024/Flutter-page-route-transition/raw/master/art/route_transition.gif)|![2](https://github.com/TheProtoss/wave/raw/master/example/assets/demo.gif)|
|DropDownMenu|路由过度动画|Wave|



|![1](https://raw.githubusercontent.com/furkantektas/timeline_list/master/doc/timeline_list.png)|
| :--: |
|TimeLine|


### [Rounded Letter](https://github.com/jhomlala/roundedletter)

|![1](https://github.com/jhomlala/roundedletter/blob/master/screenshots/screenshot_1.png)|![2](https://github.com/jhomlala/roundedletter/blob/master/screenshots/screenshot_2.png)|![3](https://github.com/jhomlala/roundedletter/blob/master/screenshots/screenshot_3.png)|
| :--: | :--: | :--: |


### [登录注册](https://github.com/LXD312569496/flutter-learing/tree/master/login_demo)

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-15-38-136.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-15-42-485.png)|
| :--: | :--: |
|登录|注册|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-15-313.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-27-977.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-40-821.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-35-147.png)|
| :--: | :--: | :--: | :--: |
|密码登录|快速登录|注册|找回密码|


### [豆瓣电影](https://github.com/Mayandev/morec)

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-16-35-569.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-16-49-010.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-16-58-888.jpg)|
| :--: | :--: | :--: |
|豆瓣电影首页（banner、热映）|豆瓣电影首页（即将上映、榜单）|豆瓣电影首页（分类浏览）|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-13-51-495.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-14-03-080.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-48-129.jpg)|
|电影（正在热播）|电影（TOP250）|电影（排行榜）|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-14-45-013.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-35-366.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-25-22-636.jpg)|
|电影详情1|电影详情2|电影详情3|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-28-47-225.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-30-31-617.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-22-895.png)|
|电影花絮|电影花絮（全屏）|电影剧照|


### 天气

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-34-612.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-09-17-47-40-026.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-09-17-47-47-861.png)|
| :--: | :--: | :--: |
|实况天气/空气质量指数|逐小时、7天天气预报|生活指数|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-14-11-24-061.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-23-860.png)|![3](https://github.com/shichunlei/flutter_jd_address_selector/raw/master/images/Screenshot_2019-06-15-15-26-30-164.png)|
|日出日落|城市列表|[仿京东地址选择器](https://github.com/shichunlei/flutter_jd_address_selector)|



#### [百姓生活](https://github.com/shenghy/flutter_shop)

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-19-20-22-33-602.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-19-20-22-46-698.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-19-20-22-54-706.jpg)|
| :--: | :--: | :--: |
|首页|首页|首页|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-23-19-16-25-496.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-26-15-38-33-468.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-23-17-35-34-333.jpg)|
|分类|购物车|会员中心|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-27-13-34-29-867.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-27-13-34-49-927.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-27-13-35-02-190.jpg)|
|商品简介|详情|评论|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-16-14-37-38-179.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-16-14-38-45-247.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-16-14-37-56-225.png)|
|收货地址|地址|新增地址|


### [每日一文](https://github.com/chengww5217/one_article)

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-22-18-01-34-664.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-22-17-05-37-975.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-22-17-52-45-864.png)|
| :--: | :--: | :--: |
|每日一文|每日一文|收藏|


### 仿微信朋友圈布局

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-15-18-34-444.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-15-18-46-454.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-19-55-24-181.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-19-56-19-726.jpg)|
| :--: | :--: | :--: | :--: |
|头部|九宫格|选择照片|发表编辑|


### [句子迷](https://www.juzimi.com/)


### [好奇心日报](http://www.qdaily.com/)


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-19-07-643.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-19-15-587.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-21-14-965.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-21-26-333.jpg)|
| :--: | :--: | :--: | :--: |
|启动页|首页1|首页2|首页3|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-21-34-258.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-21-52-988.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-22-02-810.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-02-15-23-22-164.jpg)|
|Labs|我说/焦点小组|投票|你猜/你谁啊|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-22-21-692.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-22-27-412.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-22-44-753.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-51-53-283.jpg)|
|菜单1|菜单2|栏目列表|栏目详情|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-22-34-621.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-31-16-59-16-833.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-31-17-32-53-185.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-30-09-22-12-550.jpg)|
|分类列表（设计）|新闻详情1|新闻详情2|评论|


### [Flutter i18n 实现国际化](https://github.com/shichunlei/flutter_app/wiki/Flutter-i18n-%E5%AE%9E%E7%8E%B0%E5%9B%BD%E9%99%85%E5%8C%96)


## 使用到的第三方插件

| Plugin | 地址 | 版本号 |
| :--: | :--: | :--: |
| 网络请求 | [dio](https://pub.dartlang.org/packages/dio) | ![](https://camo.githubusercontent.com/cdfb640de2cc8eeb0f6bfa1bda82422d83d87785/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f64696f2e7376673f7374796c653d666c61742d737175617265) |
| 下拉刷新，上拉加载 |[flutter_easyrefresh](https://github.com/xuelongqy/flutter_easyrefresh)|![](https://camo.githubusercontent.com/c96857ee880abb5c8d65ab657cbd60836739533b/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f7075622d76312e322e352d6f72616e67652e737667)|
| Shared Preferences |[shared_preferences](https://github.com/flutter/plugins/tree/master/packages/shared_preferences)|![](https://camo.githubusercontent.com/b9af89a46da89444505ead9b0a7245e883d17afb/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f7368617265645f707265666572656e6365732e737667)| 
| 中国城市选择器 |[city_picker](https://github.com/CaiJingLong/flutter_city_picker)|![](https://camo.githubusercontent.com/24b9365f7514f94b06178f06f81397d0d75d80c4/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f636974795f7069636b65722e737667)|
| 设备信息 |[device_info](https://github.com/flutter/plugins/tree/master/packages/device_info)|![](https://camo.githubusercontent.com/965d0090e8f547b318f37fcf6e0e30ccebc2dfaf/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f6465766963655f696e666f2e737667)|
| 图片选择器 | [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker) | ![](https://camo.githubusercontent.com/50ed2cc4c99917d2dfb12b44e5ab9356f70d63b7/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f696d6167655f7069636b65722e737667) | 
| url_launcher | [url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher) | ![](https://camo.githubusercontent.com/73ce49295f296939f5fc90be9ce94ca8c7bd7e44/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f75726c5f6c61756e636865722e737667) | 
| 视频播放器 | [video_player](https://github.com/flutter/plugins/tree/master/packages/video_player) | ![](https://camo.githubusercontent.com/de09dde7ce935f4e176c1ce00f7e31e4b0e5c14f/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f766964656f5f706c617965722e737667) | 
| Flutter WebView Plugin | [flutter_webview_plugin](https://github.com/fluttercommunity/flutter_webview_plugin) | ![](https://img.shields.io/pub/v/flutter_webview_plugin.svg) | 
| PackageInfo | [package_info](https://github.com/flutter/plugins/tree/master/packages/package_info) | ![](https://camo.githubusercontent.com/01a75953af6fc91e941c2b5ba32162f55d795403/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f706174685f70726f76696465722e737667) | 
| 系统分享 | [share](https://github.com/flutter/plugins/tree/master/packages/share) | ![](https://camo.githubusercontent.com/afe573869b306315562203bca3cf9a85ac94ccf5/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f73686172652e737667) |
| 引导页 | [intro-slider](https://github.com/duytq94/flutter-intro-slider) | 2.2.2 |
| 评分控件 | [smooth_star_rating](https://github.com/thangmam/smoothratingbar) | 1.0.1 | 
| PhotoView | [photo_view](https://github.com/renancaraujo/photo_view) | ![](https://camo.githubusercontent.com/8a5c98a80bb80f0eed10b5f111cc7440d1aa143e/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f70686f746f5f766965772e7376673f7374796c653d706f706f7574) | 
| 时间轴 | [Timeline](https://github.com/furkantektas/timeline_list) | ![](https://camo.githubusercontent.com/81e25a24fd6072e2979c03e4d716be55eff89763/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f74696d656c696e655f6c6973742e737667) | 
| Rounded Letter | [roundedletter](https://github.com/jhomlala/roundedletter) | ![](https://camo.githubusercontent.com/ab6351029d9980584a1120d90dccb654e8ab8dbb/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f726f756e6465645f6c65747465722e737667) | 
| 数据库 | [sqflite](https://github.com/tekartik/sqflite) | 1.1.5 | 
| Flutter Multi Image Picker | [Flutter Multi Image Picker](https://github.com/Sh1d0w/multi_image_picker) | ![](https://camo.githubusercontent.com/a92acc7a4217e1e7bfb9a9a4ad0be422ce7ad875/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f6d756c74695f696d6167655f7069636b65722e737667) | 
| Flutter Range Slider | [range_slider](https://github.com/boeledi/RangeSlider) | 1.2.0 | 
| 侧滑菜单 | [flutter_inner_drawer](https://github.com/Dn-a/flutter_inner_drawer) | ![](https://camo.githubusercontent.com/dda1245d1fb2d8ab403c705df11bbf07717d3dce/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f7075622d302e322e362d6f72616e67652e737667) | 
| 字母索引、悬停 | [azlistview](https://github.com/flutterchina/azlistview) | ![](https://camo.githubusercontent.com/fe32a6e2c3f42d892ce837927d0499d5608e88c8/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f617a6c697374766965772e7376673f7374796c653d666c61742d737175617265) |
| 状态管理 | [provide](https://github.com/google/flutter-provide) | 1.0.2 |
| 图表 | [fl_chart](https://github.com/imaNNeoFighT/fl_chart) | ![](https://camo.githubusercontent.com/9ec4eb28efea48f3229b74bcef4b9b5554517421/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f666c5f63686172742e737667) |
| Badges for Flutter | [badges](https://github.com/yadaniyil/flutter_badges) | ![](https://camo.githubusercontent.com/c65b82b9f7487ff2a77b09bf7f682677b0312ab9/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f7075622d312e302e332d626c756576696f6c65742e737667) |
| Palette Generator | [palette_generator](https://github.com/flutter/packages/tree/master/packages/palette_generator) | ![](https://img.shields.io/pub/v/palette_generator.svg) |
| 仿京东地址选择器 | [flutter_jd_address_selector](https://github.com/shichunlei/flutter_jd_address_selector) | 0.0.1 |
| 图片裁剪 | [image_crop](https://github.com/VolodymyrLykhonis/image_crop) |![](https://img.shields.io/pub/v/image_crop.svg)|


## 赞赏

如果您喜欢FlutterApp，或感觉FlutterApp帮助到了您，可以点右上角“Star”支持一下，您的支持就是我的动力，谢谢🙂

您也可以扫描下面的二维码，请作者喝杯咖啡☕️


- 先领个红包

|![1](https://github.com/shichunlei/flutter_app/blob/master/admire-for/781564454769_.pic.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/admire-for/811564454769_.pic.jpg)|
| :--: | :--: |


|![1](https://github.com/shichunlei/flutter_app/blob/master/admire-for/771564454769_.pic.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/admire-for/801564454769_.pic.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/admire-for/761564454769_.pic_hd.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/admire-for/821564454769_.pic.jpg)|
| :--: | :--: | :--: | :--: |



## 许可证

[Apache 2.0](https://github.com/shichunlei/flutter_app/blob/master/LICENSE)
