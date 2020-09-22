/// 输出Log工具类
class Log {
  static d(Object msg, {tag: 'LOG', stag: '   d   '}) {
    _print(msg, tag: tag, stag: stag);
  }

  static i(String msg, {tag: 'LOG', stag: '   i   '}) {
    _print(msg, tag: tag, stag: stag);
  }

  static e(String msg, {tag: 'LOG', stag: '   e   '}) {
    _print(msg, tag: tag, stag: stag);
  }

  static json(String msg, {tag: 'LOG'}) {
    _print(msg, tag: tag);
  }

  static _print(Object msg, {tag: 'X-LOG', stag: '   v   '}) {
    /// 单元测试不必初始化Log工具类，直接使用print输出。
    if (!bool.fromEnvironment("dart.vm.product") && msg != null) {
      String message = msg.toString();
      if (message.isNotEmpty && message.length > 512) {
        print("$tag $stag ${message.substring(0, 512)}");
        message = message.substring(512, message.length);
        while (message.isNotEmpty) {
          if (message.length > 512) {
            print("${message.substring(0, 512)}");
            message = message.substring(512, message.length);
          } else {
            print("$message");
            message = "";
          }
        }
      } else {
        print("$tag $stag $message");
      }
    }
  }
}
