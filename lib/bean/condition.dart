class Condition {
  String title;
  bool isSelected;
  String value;

  Condition({
    this.title,
    this.isSelected,
    this.value,
  });
}

List<Condition> countries = [
  Condition(title: "全部地区", value: "", isSelected: true),
  Condition(title: "中国大陆🇨🇳", value: "中国大陆", isSelected: false),
  Condition(title: "中国香港🇭🇰", value: "中国香港", isSelected: false),
  Condition(title: "中国台湾🇨🇳", value: "中国台湾", isSelected: false),
  Condition(title: "日本🇯🇵", value: "日本", isSelected: false),
  Condition(title: "韩国🇰🇷", value: "韩国", isSelected: false),
  Condition(title: "新加坡🇸🇬", value: "新加坡", isSelected: false),
  Condition(title: "美国🇺🇸", value: "美国", isSelected: false),
  Condition(title: "英国🇬🇧", value: "英国", isSelected: false),
  Condition(title: "法国🇫🇷", value: "法国", isSelected: false),
  Condition(title: "印度🇮🇳", value: "印度", isSelected: false),
  Condition(title: "越南🇻🇳", value: "越南", isSelected: false),
  Condition(title: "泰国🇹🇭", value: "泰国", isSelected: false),
  Condition(title: "伊朗🇮🇷", value: "伊朗", isSelected: false),
  Condition(title: "加拿大🇨🇦", value: "加拿大", isSelected: false),
  Condition(title: "意大利🇮🇹", value: "意大利", isSelected: false),
  Condition(title: "巴西🇧🇷", value: "巴西", isSelected: false),
  Condition(title: "瑞典🇸🇪", value: "瑞典", isSelected: false),
  Condition(title: "德国🇩🇪", value: "德国", isSelected: false),
  Condition(title: "澳大利亚🇦🇺", value: "澳大利亚", isSelected: false),
  Condition(title: "奥地利🇦🇹", value: "奥地利", isSelected: false),
  Condition(title: "芬兰🇫🇮", value: "芬兰", isSelected: false)
];

List<Condition> types = [
  Condition(title: "全部形式", value: "", isSelected: true),
  Condition(title: "电影", value: "电影", isSelected: false),
  Condition(title: "电视剧", value: "电视剧", isSelected: false),
  Condition(title: "综艺", value: "综艺", isSelected: false),
  Condition(title: "动漫", value: "动漫", isSelected: false),
  Condition(title: "纪录片", value: "纪录片", isSelected: false),
  Condition(title: "短片", value: "短片", isSelected: false)
];

List<Condition> genres = [
  Condition(title: "全部类型", value: "", isSelected: true),
  Condition(title: "喜剧", value: "喜剧", isSelected: false),
  Condition(title: "剧情", value: "剧情", isSelected: false),
  Condition(title: "动作", value: "动作", isSelected: false),
  Condition(title: "爱情", value: "爱情", isSelected: false),
  Condition(title: "科幻", value: "科幻", isSelected: false),
  Condition(title: "动画", value: "动画", isSelected: false),
  Condition(title: "悬疑", value: "悬疑", isSelected: false),
  Condition(title: "惊悚", value: "惊悚", isSelected: false),
  Condition(title: "恐怖", value: "恐怖", isSelected: false),
  Condition(title: "犯罪", value: "犯罪", isSelected: false),
  Condition(title: "同性", value: "同性", isSelected: false),
  Condition(title: "音乐", value: "音乐", isSelected: false),
  Condition(title: "歌舞", value: "歌舞", isSelected: false),
  Condition(title: "传记", value: "传记", isSelected: false),
  Condition(title: "历史", value: "历史", isSelected: false),
  Condition(title: "战争", value: "战争", isSelected: false),
  Condition(title: "西部", value: "西部", isSelected: false),
  Condition(title: "奇幻", value: "奇幻", isSelected: false),
  Condition(title: "冒险", value: "冒险", isSelected: false),
  Condition(title: "灾难", value: "灾难", isSelected: false),
  Condition(title: "武侠", value: "武侠", isSelected: false),
  Condition(title: "情色", value: "情色", isSelected: false)
];

List<Condition> sorts = [
  Condition(title: "近期热门", value: "U", isSelected: true),
  Condition(title: "标记最多", value: "T", isSelected: false),
  Condition(title: "评分最高", value: "S", isSelected: false),
  Condition(title: "最新上映", value: "R", isSelected: false)
];

List<Condition> years = [
  Condition(title: "全部年代", value: "", isSelected: true),
  Condition(title: "2019", value: "2019,2019", isSelected: false),
  Condition(title: "2018", value: "2018,2018", isSelected: false),
  Condition(title: "2010年代", value: "2010,2019", isSelected: false),
  Condition(title: "2000年代", value: "2000,2009", isSelected: false),
  Condition(title: "90年代", value: "1990,1999", isSelected: false),
  Condition(title: "80年代", value: "1980,1989", isSelected: false),
  Condition(title: "70年代", value: "1970,1979", isSelected: false),
  Condition(title: "60年代", value: "1960,1969", isSelected: false),
  Condition(title: "更早", value: "1,1959", isSelected: false)
];

List<Condition> features = [
  Condition(title: "经典", value: "经典", isSelected: false),
  Condition(title: "青春", value: "青春", isSelected: false),
  Condition(title: "文艺", value: "文艺", isSelected: false),
  Condition(title: "搞笑", value: "搞笑", isSelected: false),
  Condition(title: "励志", value: "励志", isSelected: false),
  Condition(title: "魔幻", value: "魔幻", isSelected: false),
  Condition(title: "感人", value: "感人", isSelected: false),
  Condition(title: "女性", value: "女性", isSelected: false),
  Condition(title: "黑帮", value: "黑帮", isSelected: false),
];

List<Condition> brandSortConditions = [
  Condition(title: '全部', value: '全部', isSelected: true),
  Condition(title: '金逸影城', value: '金逸影城', isSelected: false),
  Condition(title: '中影国际影城', value: '中影国际影城', isSelected: false),
  Condition(title: '星美国际影城', value: '星美国际影城', isSelected: false),
  Condition(title: '博纳国际影城', value: '博纳国际影城', isSelected: false),
  Condition(title: '大地影院', value: '大地影院', isSelected: false),
  Condition(title: '嘉禾影城', value: '嘉禾影城', isSelected: false),
  Condition(title: '太平洋影城', value: '太平洋影城', isSelected: false),
  Condition(title: '万达影城', value: '万达影城', isSelected: false),
  Condition(title: '华联影城', value: '华联影城', isSelected: false),
  Condition(title: '耀莱成龙影城', value: '耀莱成龙影城', isSelected: false),
  Condition(title: '深影国际影城', value: '深影国际影城', isSelected: false),
  Condition(title: '完美世界影城', value: '完美世界影城', isSelected: false),
  Condition(title: '新华国际影城', value: '新华国际影城', isSelected: false),
  Condition(title: '魔影国际影城', value: '魔影国际影城', isSelected: false),
  Condition(title: 'UME影城', value: 'UME影城', isSelected: false),
  Condition(title: '金逸影城', value: '金逸影城', isSelected: false),
  Condition(title: '美嘉欢乐影城', value: '美嘉欢乐影城', isSelected: false)
];

List<Condition> distanceSortConditions = [
  Condition(title: '距离近', value: "距离近", isSelected: true),
  Condition(title: '价格低', value: "价格低", isSelected: false)
];
