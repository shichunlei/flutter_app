enum ImageType { network, assets, localFile }

enum LineType { vertical, horizontal }

///页面的模式
enum LoginMode {
  ///登录账户
  LOGIN,

  ///注册账户
  REGIST
}

enum LoaderState { NoAction, Loading, Succeed, Failed, NoData }

enum RefreshType { DEFAULT, LOAD_MORE, REFRESH }

enum Rotation { LR, RL, TB, BT, TL2BR, BL2TR, TR2BL, BR2TL }

enum Direction { LEFT, RIGHT, UP, DOWN }

enum ButtonShape {
  NORMAL,
  // 圆角
  Fillet,
  // 方角
  SQUARE_CORNER,
  // 圆形
  CIRCLE,
  // 边框
  OUTLINE
}
