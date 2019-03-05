# flutter_app

A new Flutter application.

## 运行截图

|![0](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-18-13-58-429.png)|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-11-913.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-44-611.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-01-953.png)|
| :--: | :--: | :--: | :--: |
|首页|侧边栏|随机诗词|二维码（生成/扫描）|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-15-38-136.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-15-42-485.png)|
| :--: | :--: |
|登录|注册|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-13-51-495.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-14-03-080.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-14-45-013.png)|
| :--: | :--: | :--: |
|电影（ListView）|电影（GridView）|电影详情|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-39-35-311.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-39-48-539.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-28-09-40-04-052.png)|
| :--: | :--: | :--: |
|瀑布流|评分效果|多边形控件|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-23-860.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-11-34-612.png)|
| :--: | :--: |
|城市|城市天气预报|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-28-563.png)|![2](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-01-30-15-12-47-846.png)|![3](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-11-31-58-569.png)|![4](https://github.com/shichunlei/flutter_app/blob/master/screenshots/Screenshot_2019-02-13-11-31-19-566.png)|
| :--: | :--: | :--: | :--: |
|LikeButton|Chip|侧滑删除|仿探探|


|![1](https://github.com/shichunlei/flutter_app/blob/master/screenshots/timeline_list.png)|
| :--: |
|TimeLine|


# 使用到的第三方插件

| Plugin | 地址 | Pub | 描述 |
| :--: | :--: | :--: | :-- |
| 网络请求 | [dio](https://pub.dartlang.org/packages/dio) | ![](https://camo.githubusercontent.com/cdfb640de2cc8eeb0f6bfa1bda82422d83d87785/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f64696f2e7376673f7374796c653d666c61742d737175617265) | Dart的一个强大的Http客户端，支持拦截器、全局配置、FormData、请求取消、文件下载、超时等。 |
| 下拉刷新，上拉加载 |[pull_to_refresh](https://github.com/peng8350/flutter_pulltorefresh)|1.1.6|一个提供上拉加载和下拉刷新的组件,同时支持Android和Ios)|
| 下拉刷新，上拉加载 |[flutter_easyrefresh](https://github.com/xuelongqy/flutter_easyrefresh)|![](https://camo.githubusercontent.com/c96857ee880abb5c8d65ab657cbd60836739533b/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f7075622d76312e322e352d6f72616e67652e737667)|正如名字一样，EasyRefresh很容易就能在Flutter应用上实现下拉刷新以及上拉加载操作，它支持几乎所有的Flutter控件，但前提是需要包裹成ScrollView。它的功能与Android的SmartRefreshLayout很相似，同样也吸取了很多三方库的优点。EasyRefresh中集成了多种风格的Header和Footer，但是它并没有局限性，你可以很轻松的自定义。使用Flutter强大的动画，甚至随便一个简单的控件也可以完成。EasyRefresh的目标是为Flutter打造一个强大，稳定，成熟的下拉刷新框架。|
| Shared preferences |[shared_preferences](https://github.com/flutter/plugins/tree/master/packages/shared_preferences)|![](https://camo.githubusercontent.com/b9af89a46da89444505ead9b0a7245e883d17afb/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f7368617265645f707265666572656e6365732e737667)| Shared preferences plugin |
| 中国城市选择器 |[city_picker](https://github.com/CaiJingLong/flutter_city_picker)|![](https://camo.githubusercontent.com/24b9365f7514f94b06178f06f81397d0d75d80c4/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f636974795f7069636b65722e737667)|A city picker of china, 中国城市选择器|
| 设备信息 |[device_info](https://github.com/flutter/plugins/tree/master/packages/device_info)|![](https://camo.githubusercontent.com/965d0090e8f547b318f37fcf6e0e30ccebc2dfaf/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f6465766963655f696e666f2e737667)|Get current device information from within the Flutter application.|
| image_picker | [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker) | ![](https://camo.githubusercontent.com/50ed2cc4c99917d2dfb12b44e5ab9356f70d63b7/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f696d6167655f7069636b65722e737667) | A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera. |
| url_launcher | [url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher) | ![](https://camo.githubusercontent.com/73ce49295f296939f5fc90be9ce94ca8c7bd7e44/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f75726c5f6c61756e636865722e737667) | A Flutter plugin for launching a URL in the mobile platform. Supports iOS and Android. |
| Video Player | [video_player](https://github.com/flutter/plugins/tree/master/packages/video_player) | ![](https://camo.githubusercontent.com/de09dde7ce935f4e176c1ce00f7e31e4b0e5c14f/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f766964656f5f706c617965722e737667) | A Flutter plugin for iOS and Android for playing back video on a Widget surface. |
| WebView for Flutter | [webview_flutter](https://github.com/flutter/plugins/tree/master/packages/webview_flutter) | ![](https://camo.githubusercontent.com/47c9187771ccb2e7aaf6c4bfb69e37a122ed3262/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f776562766965775f666c75747465722e737667) | A Flutter plugin that provides a WebView widget. On iOS the WebView widget is backed by a WKWebView; On Android the WebView widget is backed by a WebView. |
| PackageInfo | [package_info](https://github.com/flutter/plugins/tree/master/packages/package_info) | ![](https://camo.githubusercontent.com/01a75953af6fc91e941c2b5ba32162f55d795403/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f706174685f70726f76696465722e737667) | This Flutter plugin provides an API for querying information about an application package. |
| Share plugin | [share](https://github.com/flutter/plugins/tree/master/packages/share) | ![](https://camo.githubusercontent.com/afe573869b306315562203bca3cf9a85ac94ccf5/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f73686172652e737667) | A Flutter plugin to share content from your Flutter app via the platform's share dialog. Wraps the ACTION_SEND Intent on Android and UIActivityViewController on iOS. |







