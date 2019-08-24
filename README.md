![](https://github.com/shichunlei/flutter_app/blob/master/FlutterApp.png)

# Flutter Demos

A new Flutter application.

## Android APK 下载地址

![](https://github.com/shichunlei/flutter_app/blob/master/1562927446.png)


`声明1：本项目仅供学习，如有侵权请联系本人进行删除。`

`声明2：本项目中部分功能页面是别人其他项目中的，但是本人并不是完全照抄原作者代码，再此也特别感谢原作者，部分参考别人页面的功能也已标注出原出处，如有侵犯原作者的地方请联系本人进行删除。`


## 本项目包括：

- 各种基本控件使用（Text、TextField、Icon、Image、Listview、Gridview、Picker、Stepper、Dialog、Slider、Row、Appbar、Sizebox、BottomSheet、Chip、Dismissible、FlutterLogo、Check、Switch、TabBar、BottomNavigationBar、Sliver等）
- 自定义控件及使用
- 各种UI （豆瓣电影、好奇心日报、每日一文、和天气、百姓生活、随机诗词、联系人、句子迷、朋友圈、有道精品课、高德地图应用demo等）


## 运行环境

```
[✓] Flutter (Channel beta, v1.8.3, on Mac OS X 10.14.5 18F132, locale zh-Hans-CN)
    • Flutter version 1.8.3 at /Users/14cells/Android/flutter
    • Framework revision e4ebcdf6f4 (13 days ago), 2019-07-27 11:48:24 -0700
    • Engine revision 38ac5f30a7
    • Dart version 2.5.0 (build 2.5.0-dev.1.0 0ca1582afd)

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.2)
    • Android SDK at /Users/14cells/Android/SDK
    • Android NDK location not configured (optional; useful for native profiling support)
    • Platform android-29, build-tools 29.0.2
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)
    • All Android licenses accepted.

[✗] Xcode - develop for iOS and macOS
    ✗ Xcode installation is incomplete; a full installation is necessary for iOS development.
      Download at: https://developer.apple.com/xcode/download/
      Or install Xcode via the App Store.
      Once installed, run:
        sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
    ✗ CocoaPods not installed.
        CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your plugin usage on the Dart side.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/platform-plugins
      To install:
        sudo gem install cocoapods
        pod setup

[✓] Android Studio (version 3.4)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 38.2.1
    • Dart plugin version 183.6270
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)

[✓] Connected device (1 available)
    • MI 5X • 1c7664100104 • android-arm64 • Android 8.1.0 (API 27)
```

#### 注意事项


- 高德定位ios设备的apikey没有配置，使用ios设备的朋友们可以自己去高德地图申请apikey，ios具体配置见[高德地图flutter插件](https://github.com/OpenFlutter/amap_base_flutter)配置。
- 音乐🎵播放器[Music Player](https://github.com/shichunlei/flutter_app/blob/master/lib/music_player/home_page.dart)暂不支持ios设备，详情请见插件[Flute-Music-Player](https://github.com/iampawan/Flute-Music-Player)。


## API接口

- [豆瓣电影API接口>>](https://github.com/shichunlei/-Api/blob/master/%E8%B1%86%E7%93%A3%E7%94%B5%E5%BD%B1.md)

- [每日一文API接口>>](https://github.com/shichunlei/-Api/blob/master/OneArticle.md)

- [天气接口>>](https://www.heweather.com/documents/api/)

- [免费接口API>>](https://blog.csdn.net/qq_35695041/article/details/83024632)

- [好奇心日报接口>>](https://github.com/pkuhonker/qdaily/blob/master/src/services/apiService.ts)

- [好奇心日报接口>>](https://github.com/Urwateryi/QDailyNews/blob/master/app/network/Api.js)


## 运行截图


### 基本控件（Widget）及一些自定义控件（Widget）

|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-18-13-58-429.jpg)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-11-913.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-17-05-27-313.jpg)|
| :--: | :--: | :--: |
|[首页](https://github.com/shichunlei/flutter_app/blob/master/lib/home_page.dart)|侧边栏|版本信息|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-44-611.jpg)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-01-953.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-55-186.png)|
|[音乐播放器](https://github.com/shichunlei/flutter_app/blob/master/lib/music_player/home_page.dart)|[二维码（生成/扫描）](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/qr_image_wiget.dart)|[设备信息](https://github.com/shichunlei/flutter_app/blob/master/lib/page/device_info_page.dart)|
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

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-15-38-136.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-15-42-485.png)|![3](https://raw.githubusercontent.com/Tecode/flutter_widget/master/picture/login_video_demo.gif)|
| :--: | :--: | :--: |
|登录|注册|视频背景登录|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/911565856636_.pic.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/921565856637_.pic.jpg)|![3]()|
|登录|注册|XXX|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-15-313.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-27-977.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-40-821.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-35-147.png)|
| :--: | :--: | :--: | :--: |
|密码登录|快速登录|注册|找回密码|


### [豆瓣电影](https://github.com/Mayandev/morec)

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-16-35-569.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-16-49-010.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-16-58-888.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-13-51-495.jpg)|
| :--: | :--: | :--: | :--: |
|豆瓣电影首页（banner、热映）|豆瓣电影首页（即将上映、榜单）|豆瓣电影首页（分类浏览）|电影（正在热播）|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-14-45-013.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-35-366.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-25-22-636.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-14-03-080.jpg)|
|电影详情1|电影详情2|电影详情3|电影（TOP250）|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-28-47-225.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-30-31-617.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-22-895.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-48-129.jpg)|
|电影花絮|电影花絮（全屏）|电影剧照|电影（排行榜）|


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


### [有道精品课](https://ke.youdao.com/)


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/961566204857_.pic.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/971566204858_.pic.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/981566204860_.pic.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/991566204861_.pic.jpg)|
| :--: | :--: | :--: | :--: |
|首页（广告）|首页（分类）|分类|详情（WebView）|



### [Flutter i18n 实现国际化](https://github.com/shichunlei/flutter_app/wiki/Flutter-i18n-%E5%AE%9E%E7%8E%B0%E5%9B%BD%E9%99%85%E5%8C%96)


## 使用到的或推荐使用的一些第三方插件

| Plugin | 地址 | 版本号 |
| :--: | :--: | :--: |
| 网络请求 | [dio](https://pub.dartlang.org/packages/dio) | ![](https://img.shields.io/pub/v/dio.svg) |
| 下拉刷新，上拉加载 |[FlutterEasyRefresh](https://github.com/xuelongqy/flutter_easyrefresh)|![](https://img.shields.io/pub/v/flutter_easyrefresh.svg)|
| Shared Preferences |[shared_preferences](https://github.com/flutter/plugins/tree/master/packages/shared_preferences)|![](https://img.shields.io/pub/v/shared_preferences.svg)| 
| 中国城市选择器 |[city_picker](https://github.com/CaiJingLong/flutter_city_picker)|![](https://img.shields.io/pub/v/city_picker.svg)|
| 设备信息 |[device_info](https://github.com/flutter/plugins/tree/master/packages/device_info)|![](https://img.shields.io/pub/v/device_info.svg)|
| 图片选择器 | [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker) | ![](https://img.shields.io/pub/v/image_picker.svg) | 
| url_launcher | [url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher) | ![](https://img.shields.io/pub/v/url_launcher.svg) | 
| 视频播放器 | [video_player](https://github.com/flutter/plugins/tree/master/packages/video_player) | ![](https://img.shields.io/pub/v/video_player.svg) | 
| Flutter WebView Plugin | [WebView](https://github.com/fluttercommunity/flutter_webview_plugin) | ![](https://img.shields.io/pub/v/flutter_webview_plugin.svg) | 
| PackageInfo | [package_info](https://github.com/flutter/plugins/tree/master/packages/package_info) | ![](https://img.shields.io/pub/v/package_info.svg) | 
| 系统分享 | [share](https://github.com/flutter/plugins/tree/master/packages/share) | ![](https://img.shields.io/pub/v/share.svg) |
| 引导页 | [intro-slider](https://github.com/duytq94/flutter-intro-slider) | ![](https://img.shields.io/pub/v/intro_slider.svg) |
| 评分控件 | [smooth_star_rating](https://github.com/thangmam/smoothratingbar) | ![](https://img.shields.io/pub/v/smooth_star_rating.svg) | 
| PhotoView | [photo_view](https://github.com/renancaraujo/photo_view) | ![](https://img.shields.io/pub/v/photo_view.svg) | 
| 时间轴 | [Timeline](https://github.com/furkantektas/timeline_list) | ![](https://img.shields.io/pub/v/timeline_list.svg) | 
| Rounded Letter | [rounded_letter](https://github.com/jhomlala/roundedletter) | ![](https://img.shields.io/pub/v/rounded_letter.svg) | 
| 数据库 | [sqfLite](https://github.com/tekartik/sqflite) | ![](https://img.shields.io/pub/v/sqflite.svg) | 
| Flutter Multi Image Picker | [Flutter Multi Image Picker](https://github.com/Sh1d0w/multi_image_picker) | ![](https://img.shields.io/pub/v/multi_image_picker.svg) | 
| Flutter Range Slider | [range_slider](https://github.com/boeledi/RangeSlider) | ![](https://img.shields.io/pub/v/flutter_range_slider.svg) | 
| 侧滑菜单 | [flutter_inner_drawer](https://github.com/Dn-a/flutter_inner_drawer) | ![](https://img.shields.io/pub/v/flutter_inner_drawer.svg) | 
| 字母索引、悬停 | [AZListView](https://github.com/flutterchina/azlistview) | ![](https://img.shields.io/pub/v/azlistview.svg) |
| 状态管理 | [provider](https://github.com/rrousselGit/provider) | ![](https://img.shields.io/pub/v/provider.svg) |
| 图表 | [fl_chart](https://github.com/imaNNeoFighT/fl_chart) | ![](https://img.shields.io/pub/v/fl_chart.svg) |
| Badges for Flutter | [badges](https://github.com/yadaniyil/flutter_badges) | ![](https://img.shields.io/pub/v/badges.svg) |
| Palette Generator | [palette_generator](https://github.com/flutter/packages/tree/master/packages/palette_generator) | ![](https://img.shields.io/pub/v/palette_generator.svg) |
| 仿京东地址选择器 | [flutter_jd_address_selector](https://github.com/shichunlei/flutter_jd_address_selector) | 0.0.1 |
| 图片裁剪 | [image_crop](https://github.com/VolodymyrLykhonis/image_crop) |![](https://img.shields.io/pub/v/image_crop.svg)|
| 图片裁剪 | [image_cropper](https://github.com/hnvn/flutter_image_cropper) |![](https://camo.githubusercontent.com/b8fbf5d5502729096a88fd9d29a25231fa980a12/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f696d6167655f63726f707065722e737667)|
| path_provider | [path_provider](https://github.com/flutter/plugins/tree/master/packages/path_provider) | ![](https://img.shields.io/pub/v/path_provider.svg) |
| 高德地图定位 | [AMapBaseLocation](https://github.com/OpenFlutter/amap_base_flutter) | ![](https://img.shields.io/pub/v/amap_base_location.svg) |
| Flutter 字体动画 | [animated_text_kit](https://github.com/aagarwal1012/Animated-Text-Kit) | ![](https://camo.githubusercontent.com/d1d5eae95a6eeec94d60d086c00ca9f7e2d969e6/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f616e696d617465645f746578745f6b69742e737667) |


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
