class Category {
  /**
   * mallCategoryId : "4"
   * mallCategoryName : "白酒"
   * image : "http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170036_4477.png"
   * comments : null
   * bxMallSubDto : [{"mallSubId":"2c9f6c94621970a801626a35cb4d0175","mallCategoryId":"4","mallSubName":"名酒","comments":""}]
   */

  String mallCategoryId;
  String mallCategoryName;
  String image;
  String comments;
  List<SubCategory> bxMallSubDto;

  static Category fromMap(Map<String, dynamic> map) {
    Category category = Category();
    category.mallCategoryId = map['mallCategoryId'];
    category.mallCategoryName = map['mallCategoryName'];
    category.image = map['image'];
    category.comments = map['comments'];
    category.bxMallSubDto = SubCategory.fromMapList(map['bxMallSubDto']);
    return category;
  }

  static List<Category> fromMapList(dynamic mapList) {
    List<Category> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class SubCategory {
  /**
   * mallSubId : "2c9f6c94621970a801626a35cb4d0175"
   * mallCategoryId : "4"
   * mallSubName : "名酒"
   * comments : ""
   */

  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  static SubCategory fromMap(Map<String, dynamic> map) {
    SubCategory bxMallSubDtoListBean = SubCategory();
    bxMallSubDtoListBean.mallSubId = map['mallSubId'];
    bxMallSubDtoListBean.mallCategoryId = map['mallCategoryId'];
    bxMallSubDtoListBean.mallSubName = map['mallSubName'];
    bxMallSubDtoListBean.comments = map['comments'];
    return bxMallSubDtoListBean;
  }

  static List<SubCategory> fromMapList(dynamic mapList) {
    List<SubCategory> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
