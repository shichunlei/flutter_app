![](https://github.com/shichunlei/flutter_app/blob/master/FlutterApp.png)

# FlutterApp

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
[✓] Flutter (Channel beta, v1.9.1+hotfix.2, on Mac OS X 10.14.5 18F132, locale zh-Hans-CN)
    • Flutter version 1.9.1+hotfix.2 at /Users/14cells/Android/flutter
    • Framework revision 2d2a1ffec9 (4 days ago), 2019-09-06 18:39:49 -0700
    • Engine revision b863200c37
    • Dart version 2.5.0

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.2)
    • Android SDK at /Users/14cells/Android/SDK
    • Android NDK location not configured (optional; useful for native profiling support)
    • Platform android-29, build-tools 29.0.2
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_202-release-1483-b49-5587405)
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

[✓] Android Studio (version 3.5)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 38.2.3
    • Dart plugin version 191.8423
    • Java version OpenJDK Runtime Environment (build 1.8.0_202-release-1483-b49-5587405)

[✓] Connected device (1 available)
    • MI 5X • 1c7664100104 • android-arm64 • Android 8.1.0 (API 27)
```

#### 注意事项


- 高德定位ios设备的apikey没有配置，使用ios设备的朋友们可以自己去高德地图申请apikey，ios具体配置见[高德地图flutter插件](https://github.com/OpenFlutter/amap_base_flutter)配置。
- 音乐🎵播放器[Music Player](https://github.com/shichunlei/flutter_app/blob/master/lib/music_player/flute_music_player.dart)暂不支持ios设备，详情请见插件[Flute-Music-Player](https://github.com/iampawan/Flute-Music-Player)。
- Multi Image Picker 插件 ios 配置见[Multi Image Picker 使用](https://sh1d0w.github.io/multi_image_picker/#/gettingstarted)


## API接口

- [豆瓣电影API接口>>](https://github.com/shichunlei/-Api/blob/master/%E8%B1%86%E7%93%A3%E7%94%B5%E5%BD%B1.md)

- [每日一文API接口>>](https://github.com/shichunlei/-Api/blob/master/OneArticle.md)

- [天气接口>>](https://www.heweather.com/documents/api/)

- [免费接口API>>](https://blog.csdn.net/qq_35695041/article/details/83024632)

- [好奇心日报接口>>](https://github.com/pkuhonker/qdaily/blob/master/src/services/apiService.ts)

- [好奇心日报接口>>](https://github.com/Urwateryi/QDailyNews/blob/master/app/network/Api.js)

- [追书神器接口>>](https://github.com/shichunlei/-Api/blob/master/%E8%BF%BD%E4%B9%A6%E7%A5%9E%E5%99%A8.md)


## 运行截图


### 基本控件（Widget）及一些自定义控件（Widget）

|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/1021566790377_.pic.jpg)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-18-13-58-429.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-11-913.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-17-05-27-313.jpg)|
| :--: | :--: | :--: | :--: |
|启动页|[首页](https://github.com/shichunlei/flutter_app/blob/master/lib/home_page.dart)|侧边栏|版本信息|
|![0](https://github.com/csells/flutter_toggle_buttons/raw/master/readme/demo.gif)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-01-953.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-05-16-52-55-186.png)|![3](https://github.com/TheProtoss/wave/raw/master/example/assets/demo.gif)|
|toggle_buttons|[二维码（生成/扫描）](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/qr_image_wiget.dart)|[设备信息](https://github.com/shichunlei/flutter_app/blob/master/lib/page/device_info_page.dart)|Wave|
|![0](https://raw.githubusercontent.com/letsar/flutter_staggered_grid_view/master/doc/images/dynamic_tile_sizes.gif)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-39-48-539.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-40-04-052.png)|![3](https://github.com/divyanshub024/Flutter-page-route-transition/raw/master/art/route_transition.gif)|
|[瀑布流](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/staggered_view_page.dart)|[评分控件](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/star_rating_widget.dart)|[多边形控件](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/rounded_letter_widget.dart)|路由过度动画|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-28-563.png)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-47-846.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-11-31-58-569.png)|![3](https://github.com/GanZhiXiong/gzx_dropdown_menu/raw/master/preview_images/美团.gif)|
|[LikeButton](https://github.com/shichunlei/flutter_app/blob/master/lib/page/like_button_page.dart)|[Chip](https://github.com/shichunlei/flutter_app/blob/master/lib/widget/chip_widget.dart)|[侧滑删除](https://github.com/shichunlei/flutter_app/blob/master/lib/page/swiper_sample.dart)|DropDownMenu|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-37-42-680.png)|![1](https://github.com/nisrulz/flutter-examples/raw/master/using_stepper/demo_img.gif)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-03-31-09-37-13-394.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/1041566790911_.pic_hd.jpg)|
|Icon|Stepper|AppBar|RangeSlider|
|![0](https://img-blog.csdn.net/20180507225129281?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTQyMDUyNDc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-27-08-09-22-689.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-04-27-08-08-59-855.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/1051566790912_.pic.jpg)|
|AspectRatio|BottomSheet|TextField|Check Switch Radio|
|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-11-18-32-05-782.jpg)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-11-18-32-17-902.png)|![2](https://img-blog.csdnimg.cn/20181219204545587.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)|![3](https://img-blog.csdnimg.cn/20181219204559874.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21lbmdrczE5ODc=,size_16,color_FFFFFF,t_70)|
|Image|Slider|日期时间选择器|日期时间选择器|


|![0](https://github.com/rafalbednarczuk/curved_navigation_bar/blob/master/example.gif)|![1](https://github.com/tunitowen/fancy_bottom_navigation/blob/master/fancy_gif.gif)|![2](https://camo.githubusercontent.com/6bdfb12848c7fcac62da5fa8c65c8c24f536d824/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f744b394c6866484a357154373164376c59612f67697068792e676966)|
| :--: | :--: | :--: |
|CurvedNavigationBar|FancyBottomNavigation|BubbleBottomBar|


|![1](https://raw.githubusercontent.com/furkantektas/timeline_list/master/doc/timeline_list.png)|
| :--: |
|TimeLine|


### [Rounded Letter](https://github.com/jhomlala/roundedletter)

|![1](https://github.com/jhomlala/roundedletter/blob/master/screenshots/screenshot_1.png)|![2](https://github.com/jhomlala/roundedletter/blob/master/screenshots/screenshot_2.png)|![3](https://github.com/jhomlala/roundedletter/blob/master/screenshots/screenshot_3.png)|
| :--: | :--: | :--: |


### [登录注册](https://github.com/LXD312569496/flutter-learing/tree/master/login_demo)


|![1](https://upload-images.jianshu.io/upload_images/2774805-9b6c8ce1ba399665)|![2](https://upload-images.jianshu.io/upload_images/2774805-d577152c80806d50)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/1031566790595_.pic.jpg)|![4](https://raw.githubusercontent.com/Tecode/flutter_widget/master/picture/login_video_demo.gif)|
| :--: | :--: | :--: | :--: |
|登录|注册|找回密码|视频背景登录|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-15-313.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-27-977.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-40-821.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-06-15-08-33-35-147.png)|
|密码登录|快速登录|注册|找回密码|
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/911565856636_.pic.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/921565856637_.pic.jpg)|![3]()|![4]()|
|登录|注册|XXX|XXX|


### [追书神器](http://m.zhuishushenqi.com/)


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-23-44-265.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-14-20-422.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-14-30-696.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-23-39-352.png)|
| :--: | :--: | :--: | :--: |
| 登录 | 选择性别 | 选择兴趣爱好 | 我的 |
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-02-20-410.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-02-41-880.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-11-35-08-371.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/)|
| 书架（空） | 书架 | 书城 | 分类 |
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-11-35-39-277.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-11-36-04-409.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-11-44-50-515.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-01-53-767.jpg)|
| 排行 | 书单 | 书单详情 | 漫画 |
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-11-45-32-615.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-00-42-510.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-01-09-236.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-01-30-229.png)|
| 书籍详情1 | 书籍详情2 | 目录1 | 目录2 |
|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-01-17-515.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-01-22-846.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-03-15-178.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-08-30-12-02-57-508.jpg)|
| 阅读 | 阅读设置 | 搜索 | 搜索结果 |


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


### [音乐播放器]()

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-44-611.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-06-16-26-58-467.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-06-16-26-48-807.png)|
| :--: | :--: | :--: |
|Music Player|Audio Player|Flutter Sound|


### 仿微信朋友圈布局

|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-15-18-34-444.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-15-18-46-454.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-19-55-24-181.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-05-10-19-56-19-726.jpg)|
| :--: | :--: | :--: | :--: |
|头部|九宫格|选择照片|发表编辑|


### [句子迷](http://www.cnjxn.com)


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-14-12-04-59-955.jpg)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-14-12-04-52-007.jpg)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-14-12-04-23-471.jpg)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-09-14-12-04-38-116.png)|
| :--: | :--: | :--: | :--: |
|启动页|列表页|详情（内容）|详情（推荐）|



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


## 使用到的或推荐的一些优秀的第三方插件


| 名称 | GitHub地址 | 版本号 |
| :-- | :-- | :-- |
| 网络请求 | [dio](https://pub.dartlang.org/packages/dio) | ![](https://img.shields.io/pub/v/dio.svg) |
| 下拉刷新，上拉加载 |[FlutterEasyRefresh](https://github.com/xuelongqy/flutter_easyrefresh)|![](https://img.shields.io/pub/v/flutter_easyrefresh.svg)|
| Shared Preferences |[shared_preferences](https://github.com/flutter/plugins/tree/master/packages/shared_preferences)|![](https://img.shields.io/pub/v/shared_preferences.svg)| 
| 中国城市选择器 |[city_picker](https://github.com/CaiJingLong/flutter_city_picker)|![](https://img.shields.io/pub/v/city_picker.svg)|
| 设备信息 |[device_info](https://github.com/flutter/plugins/tree/master/packages/device_info)|![](https://img.shields.io/pub/v/device_info.svg)|
| url_launcher | [url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher) | ![](https://img.shields.io/pub/v/url_launcher.svg) | 
| 视频播放器 | [video_player](https://github.com/flutter/plugins/tree/master/packages/video_player) | ![](https://img.shields.io/pub/v/video_player.svg) | 
| Flutter WebView Plugin | [WebView](https://github.com/fluttercommunity/flutter_webview_plugin) | ![](https://img.shields.io/pub/v/flutter_webview_plugin.svg) | 
| PackageInfo | [package_info](https://github.com/flutter/plugins/tree/master/packages/package_info) | ![](https://img.shields.io/pub/v/package_info.svg) | 
| 系统分享 | [share](https://github.com/flutter/plugins/tree/master/packages/share) | ![](https://img.shields.io/pub/v/share.svg) |
| 引导页 | [intro-slider](https://github.com/duytq94/flutter-intro-slider) | ![](https://img.shields.io/pub/v/intro_slider.svg) |
| 评分控件 | [smooth_star_rating](https://github.com/thangmam/smoothratingbar) | ![](https://img.shields.io/pub/v/smooth_star_rating.svg) | 
| PhotoView | [PhotoView](https://github.com/renancaraujo/photo_view) | ![](https://img.shields.io/pub/v/photo_view.svg) | 
| 时间轴 | [TimeLine](https://github.com/furkantektas/timeline_list) | ![](https://img.shields.io/pub/v/timeline_list.svg) | 
| Rounded Letter | [rounded_letter](https://github.com/jhomlala/roundedletter) | ![](https://img.shields.io/pub/v/rounded_letter.svg) | 
| 数据库 | [sqfLite](https://github.com/tekartik/sqflite) | ![](https://img.shields.io/pub/v/sqflite.svg) | 
| 图片选择器 | [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker) | ![](https://img.shields.io/pub/v/image_picker.svg) | 
| 图片裁剪 | [image_crop](https://github.com/VolodymyrLykhonis/image_crop) |![](https://img.shields.io/pub/v/image_crop.svg)|
| 图片裁剪 | [image_cropper](https://github.com/hnvn/flutter_image_cropper) |![](https://img.shields.io/pub/v/image_cropper.svg)|
| 多图像选择器 | [Multi Image Picker](https://github.com/Sh1d0w/multi_image_picker) | ![](https://img.shields.io/pub/v/multi_image_picker.svg) | 
| 侧滑菜单 | [flutter_inner_drawer](https://github.com/Dn-a/flutter_inner_drawer) | ![](https://img.shields.io/pub/v/flutter_inner_drawer.svg) | 
| 字母索引、悬停 | [AZListView](https://github.com/flutterchina/azlistview) | ![](https://img.shields.io/pub/v/azlistview.svg) |
| 状态管理 | [provider](https://github.com/rrousselGit/provider) | ![](https://img.shields.io/pub/v/provider.svg) |
| 图表 | [fl_chart](https://github.com/imaNNeoFighT/fl_chart) | ![](https://img.shields.io/pub/v/fl_chart.svg) |
| 官方图表插件 | [charts_flutter](https://github.com/google/charts) | ![](https://img.shields.io/pub/v/charts_flutter.svg) |
| Badges | [badges](https://github.com/yadaniyil/flutter_badges) | ![](https://img.shields.io/pub/v/badges.svg) |
| Palette Generator | [palette_generator](https://github.com/flutter/packages/tree/master/packages/palette_generator) | ![](https://img.shields.io/pub/v/palette_generator.svg) |
| path_provider | [path_provider](https://github.com/flutter/plugins/tree/master/packages/path_provider) | ![](https://img.shields.io/pub/v/path_provider.svg) |
| 高德地图定位 | [AMapBaseLocation](https://github.com/OpenFlutter/amap_base_flutter) | ![](https://img.shields.io/pub/v/amap_base_location.svg) |
| 动画字体 | [animated_text_kit](https://github.com/aagarwal1012/Animated-Text-Kit) | ![](https://img.shields.io/pub/v/animated_text_kit.svg) |
| 集成图标库 |[flutter_vector_icons](https://github.com/pd4d10/flutter-vector-icons)| ![](https://img.shields.io/pub/v/flutter_vector_icons.svg) |
| 仿京东地址选择器 | [flutter_jd_address_selector](https://github.com/shichunlei/flutter_jd_address_selector) | 0.0.1 |
| cupertino_range_slider | [cupertino_range_slider](https://github.com/mahmed8003/cupertino_range_slider) | ![](https://img.shields.io/pub/v/cupertino_range_slider.svg) |
| flutter_circular_slider | [flutter_jd_address_selector](https://github.com/davidanaya/flutter-circular-slider) | ![](https://img.shields.io/pub/v/flutter_circular_slider.svg) |
| Range Slider | [range_slider](https://github.com/boeledi/RangeSlider) | ![](https://img.shields.io/pub/v/flutter_range_slider.svg) | 
| 径向菜单 | [UnicornDialer](https://github.com/tiagojencmartins/unicornspeeddial) | ![](https://img.shields.io/pub/v/unicorndial.svg) | 
| 音频播放 | [AudioPlayers](https://github.com/luanpotter/audioplayers) | ![](https://img.shields.io/pub/v/audioplayers.svg) | 
| 音频播放与录制 | [FlutterSound](https://github.com/dooboolab/flutter_sound) | ![](https://img.shields.io/pub/v/flutter_sound.svg) | 
| 音频播放（仅支持android） | [FluteMusicPlayer](https://github.com/iampawan/Flute-Music-Player) | ![](https://img.shields.io/pub/v/flute_music_player.svg) | 
| 音频录制并将其存储在本地 | [Audio Recorder](https://github.com/ZaraclaJ/audio_recorder) | ![](https://img.shields.io/pub/v/audio_recorder.svg) | 
| 音频播放 | [Stereo](https://github.com/2find/stereo) | ![](https://img.shields.io/pub/v/stereo.svg) | 
| 视频播放器 | [video_player](https://github.com/flutter/plugins/tree/master/packages/video_player) | ![](https://img.shields.io/pub/v/video_player.svg) | 
| 瀑布流布局 | [flutter_staggered_grid_view](https://github.com/letsar/flutter_staggered_grid_view) | ![](https://img.shields.io/pub/v/flutter_staggered_grid_view.svg) | 
| 骨架屏 | [Shimmer](https://github.com/hnvn/flutter_shimmer) | ![](https://img.shields.io/pub/v/shimmer.svg) | 


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
