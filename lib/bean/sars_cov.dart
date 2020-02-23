import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/utils/date_format.dart';

/// id : 1
/// createTime : 1579537899000
/// modifyTime : 1581992704000
/// imgUrl : "http://49.232.173.220:3001/images/distribution-nationale.png?time=1581994285686"
/// summary : ""
/// deleted : false
/// countRemark : ""
/// currentConfirmedCount : 58092
/// confirmedCount : 72528
/// suspectedCount : 6242
/// curedCount : 12566
/// deadCount : 1870
/// seriousCount : 11741
/// suspectedIncr : 1432
/// currentConfirmedIncr : 87
/// confirmedIncr : 1891
/// curedIncr : 1706
/// deadIncr : 98
/// seriousIncr : 1097
/// remark1 : "易感人群：人群普遍易感。老年人及有基础疾病者感染后病情较重，儿童及婴幼儿也有发病"
/// remark2 : "潜伏期：一般为 3～7 天，最长不超过 14 天，潜伏期内可能存在传染性，其中无症状病例传染性非常罕见"
/// remark3 : "宿主：野生动物，可能为中华菊头蝠"
/// remark4 : ""
/// remark5 : ""
/// note1 : "病毒：SARS-CoV-2，其导致疾病命名 COVID-19"
/// note2 : "传染源：新冠肺炎的患者。无症状感染者也可能成为传染源。"
/// note3 : "传播途径：经呼吸道飞沫、接触传播是主要的传播途径。气溶胶传播和消化道等传播途径尚待明确。"
/// generalRemark : "疑似病例数来自国家卫健委数据，目前为全国数据，未分省市自治区等"
/// abroadRemark : ""
/// marquee : [{"id":518,"marqueeLabel":"公告","marqueeContent":"买药不出门，在线开药顺丰到家","marqueeLink":"https://dxy.me/zDm8FH"},{"id":519,"marqueeLabel":"公告","marqueeContent":"加入孕妇答疑社群（疫情期免费）","marqueeLink":"https://mama.dxy.com/dispatch-jian-qun-bao?source=2"}]
/// quanguoTrendChart : [{"imgUrl":"https://img1.dxycdn.com/2020/0218/592/3397287380636754478-135.png","title":"新增疑似/新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0218/919/3397287393522086402-135.png","title":"确诊/疑似"},{"imgUrl":"https://img1.dxycdn.com/2020/0218/281/3397287406406988895-135.png","title":"死亡/治愈"},{"imgUrl":"https://img1.dxycdn.com/2020/0218/638/3397287419291462033-135.png","title":"病死率/治愈率"}]
/// hbFeiHbTrendChart : [{"imgUrl":"https://img1.dxycdn.com/2020/0218/144/3397287438619245257-135.png","title":"新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0218/415/3397287449356234699-135.png","title":"确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0218/142/3397287462241137240-135.png","title":"死亡/治愈"},{"imgUrl":"https://img1.dxycdn.com/2020/0218/939/3397287477273690674-135.png","title":"病死率"},{"imgUrl":"https://img1.dxycdn.com/2020/0218/577/3397287490158593248-135.png","title":"治愈率"}]
/// provinces : [{"provinceName":"湖北省","provinceShortName":"湖北","currentConfirmedCount":50338,"confirmedCount":59989,"suspectedCount":0,"curedCount":7862,"deadCount":1789,"comment":"","locationId":420000,"cities":[{"cityName":"武汉","currentConfirmedCount":37152,"confirmedCount":42752,"suspectedCount":0,"curedCount":4219,"deadCount":1381,"locationId":420100},{"cityName":"孝感","currentConfirmedCount":2722,"confirmedCount":3320,"suspectedCount":0,"curedCount":523,"deadCount":75,"locationId":420900},{"cityName":"黄冈","currentConfirmedCount":1803,"confirmedCount":2828,"suspectedCount":0,"curedCount":941,"deadCount":84,"locationId":421100},{"cityName":"荆州","currentConfirmedCount":1160,"confirmedCount":1537,"suspectedCount":0,"curedCount":339,"deadCount":38,"locationId":421000},{"cityName":"随州","currentConfirmedCount":1055,"confirmedCount":1278,"suspectedCount":0,"curedCount":198,"deadCount":25,"locationId":421300},{"cityName":"鄂州","currentConfirmedCount":1038,"confirmedCount":1339,"suspectedCount":0,"curedCount":265,"deadCount":36,"locationId":420700},{"cityName":"襄阳","currentConfirmedCount":960,"confirmedCount":1163,"suspectedCount":0,"curedCount":182,"deadCount":21,"locationId":420600},{"cityName":"黄石","currentConfirmedCount":750,"confirmedCount":985,"suspectedCount":0,"curedCount":215,"deadCount":20,"locationId":420200},{"cityName":"荆门","currentConfirmedCount":724,"confirmedCount":900,"suspectedCount":0,"curedCount":143,"deadCount":33,"locationId":420800},{"cityName":"宜昌","currentConfirmedCount":694,"confirmedCount":904,"suspectedCount":0,"curedCount":186,"deadCount":24,"locationId":420500},{"cityName":"咸宁","currentConfirmedCount":654,"confirmedCount":868,"suspectedCount":0,"curedCount":204,"deadCount":10,"locationId":421200},{"cityName":"十堰","currentConfirmedCount":480,"confirmedCount":626,"suspectedCount":0,"curedCount":144,"deadCount":2,"locationId":420300},{"cityName":"天门","currentConfirmedCount":434,"confirmedCount":500,"suspectedCount":0,"curedCount":55,"deadCount":11,"locationId":429006},{"cityName":"仙桃","currentConfirmedCount":404,"confirmedCount":544,"suspectedCount":0,"curedCount":121,"deadCount":19,"locationId":429004},{"cityName":"恩施州","currentConfirmedCount":156,"confirmedCount":250,"suspectedCount":0,"curedCount":90,"deadCount":4,"locationId":422800},{"cityName":"潜江","currentConfirmedCount":152,"confirmedCount":185,"suspectedCount":0,"curedCount":27,"deadCount":6,"locationId":429005},{"cityName":"神农架林区","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":429021}]},{"provinceName":"广东省","provinceShortName":"广东","currentConfirmedCount":794,"confirmedCount":1328,"suspectedCount":0,"curedCount":530,"deadCount":4,"comment":"","locationId":440000,"cities":[{"cityName":"深圳","currentConfirmedCount":262,"confirmedCount":416,"suspectedCount":0,"curedCount":152,"deadCount":2,"locationId":440300},{"cityName":"广州","currentConfirmedCount":207,"confirmedCount":339,"suspectedCount":0,"curedCount":132,"deadCount":0,"locationId":440100},{"cityName":"东莞","currentConfirmedCount":71,"confirmedCount":91,"suspectedCount":0,"curedCount":19,"deadCount":1,"locationId":441900},{"cityName":"佛山","currentConfirmedCount":61,"confirmedCount":84,"suspectedCount":0,"curedCount":23,"deadCount":0,"locationId":440600},{"cityName":"珠海","currentConfirmedCount":57,"confirmedCount":98,"suspectedCount":0,"curedCount":41,"deadCount":0,"locationId":440400},{"cityName":"中山","currentConfirmedCount":27,"confirmedCount":66,"suspectedCount":0,"curedCount":39,"deadCount":0,"locationId":442000},{"cityName":"惠州","currentConfirmedCount":25,"confirmedCount":59,"suspectedCount":0,"curedCount":34,"deadCount":0,"locationId":441300},{"cityName":"江门","currentConfirmedCount":18,"confirmedCount":23,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":440700},{"cityName":"汕头","currentConfirmedCount":11,"confirmedCount":25,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":440500},{"cityName":"湛江","currentConfirmedCount":11,"confirmedCount":22,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":440800},{"cityName":"茂名","currentConfirmedCount":11,"confirmedCount":14,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":440900},{"cityName":"肇庆","currentConfirmedCount":9,"confirmedCount":18,"suspectedCount":0,"curedCount":8,"deadCount":1,"locationId":441200},{"cityName":"梅州","currentConfirmedCount":8,"confirmedCount":16,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":441400},{"cityName":"韶关","currentConfirmedCount":6,"confirmedCount":10,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":440200},{"cityName":"阳江","currentConfirmedCount":4,"confirmedCount":13,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":441700},{"cityName":"揭阳","currentConfirmedCount":4,"confirmedCount":8,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":445200},{"cityName":"潮州","currentConfirmedCount":4,"confirmedCount":5,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":445100},{"cityName":"清远","currentConfirmedCount":3,"confirmedCount":12,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":441800},{"cityName":"汕尾","currentConfirmedCount":3,"confirmedCount":5,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":441500},{"cityName":"河源","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":441600},{"cityName":"待明确地区","currentConfirmedCount":-11,"confirmedCount":0,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":0}]},{"provinceName":"河南省","provinceShortName":"河南","currentConfirmedCount":733,"confirmedCount":1257,"suspectedCount":0,"curedCount":505,"deadCount":19,"comment":"参考卫健委统计口径，部分县区与地级市合并","locationId":410000,"cities":[{"cityName":"信阳","currentConfirmedCount":180,"confirmedCount":266,"suspectedCount":0,"curedCount":84,"deadCount":2,"locationId":411500},{"cityName":"南阳","currentConfirmedCount":88,"confirmedCount":155,"suspectedCount":0,"curedCount":65,"deadCount":2,"locationId":411300},{"cityName":"郑州","currentConfirmedCount":81,"confirmedCount":154,"suspectedCount":0,"curedCount":73,"deadCount":0,"locationId":410100},{"cityName":"驻马店","currentConfirmedCount":67,"confirmedCount":139,"suspectedCount":0,"curedCount":72,"deadCount":0,"locationId":411700},{"cityName":"周口","currentConfirmedCount":46,"confirmedCount":76,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":411600},{"cityName":"商丘","currentConfirmedCount":42,"confirmedCount":91,"suspectedCount":0,"curedCount":46,"deadCount":3,"locationId":411400},{"cityName":"新乡","currentConfirmedCount":34,"confirmedCount":57,"suspectedCount":0,"curedCount":21,"deadCount":2,"locationId":410700},{"cityName":"平顶山","currentConfirmedCount":30,"confirmedCount":58,"suspectedCount":0,"curedCount":27,"deadCount":1,"locationId":410400},{"cityName":"安阳","currentConfirmedCount":28,"confirmedCount":52,"suspectedCount":0,"curedCount":24,"deadCount":0,"locationId":410500},{"cityName":"许昌","currentConfirmedCount":27,"confirmedCount":38,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":411000},{"cityName":"焦作","currentConfirmedCount":24,"confirmedCount":32,"suspectedCount":0,"curedCount":7,"deadCount":1,"locationId":410800},{"cityName":"漯河","currentConfirmedCount":22,"confirmedCount":34,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":411100},{"cityName":"洛阳","currentConfirmedCount":20,"confirmedCount":31,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":410300},{"cityName":"开封","currentConfirmedCount":17,"confirmedCount":26,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":410200},{"cityName":"鹤壁","currentConfirmedCount":14,"confirmedCount":19,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":410600},{"cityName":"濮阳","currentConfirmedCount":13,"confirmedCount":17,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":410900},{"cityName":"济源","currentConfirmedCount":5,"confirmedCount":5,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":419001},{"cityName":"三门峡","currentConfirmedCount":3,"confirmedCount":7,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":411200},{"cityName":"待明确地区","currentConfirmedCount":-8,"confirmedCount":0,"suspectedCount":0,"curedCount":0,"deadCount":8,"locationId":0}]},{"provinceName":"安徽省","provinceShortName":"安徽","currentConfirmedCount":683,"confirmedCount":982,"suspectedCount":0,"curedCount":293,"deadCount":6,"comment":"","locationId":340000,"cities":[{"cityName":"蚌埠","currentConfirmedCount":134,"confirmedCount":158,"suspectedCount":0,"curedCount":19,"deadCount":5,"locationId":340300},{"cityName":"合肥","currentConfirmedCount":123,"confirmedCount":173,"suspectedCount":0,"curedCount":49,"deadCount":1,"locationId":340100},{"cityName":"阜阳","currentConfirmedCount":113,"confirmedCount":154,"suspectedCount":0,"curedCount":41,"deadCount":0,"locationId":341200},{"cityName":"亳州","currentConfirmedCount":73,"confirmedCount":108,"suspectedCount":0,"curedCount":35,"deadCount":0,"locationId":341600},{"cityName":"安庆","currentConfirmedCount":49,"confirmedCount":83,"suspectedCount":0,"curedCount":34,"deadCount":0,"locationId":340800},{"cityName":"六安","currentConfirmedCount":47,"confirmedCount":68,"suspectedCount":0,"curedCount":21,"deadCount":0,"locationId":341500},{"cityName":"宿州","currentConfirmedCount":25,"confirmedCount":41,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":341300},{"cityName":"马鞍山","currentConfirmedCount":24,"confirmedCount":36,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":340500},{"cityName":"芜湖","currentConfirmedCount":20,"confirmedCount":33,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":340200},{"cityName":"淮南","currentConfirmedCount":19,"confirmedCount":27,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":340400},{"cityName":"铜陵","currentConfirmedCount":18,"confirmedCount":29,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":340700},{"cityName":"淮北","currentConfirmedCount":16,"confirmedCount":27,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":340600},{"cityName":"池州","currentConfirmedCount":11,"confirmedCount":17,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":341700},{"cityName":"滁州","currentConfirmedCount":6,"confirmedCount":13,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":341100},{"cityName":"黄山","currentConfirmedCount":6,"confirmedCount":9,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":341000},{"cityName":"宣城","currentConfirmedCount":2,"confirmedCount":6,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":341800},{"cityName":"待明确地区","currentConfirmedCount":-3,"confirmedCount":0,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":0}]},{"provinceName":"浙江省","provinceShortName":"浙江","currentConfirmedCount":658,"confirmedCount":1172,"suspectedCount":0,"curedCount":514,"deadCount":0,"comment":"","locationId":330000,"cities":[{"cityName":"温州","currentConfirmedCount":310,"confirmedCount":504,"suspectedCount":0,"curedCount":194,"deadCount":0,"locationId":330300},{"cityName":"宁波","currentConfirmedCount":88,"confirmedCount":156,"suspectedCount":0,"curedCount":68,"deadCount":0,"locationId":330200},{"cityName":"台州","currentConfirmedCount":82,"confirmedCount":146,"suspectedCount":0,"curedCount":64,"deadCount":0,"locationId":331000},{"cityName":"杭州","currentConfirmedCount":74,"confirmedCount":168,"suspectedCount":0,"curedCount":94,"deadCount":0,"locationId":330100},{"cityName":"嘉兴","currentConfirmedCount":29,"confirmedCount":43,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":330400},{"cityName":"金华","currentConfirmedCount":25,"confirmedCount":55,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":330700},{"cityName":"绍兴","currentConfirmedCount":23,"confirmedCount":42,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":330600},{"cityName":"衢州","currentConfirmedCount":11,"confirmedCount":21,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":330800},{"cityName":"丽水","currentConfirmedCount":6,"confirmedCount":17,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":331100},{"cityName":"舟山","currentConfirmedCount":5,"confirmedCount":10,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":330900},{"cityName":"湖州","currentConfirmedCount":5,"confirmedCount":10,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":330500}]},{"provinceName":"江西省","provinceShortName":"江西","currentConfirmedCount":622,"confirmedCount":933,"suspectedCount":0,"curedCount":310,"deadCount":1,"comment":"","locationId":360000,"cities":[{"cityName":"南昌","currentConfirmedCount":134,"confirmedCount":229,"suspectedCount":0,"curedCount":95,"deadCount":0,"locationId":360100},{"cityName":"九江","currentConfirmedCount":88,"confirmedCount":118,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":360400},{"cityName":"上饶","currentConfirmedCount":84,"confirmedCount":123,"suspectedCount":0,"curedCount":39,"deadCount":0,"locationId":361100},{"cityName":"新余","currentConfirmedCount":83,"confirmedCount":129,"suspectedCount":0,"curedCount":46,"deadCount":0,"locationId":360500},{"cityName":"宜春","currentConfirmedCount":76,"confirmedCount":106,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":360900},{"cityName":"赣州","currentConfirmedCount":55,"confirmedCount":76,"suspectedCount":0,"curedCount":20,"deadCount":1,"locationId":360700},{"cityName":"抚州","currentConfirmedCount":44,"confirmedCount":72,"suspectedCount":0,"curedCount":28,"deadCount":0,"locationId":361000},{"cityName":"萍乡","currentConfirmedCount":27,"confirmedCount":33,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":360300},{"cityName":"鹰潭","currentConfirmedCount":15,"confirmedCount":18,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":360600},{"cityName":"吉安","currentConfirmedCount":12,"confirmedCount":22,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":360800},{"cityName":"景德镇","currentConfirmedCount":3,"confirmedCount":6,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":360200},{"cityName":"赣江新区","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0}]},{"provinceName":"湖南省","provinceShortName":"湖南","currentConfirmedCount":502,"confirmedCount":1007,"suspectedCount":0,"curedCount":501,"deadCount":4,"comment":"","locationId":430000,"cities":[{"cityName":"长沙","currentConfirmedCount":147,"confirmedCount":241,"suspectedCount":0,"curedCount":92,"deadCount":2,"locationId":430100},{"cityName":"岳阳","currentConfirmedCount":91,"confirmedCount":155,"suspectedCount":0,"curedCount":63,"deadCount":1,"locationId":430600},{"cityName":"常德","currentConfirmedCount":45,"confirmedCount":79,"suspectedCount":0,"curedCount":34,"deadCount":0,"locationId":430700},{"cityName":"株洲","currentConfirmedCount":43,"confirmedCount":78,"suspectedCount":0,"curedCount":35,"deadCount":0,"locationId":430200},{"cityName":"娄底","currentConfirmedCount":41,"confirmedCount":76,"suspectedCount":0,"curedCount":35,"deadCount":0,"locationId":431300},{"cityName":"邵阳","currentConfirmedCount":33,"confirmedCount":101,"suspectedCount":0,"curedCount":67,"deadCount":1,"locationId":430500},{"cityName":"益阳","currentConfirmedCount":29,"confirmedCount":59,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":430900},{"cityName":"衡阳","currentConfirmedCount":20,"confirmedCount":48,"suspectedCount":0,"curedCount":28,"deadCount":0,"locationId":430400},{"cityName":"湘潭","currentConfirmedCount":19,"confirmedCount":35,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":430300},{"cityName":"永州","currentConfirmedCount":13,"confirmedCount":43,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":431100},{"cityName":"郴州","currentConfirmedCount":13,"confirmedCount":39,"suspectedCount":0,"curedCount":26,"deadCount":0,"locationId":431000},{"cityName":"怀化","currentConfirmedCount":6,"confirmedCount":40,"suspectedCount":0,"curedCount":34,"deadCount":0,"locationId":431200},{"cityName":"湘西自治州","currentConfirmedCount":2,"confirmedCount":8,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":433100},{"cityName":"张家界","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":430800}]},{"provinceName":"黑龙江省","provinceShortName":"黑龙江","currentConfirmedCount":368,"confirmedCount":464,"suspectedCount":0,"curedCount":85,"deadCount":11,"comment":"","locationId":230000,"cities":[{"cityName":"哈尔滨","currentConfirmedCount":155,"confirmedCount":190,"suspectedCount":0,"curedCount":32,"deadCount":3,"locationId":230100},{"cityName":"双鸭山","currentConfirmedCount":46,"confirmedCount":52,"suspectedCount":0,"curedCount":4,"deadCount":2,"locationId":230500},{"cityName":"鸡西","currentConfirmedCount":44,"confirmedCount":46,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":230300},{"cityName":"齐齐哈尔","currentConfirmedCount":32,"confirmedCount":43,"suspectedCount":0,"curedCount":10,"deadCount":1,"locationId":230200},{"cityName":"绥化","currentConfirmedCount":28,"confirmedCount":46,"suspectedCount":0,"curedCount":14,"deadCount":4,"locationId":231200},{"cityName":"大庆","currentConfirmedCount":15,"confirmedCount":20,"suspectedCount":0,"curedCount":4,"deadCount":1,"locationId":230600},{"cityName":"黑河","currentConfirmedCount":14,"confirmedCount":14,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":231100},{"cityName":"七台河","currentConfirmedCount":13,"confirmedCount":17,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":230900},{"cityName":"牡丹江","currentConfirmedCount":12,"confirmedCount":13,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":231000},{"cityName":"佳木斯","currentConfirmedCount":4,"confirmedCount":15,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":230800},{"cityName":"鹤岗","currentConfirmedCount":3,"confirmedCount":5,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":230400},{"cityName":"大兴安岭","currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":232700},{"cityName":"伊春","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":230700}]},{"provinceName":"江苏省","provinceShortName":"江苏","currentConfirmedCount":366,"confirmedCount":629,"suspectedCount":0,"curedCount":263,"deadCount":0,"comment":"","locationId":320000,"cities":[{"cityName":"南京","currentConfirmedCount":60,"confirmedCount":92,"suspectedCount":0,"curedCount":32,"deadCount":0,"locationId":320100},{"cityName":"苏州","currentConfirmedCount":56,"confirmedCount":87,"suspectedCount":0,"curedCount":31,"deadCount":0,"locationId":320500},{"cityName":"淮安","currentConfirmedCount":38,"confirmedCount":66,"suspectedCount":0,"curedCount":28,"deadCount":0,"locationId":320800},{"cityName":"徐州","currentConfirmedCount":37,"confirmedCount":79,"suspectedCount":0,"curedCount":42,"deadCount":0,"locationId":320300},{"cityName":"无锡","currentConfirmedCount":34,"confirmedCount":55,"suspectedCount":0,"curedCount":21,"deadCount":0,"locationId":320200},{"cityName":"连云港","currentConfirmedCount":34,"confirmedCount":48,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":320700},{"cityName":"常州","currentConfirmedCount":30,"confirmedCount":50,"suspectedCount":0,"curedCount":20,"deadCount":0,"locationId":320400},{"cityName":"南通","currentConfirmedCount":21,"confirmedCount":40,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":320600},{"cityName":"泰州","currentConfirmedCount":16,"confirmedCount":37,"suspectedCount":0,"curedCount":21,"deadCount":0,"locationId":321200},{"cityName":"扬州","currentConfirmedCount":14,"confirmedCount":23,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":321000},{"cityName":"盐城","currentConfirmedCount":13,"confirmedCount":27,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":320900},{"cityName":"镇江","currentConfirmedCount":7,"confirmedCount":12,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":321100},{"cityName":"宿迁","currentConfirmedCount":6,"confirmedCount":13,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":321300}]},{"provinceName":"山东省","provinceShortName":"山东","currentConfirmedCount":348,"confirmedCount":543,"suspectedCount":0,"curedCount":193,"deadCount":2,"comment":"","locationId":370000,"cities":[{"cityName":"济南","currentConfirmedCount":34,"confirmedCount":47,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":370100},{"cityName":"烟台","currentConfirmedCount":34,"confirmedCount":47,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":370600},{"cityName":"潍坊","currentConfirmedCount":33,"confirmedCount":44,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":370700},{"cityName":"济宁","currentConfirmedCount":32,"confirmedCount":52,"suspectedCount":0,"curedCount":20,"deadCount":0,"locationId":370800},{"cityName":"青岛","currentConfirmedCount":31,"confirmedCount":58,"suspectedCount":0,"curedCount":26,"deadCount":1,"locationId":370200},{"cityName":"威海","currentConfirmedCount":29,"confirmedCount":38,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":371000},{"cityName":"德州","currentConfirmedCount":27,"confirmedCount":37,"suspectedCount":0,"curedCount":9,"deadCount":1,"locationId":371400},{"cityName":"聊城","currentConfirmedCount":26,"confirmedCount":38,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":371500},{"cityName":"泰安","currentConfirmedCount":26,"confirmedCount":32,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":370900},{"cityName":"淄博","currentConfirmedCount":24,"confirmedCount":29,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":370300},{"cityName":"枣庄","currentConfirmedCount":17,"confirmedCount":24,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":370400},{"cityName":"临沂","currentConfirmedCount":13,"confirmedCount":48,"suspectedCount":0,"curedCount":35,"deadCount":0,"locationId":371300},{"cityName":"日照","currentConfirmedCount":12,"confirmedCount":16,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":371100},{"cityName":"菏泽","currentConfirmedCount":5,"confirmedCount":18,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":371700},{"cityName":"滨州","currentConfirmedCount":5,"confirmedCount":15,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":371600}]},{"provinceName":"四川省","provinceShortName":"四川","currentConfirmedCount":342,"confirmedCount":508,"suspectedCount":0,"curedCount":163,"deadCount":3,"comment":"","locationId":510000,"cities":[{"cityName":"成都","currentConfirmedCount":83,"confirmedCount":140,"suspectedCount":0,"curedCount":56,"deadCount":1,"locationId":510100},{"cityName":"甘孜州","currentConfirmedCount":56,"confirmedCount":62,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":513300},{"cityName":"达州","currentConfirmedCount":31,"confirmedCount":39,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":511700},{"cityName":"南充","currentConfirmedCount":26,"confirmedCount":38,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":511300},{"cityName":"巴中","currentConfirmedCount":21,"confirmedCount":24,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":511900},{"cityName":"广安","currentConfirmedCount":16,"confirmedCount":30,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":511600},{"cityName":"内江","currentConfirmedCount":16,"confirmedCount":22,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":511000},{"cityName":"泸州","currentConfirmedCount":16,"confirmedCount":19,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":510500},{"cityName":"德阳","currentConfirmedCount":16,"confirmedCount":17,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":510600},{"cityName":"绵阳","currentConfirmedCount":13,"confirmedCount":22,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":510700},{"cityName":"遂宁","currentConfirmedCount":8,"confirmedCount":17,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":510900},{"cityName":"凉山州","currentConfirmedCount":8,"confirmedCount":13,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":513400},{"cityName":"自贡","currentConfirmedCount":7,"confirmedCount":9,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":510300},{"cityName":"宜宾","currentConfirmedCount":6,"confirmedCount":12,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":511500},{"cityName":"眉山","currentConfirmedCount":6,"confirmedCount":8,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":511400},{"cityName":"攀枝花","currentConfirmedCount":5,"confirmedCount":16,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":510400},{"cityName":"雅安","currentConfirmedCount":5,"confirmedCount":7,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":511800},{"cityName":"广元","currentConfirmedCount":3,"confirmedCount":6,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":510800},{"cityName":"乐山","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":511100},{"cityName":"资阳","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":512000},{"cityName":"阿坝州","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":513200},{"cityName":"待明确地区","currentConfirmedCount":-2,"confirmedCount":0,"suspectedCount":0,"curedCount":0,"deadCount":2,"locationId":0}]},{"provinceName":"重庆市","provinceShortName":"重庆","currentConfirmedCount":323,"confirmedCount":553,"suspectedCount":0,"curedCount":225,"deadCount":5,"comment":"","locationId":500000,"cities":[{"cityName":"万州区","currentConfirmedCount":69,"confirmedCount":108,"suspectedCount":0,"curedCount":36,"deadCount":3,"locationId":500101},{"cityName":"江北区","currentConfirmedCount":23,"confirmedCount":28,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":500105},{"cityName":"合川区","currentConfirmedCount":16,"confirmedCount":23,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":500117},{"cityName":"綦江区","currentConfirmedCount":16,"confirmedCount":23,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":500110},{"cityName":"潼南区","currentConfirmedCount":16,"confirmedCount":18,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500152},{"cityName":"垫江县","currentConfirmedCount":14,"confirmedCount":20,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":500231},{"cityName":"奉节县","currentConfirmedCount":14,"confirmedCount":20,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":500236},{"cityName":"长寿区","currentConfirmedCount":12,"confirmedCount":21,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":500115},{"cityName":"南岸区","currentConfirmedCount":12,"confirmedCount":15,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":500108},{"cityName":"两江新区","currentConfirmedCount":10,"confirmedCount":17,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":-1},{"cityName":"云阳县","currentConfirmedCount":9,"confirmedCount":25,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":500235},{"cityName":"九龙坡区","currentConfirmedCount":9,"confirmedCount":20,"suspectedCount":0,"curedCount":10,"deadCount":1,"locationId":500107},{"cityName":"忠县","currentConfirmedCount":9,"confirmedCount":20,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":500233},{"cityName":"渝北区","currentConfirmedCount":9,"confirmedCount":16,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":500112},{"cityName":"大足区","currentConfirmedCount":9,"confirmedCount":14,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":500111},{"cityName":"渝中区","currentConfirmedCount":8,"confirmedCount":20,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":500103},{"cityName":"石柱县","currentConfirmedCount":7,"confirmedCount":14,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":500240},{"cityName":"丰都县","currentConfirmedCount":7,"confirmedCount":10,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":500230},{"cityName":"沙坪坝区","currentConfirmedCount":7,"confirmedCount":8,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":500106},{"cityName":"开州区","currentConfirmedCount":6,"confirmedCount":20,"suspectedCount":0,"curedCount":13,"deadCount":1,"locationId":500154},{"cityName":"铜梁区","currentConfirmedCount":6,"confirmedCount":9,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":500151},{"cityName":"巫山县","currentConfirmedCount":5,"confirmedCount":10,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":500237},{"cityName":"荣昌区","currentConfirmedCount":5,"confirmedCount":9,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":500153},{"cityName":"巫溪县","currentConfirmedCount":4,"confirmedCount":13,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":500238},{"cityName":"巴南区","currentConfirmedCount":4,"confirmedCount":6,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500113},{"cityName":"璧山区","currentConfirmedCount":3,"confirmedCount":9,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":500120},{"cityName":"永川区","currentConfirmedCount":3,"confirmedCount":5,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500118},{"cityName":"高新区","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"大渡口区","currentConfirmedCount":2,"confirmedCount":7,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":500104},{"cityName":"彭水县","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":500243},{"cityName":"江津区","currentConfirmedCount":1,"confirmedCount":4,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":500116},{"cityName":"涪陵区","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500102},{"cityName":"酉阳县","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"万盛经开区","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"梁平区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":500155},{"cityName":"黔江区","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500114},{"cityName":"城口县","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500229},{"cityName":"武隆区","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":500156},{"cityName":"秀山县","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":500241}]},{"provinceName":"北京市","provinceShortName":"北京","currentConfirmedCount":261,"confirmedCount":387,"suspectedCount":0,"curedCount":122,"deadCount":4,"comment":"","locationId":110000,"cities":[{"cityName":"海淀区","currentConfirmedCount":60,"confirmedCount":60,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110108},{"cityName":"朝阳区","currentConfirmedCount":58,"confirmedCount":58,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110105},{"cityName":"西城区","currentConfirmedCount":47,"confirmedCount":47,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110102},{"cityName":"丰台区","currentConfirmedCount":37,"confirmedCount":40,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":110106},{"cityName":"大兴区","currentConfirmedCount":37,"confirmedCount":39,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":110115},{"cityName":"昌平区","currentConfirmedCount":29,"confirmedCount":29,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110114},{"cityName":"外地来京人员","currentConfirmedCount":24,"confirmedCount":26,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":-1},{"cityName":"通州区","currentConfirmedCount":17,"confirmedCount":18,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":110112},{"cityName":"房山区","currentConfirmedCount":13,"confirmedCount":16,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":110111},{"cityName":"石景山区","currentConfirmedCount":13,"confirmedCount":14,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":110107},{"cityName":"东城区","currentConfirmedCount":11,"confirmedCount":12,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":110101},{"cityName":"顺义区","currentConfirmedCount":10,"confirmedCount":10,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110113},{"cityName":"怀柔区","currentConfirmedCount":7,"confirmedCount":7,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110116},{"cityName":"密云区","currentConfirmedCount":7,"confirmedCount":7,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110118},{"cityName":"门头沟区","currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110109},{"cityName":"延庆区","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110119},{"cityName":"待明确地区","currentConfirmedCount":-113,"confirmedCount":0,"suspectedCount":0,"curedCount":109,"deadCount":4,"locationId":0}]},{"provinceName":"福建省","provinceShortName":"福建","currentConfirmedCount":201,"confirmedCount":292,"suspectedCount":0,"curedCount":91,"deadCount":0,"comment":"","locationId":350000,"cities":[{"cityName":"福州","currentConfirmedCount":45,"confirmedCount":71,"suspectedCount":0,"curedCount":26,"deadCount":0,"locationId":350100},{"cityName":"莆田","currentConfirmedCount":38,"confirmedCount":55,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":350300},{"cityName":"泉州","currentConfirmedCount":33,"confirmedCount":46,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":350500},{"cityName":"厦门","currentConfirmedCount":26,"confirmedCount":35,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":350200},{"cityName":"宁德","currentConfirmedCount":19,"confirmedCount":25,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":350900},{"cityName":"南平","currentConfirmedCount":13,"confirmedCount":20,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":350700},{"cityName":"漳州","currentConfirmedCount":12,"confirmedCount":20,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":350600},{"cityName":"三明","currentConfirmedCount":11,"confirmedCount":14,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":350400},{"cityName":"龙岩","currentConfirmedCount":5,"confirmedCount":6,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":350800},{"cityName":"待明确地区","currentConfirmedCount":-1,"confirmedCount":0,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0}]},{"provinceName":"广西壮族自治区","provinceShortName":"广西","currentConfirmedCount":182,"confirmedCount":242,"suspectedCount":0,"curedCount":58,"deadCount":2,"comment":"","locationId":450000,"cities":[{"cityName":"南宁","currentConfirmedCount":38,"confirmedCount":54,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":450100},{"cityName":"北海","currentConfirmedCount":33,"confirmedCount":44,"suspectedCount":0,"curedCount":10,"deadCount":1,"locationId":450500},{"cityName":"河池","currentConfirmedCount":21,"confirmedCount":22,"suspectedCount":0,"curedCount":0,"deadCount":1,"locationId":451200},{"cityName":"桂林","currentConfirmedCount":19,"confirmedCount":31,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":450300},{"cityName":"防城港","currentConfirmedCount":17,"confirmedCount":18,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":450600},{"cityName":"柳州","currentConfirmedCount":16,"confirmedCount":24,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":450200},{"cityName":"来宾","currentConfirmedCount":11,"confirmedCount":11,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":451300},{"cityName":"玉林","currentConfirmedCount":8,"confirmedCount":10,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":450900},{"cityName":"钦州","currentConfirmedCount":7,"confirmedCount":8,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":450700},{"cityName":"贵港","currentConfirmedCount":5,"confirmedCount":8,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":450800},{"cityName":"贺州","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":451100},{"cityName":"百色","currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":451000},{"cityName":"梧州","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":450400}]},{"provinceName":"河北省","provinceShortName":"河北","currentConfirmedCount":175,"confirmedCount":302,"suspectedCount":0,"curedCount":123,"deadCount":4,"comment":"","locationId":130000,"cities":[{"cityName":"唐山","currentConfirmedCount":40,"confirmedCount":51,"suspectedCount":0,"curedCount":10,"deadCount":1,"locationId":130200},{"cityName":"沧州","currentConfirmedCount":28,"confirmedCount":48,"suspectedCount":0,"curedCount":18,"deadCount":2,"locationId":130900},{"cityName":"张家口","currentConfirmedCount":25,"confirmedCount":34,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":130700},{"cityName":"邯郸","currentConfirmedCount":21,"confirmedCount":31,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":130400},{"cityName":"石家庄","currentConfirmedCount":17,"confirmedCount":28,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":130100},{"cityName":"廊坊","currentConfirmedCount":14,"confirmedCount":30,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":131000},{"cityName":"邢台","currentConfirmedCount":12,"confirmedCount":23,"suspectedCount":0,"curedCount":10,"deadCount":1,"locationId":130500},{"cityName":"秦皇岛","currentConfirmedCount":7,"confirmedCount":10,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":130300},{"cityName":"保定","currentConfirmedCount":6,"confirmedCount":32,"suspectedCount":0,"curedCount":26,"deadCount":0,"locationId":130600},{"cityName":"承德","currentConfirmedCount":3,"confirmedCount":7,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":130800},{"cityName":"衡水","currentConfirmedCount":2,"confirmedCount":8,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":131100}]},{"provinceName":"上海市","provinceShortName":"上海","currentConfirmedCount":171,"confirmedCount":333,"suspectedCount":0,"curedCount":161,"deadCount":1,"comment":"待明确地区治愈21，治愈数据统一归属上海公卫临床中心，暂无具体分区","locationId":310000,"cities":[{"cityName":"外地来沪人员","currentConfirmedCount":50,"confirmedCount":110,"suspectedCount":0,"curedCount":59,"deadCount":1,"locationId":-1},{"cityName":"浦东新区","currentConfirmedCount":27,"confirmedCount":60,"suspectedCount":0,"curedCount":33,"deadCount":0,"locationId":310115},{"cityName":"宝山区","currentConfirmedCount":14,"confirmedCount":21,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":310113},{"cityName":"徐汇区","currentConfirmedCount":12,"confirmedCount":18,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":310104},{"cityName":"松江区","currentConfirmedCount":9,"confirmedCount":14,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":310117},{"cityName":"奉贤区","currentConfirmedCount":8,"confirmedCount":9,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":310120},{"cityName":"闵行区","currentConfirmedCount":7,"confirmedCount":18,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":310112},{"cityName":"静安区","currentConfirmedCount":7,"confirmedCount":16,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":310106},{"cityName":"普陀区","currentConfirmedCount":7,"confirmedCount":11,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":310107},{"cityName":"嘉定区","currentConfirmedCount":7,"confirmedCount":9,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":310114},{"cityName":"杨浦区","currentConfirmedCount":6,"confirmedCount":9,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":310110},{"cityName":"长宁区","currentConfirmedCount":5,"confirmedCount":13,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":310105},{"cityName":"黄浦区","currentConfirmedCount":4,"confirmedCount":6,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":310101},{"cityName":"崇明区","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":310151},{"cityName":"虹口区","currentConfirmedCount":3,"confirmedCount":7,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":310109},{"cityName":"金山区","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":310116},{"cityName":"青浦区","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":310118}]},{"provinceName":"陕西省","provinceShortName":"陕西","currentConfirmedCount":161,"confirmedCount":240,"suspectedCount":0,"curedCount":79,"deadCount":0,"comment":"","locationId":610000,"cities":[{"cityName":"西安","currentConfirmedCount":80,"confirmedCount":117,"suspectedCount":0,"curedCount":37,"deadCount":0,"locationId":610100},{"cityName":"汉中","currentConfirmedCount":23,"confirmedCount":25,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":610700},{"cityName":"安康","currentConfirmedCount":18,"confirmedCount":25,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":610900},{"cityName":"渭南","currentConfirmedCount":12,"confirmedCount":15,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":610500},{"cityName":"咸阳","currentConfirmedCount":11,"confirmedCount":17,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":610400},{"cityName":"商洛","currentConfirmedCount":5,"confirmedCount":7,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":611000},{"cityName":"宝鸡","currentConfirmedCount":4,"confirmedCount":13,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":610300},{"cityName":"铜川","currentConfirmedCount":4,"confirmedCount":8,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":610200},{"cityName":"延安","currentConfirmedCount":2,"confirmedCount":8,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":610600},{"cityName":"榆林","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":610800},{"cityName":"杨凌","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"韩城","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":610581},{"cityName":"待明确地区","currentConfirmedCount":-1,"confirmedCount":0,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0}]},{"provinceName":"云南省","provinceShortName":"云南","currentConfirmedCount":125,"confirmedCount":172,"suspectedCount":0,"curedCount":47,"deadCount":0,"comment":"","locationId":530000,"cities":[{"cityName":"昆明","currentConfirmedCount":41,"confirmedCount":52,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":530100},{"cityName":"昭通","currentConfirmedCount":23,"confirmedCount":25,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":530600},{"cityName":"西双版纳","currentConfirmedCount":11,"confirmedCount":15,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":532800},{"cityName":"玉溪","currentConfirmedCount":11,"confirmedCount":14,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":530400},{"cityName":"曲靖","currentConfirmedCount":7,"confirmedCount":13,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":530300},{"cityName":"大理州","currentConfirmedCount":7,"confirmedCount":13,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":0},{"cityName":"保山","currentConfirmedCount":7,"confirmedCount":9,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":530500},{"cityName":"红河州","currentConfirmedCount":5,"confirmedCount":8,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":0},{"cityName":"德宏州","currentConfirmedCount":3,"confirmedCount":5,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":0},{"cityName":"普洱","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":530800},{"cityName":"楚雄州","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"丽江","currentConfirmedCount":2,"confirmedCount":7,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":530700},{"cityName":"文山州","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"临沧","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":530900}]},{"provinceName":"海南省","provinceShortName":"海南","currentConfirmedCount":100,"confirmedCount":163,"suspectedCount":0,"curedCount":59,"deadCount":4,"comment":"","locationId":460000,"cities":[{"cityName":"三亚","currentConfirmedCount":38,"confirmedCount":54,"suspectedCount":0,"curedCount":15,"deadCount":1,"locationId":460200},{"cityName":"海口","currentConfirmedCount":18,"confirmedCount":34,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":460100},{"cityName":"万宁","currentConfirmedCount":9,"confirmedCount":13,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":469006},{"cityName":"儋州","currentConfirmedCount":7,"confirmedCount":15,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":460400},{"cityName":"澄迈","currentConfirmedCount":7,"confirmedCount":9,"suspectedCount":0,"curedCount":1,"deadCount":1,"locationId":469023},{"cityName":"昌江","currentConfirmedCount":6,"confirmedCount":7,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":469026},{"cityName":"陵水","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":469028},{"cityName":"琼海","currentConfirmedCount":2,"confirmedCount":6,"suspectedCount":0,"curedCount":3,"deadCount":1,"locationId":469002},{"cityName":"临高","currentConfirmedCount":2,"confirmedCount":6,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":469024},{"cityName":"文昌","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":469005},{"cityName":"保亭","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":469029},{"cityName":"乐东","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":469027},{"cityName":"东方","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":469007},{"cityName":"定安","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":1,"locationId":469021},{"cityName":"琼中","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":469030}]},{"provinceName":"贵州省","provinceShortName":"贵州","currentConfirmedCount":79,"confirmedCount":146,"suspectedCount":0,"curedCount":66,"deadCount":1,"comment":"","locationId":520000,"cities":[{"cityName":"贵阳","currentConfirmedCount":23,"confirmedCount":36,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":520100},{"cityName":"遵义","currentConfirmedCount":20,"confirmedCount":32,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":520300},{"cityName":"毕节","currentConfirmedCount":13,"confirmedCount":23,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":520500},{"cityName":"黔南州","currentConfirmedCount":10,"confirmedCount":17,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":522700},{"cityName":"黔东南州","currentConfirmedCount":6,"confirmedCount":10,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":522600},{"cityName":"六盘水","currentConfirmedCount":3,"confirmedCount":10,"suspectedCount":0,"curedCount":6,"deadCount":1,"locationId":520200},{"cityName":"安顺","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":520400},{"cityName":"铜仁","currentConfirmedCount":1,"confirmedCount":10,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":520600},{"cityName":"黔西南州","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":522300}]},{"provinceName":"辽宁省","provinceShortName":"辽宁","currentConfirmedCount":77,"confirmedCount":121,"suspectedCount":0,"curedCount":43,"deadCount":1,"comment":"","locationId":210000,"cities":[{"cityName":"大连","currentConfirmedCount":14,"confirmedCount":19,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":210200},{"cityName":"葫芦岛","currentConfirmedCount":11,"confirmedCount":12,"suspectedCount":0,"curedCount":0,"deadCount":1,"locationId":211400},{"cityName":"盘锦","currentConfirmedCount":11,"confirmedCount":11,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":211100},{"cityName":"沈阳","currentConfirmedCount":9,"confirmedCount":28,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":210100},{"cityName":"阜新","currentConfirmedCount":8,"confirmedCount":8,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":210900},{"cityName":"铁岭","currentConfirmedCount":6,"confirmedCount":7,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":211200},{"cityName":"锦州","currentConfirmedCount":5,"confirmedCount":12,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":210700},{"cityName":"鞍山","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":210300},{"cityName":"丹东","currentConfirmedCount":3,"confirmedCount":7,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":210600},{"cityName":"朝阳","currentConfirmedCount":3,"confirmedCount":6,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":211300},{"cityName":"本溪","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":210500},{"cityName":"辽阳","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":211000},{"cityName":"营口","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":210800}]},{"provinceName":"山西省","provinceShortName":"山西","currentConfirmedCount":77,"confirmedCount":130,"suspectedCount":0,"curedCount":53,"deadCount":0,"comment":"","locationId":140000,"cities":[{"cityName":"晋中","currentConfirmedCount":21,"confirmedCount":36,"suspectedCount":0,"curedCount":15,"deadCount":0,"locationId":140700},{"cityName":"太原","currentConfirmedCount":13,"confirmedCount":19,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":140100},{"cityName":"大同","currentConfirmedCount":7,"confirmedCount":12,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":140200},{"cityName":"晋城","currentConfirmedCount":7,"confirmedCount":9,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":140500},{"cityName":"长治","currentConfirmedCount":7,"confirmedCount":8,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":140400},{"cityName":"运城","currentConfirmedCount":6,"confirmedCount":19,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":140800},{"cityName":"朔州","currentConfirmedCount":6,"confirmedCount":8,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":140600},{"cityName":"忻州","currentConfirmedCount":6,"confirmedCount":7,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":140900},{"cityName":"阳泉","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":140300},{"cityName":"临汾","currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":141000},{"cityName":"吕梁","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":141100}]},{"provinceName":"天津市","provinceShortName":"天津","currentConfirmedCount":76,"confirmedCount":125,"suspectedCount":0,"curedCount":46,"deadCount":3,"comment":"","locationId":120000,"cities":[{"cityName":"宝坻区","currentConfirmedCount":36,"confirmedCount":50,"suspectedCount":0,"curedCount":12,"deadCount":2,"locationId":120115},{"cityName":"河东区","currentConfirmedCount":7,"confirmedCount":15,"suspectedCount":0,"curedCount":7,"deadCount":1,"locationId":120102},{"cityName":"河北区","currentConfirmedCount":5,"confirmedCount":12,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":120105},{"cityName":"北辰区","currentConfirmedCount":5,"confirmedCount":6,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":120113},{"cityName":"南开区","currentConfirmedCount":5,"confirmedCount":6,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":120104},{"cityName":"宁河区","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":120117},{"cityName":"外地来津人员","currentConfirmedCount":3,"confirmedCount":6,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":0},{"cityName":"东丽区","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":120110},{"cityName":"和平区","currentConfirmedCount":2,"confirmedCount":6,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":120101},{"cityName":"河西区","currentConfirmedCount":2,"confirmedCount":4,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":120103},{"cityName":"滨海新区","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":120116},{"cityName":"西青区","currentConfirmedCount":1,"confirmedCount":4,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":120111},{"cityName":"武清区","currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":120114},{"cityName":"红桥区","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":120106},{"cityName":"津南区","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":120112}]},{"provinceName":"内蒙古自治区","provinceShortName":"内蒙古","currentConfirmedCount":65,"confirmedCount":73,"suspectedCount":0,"curedCount":8,"deadCount":0,"comment":"","locationId":150000,"cities":[{"cityName":"包头","currentConfirmedCount":11,"confirmedCount":11,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":150200},{"cityName":"鄂尔多斯","currentConfirmedCount":8,"confirmedCount":11,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":150600},{"cityName":"巴彦淖尔","currentConfirmedCount":8,"confirmedCount":8,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":150800},{"cityName":"赤峰","currentConfirmedCount":7,"confirmedCount":9,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":150400},{"cityName":"锡林郭勒盟","currentConfirmedCount":7,"confirmedCount":8,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":152500},{"cityName":"呼和浩特","currentConfirmedCount":7,"confirmedCount":7,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":150100},{"cityName":"通辽","currentConfirmedCount":7,"confirmedCount":7,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":150500},{"cityName":"呼伦贝尔","currentConfirmedCount":5,"confirmedCount":6,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":150700},{"cityName":"乌兰察布","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":150900},{"cityName":"乌海市","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":150300},{"cityName":"兴安盟","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":152200}]},{"provinceName":"新疆维吾尔自治区","provinceShortName":"新疆","currentConfirmedCount":63,"confirmedCount":76,"suspectedCount":0,"curedCount":12,"deadCount":1,"comment":"","locationId":650000,"cities":[{"cityName":"乌鲁木齐","currentConfirmedCount":19,"confirmedCount":23,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":650100},{"cityName":"伊犁州","currentConfirmedCount":14,"confirmedCount":18,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":654000},{"cityName":"兵团第四师","currentConfirmedCount":10,"confirmedCount":10,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"兵团第九师","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"昌吉州","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"巴州","currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":511902},{"cityName":"兵团第十二师","currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"吐鲁番市","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":650400},{"cityName":"兵团第八师石河子市","currentConfirmedCount":2,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":1,"locationId":0},{"cityName":"兵团第六师五家渠市","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"兵团第七师","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"阿克苏地区","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":652900}]},{"provinceName":"香港","provinceShortName":"香港","currentConfirmedCount":57,"confirmedCount":60,"suspectedCount":0,"curedCount":2,"deadCount":1,"comment":"","locationId":810000,"cities":[]},{"provinceName":"吉林省","provinceShortName":"吉林","currentConfirmedCount":54,"confirmedCount":89,"suspectedCount":0,"curedCount":34,"deadCount":1,"comment":"","locationId":220000,"cities":[{"cityName":"长春","currentConfirmedCount":26,"confirmedCount":45,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":220100},{"cityName":"四平市","currentConfirmedCount":9,"confirmedCount":14,"suspectedCount":0,"curedCount":4,"deadCount":1,"locationId":220300},{"cityName":"辽源","currentConfirmedCount":6,"confirmedCount":7,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":220400},{"cityName":"公主岭","currentConfirmedCount":4,"confirmedCount":6,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":220381},{"cityName":"延边","currentConfirmedCount":3,"confirmedCount":5,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":222400},{"cityName":"吉林市","currentConfirmedCount":2,"confirmedCount":5,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":220200},{"cityName":"通化","currentConfirmedCount":2,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":220500},{"cityName":"松原","currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":220700},{"cityName":"白城","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":220800},{"cityName":"梅河口","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":220581}]},{"provinceName":"宁夏回族自治区","provinceShortName":"宁夏","currentConfirmedCount":35,"confirmedCount":70,"suspectedCount":0,"curedCount":35,"deadCount":0,"comment":"","locationId":640000,"cities":[{"cityName":"吴忠","currentConfirmedCount":21,"confirmedCount":27,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":640300},{"cityName":"银川","currentConfirmedCount":11,"confirmedCount":33,"suspectedCount":0,"curedCount":22,"deadCount":0,"locationId":640100},{"cityName":"固原","currentConfirmedCount":3,"confirmedCount":5,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":640400},{"cityName":"中卫","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":640500},{"cityName":"宁东","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"石嘴山","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":640200}]},{"provinceName":"甘肃省","provinceShortName":"甘肃","currentConfirmedCount":31,"confirmedCount":91,"suspectedCount":0,"curedCount":58,"deadCount":2,"comment":"","locationId":620000,"cities":[{"cityName":"兰州","currentConfirmedCount":14,"confirmedCount":36,"suspectedCount":0,"curedCount":20,"deadCount":2,"locationId":620100},{"cityName":"平凉","currentConfirmedCount":8,"confirmedCount":9,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":620800},{"cityName":"甘南","currentConfirmedCount":4,"confirmedCount":8,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":623000},{"cityName":"白银","currentConfirmedCount":3,"confirmedCount":4,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":620400},{"cityName":"天水","currentConfirmedCount":1,"confirmedCount":12,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":620500},{"cityName":"定西","currentConfirmedCount":1,"confirmedCount":9,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":621100},{"cityName":"陇南","currentConfirmedCount":1,"confirmedCount":4,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":621200},{"cityName":"庆阳","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":621000},{"cityName":"临夏","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":622900},{"cityName":"张掖","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":620700},{"cityName":"金昌","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":620300},{"cityName":"待明确地区","currentConfirmedCount":-2,"confirmedCount":0,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":0}]},{"provinceName":"台湾","provinceShortName":"台湾","currentConfirmedCount":19,"confirmedCount":22,"suspectedCount":0,"curedCount":2,"deadCount":1,"comment":"","locationId":710000,"cities":[]},{"provinceName":"澳门","provinceShortName":"澳门","currentConfirmedCount":5,"confirmedCount":10,"suspectedCount":0,"curedCount":5,"deadCount":0,"comment":"","locationId":820000,"cities":[]},{"provinceName":"青海省","provinceShortName":"青海","currentConfirmedCount":5,"confirmedCount":18,"suspectedCount":0,"curedCount":13,"deadCount":0,"comment":"","locationId":630000,"cities":[{"cityName":"西宁","currentConfirmedCount":4,"confirmedCount":15,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":630100},{"cityName":"海北州","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":632200}]},{"provinceName":"西藏自治区","provinceShortName":"西藏","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","locationId":540000,"cities":[{"cityName":"拉萨","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":540100}]}]
/// continents : [{"continentName":"其他","currentConfirmedCount":454,"deadCount":0,"confirmedCount":454,"suspectedCount":0,"curedCount":0,"country":[{"id":248126,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":454,"confirmedCount":454,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryName":"钻石公主号邮轮","countryId":"10"}]},{"continentName":"亚洲","currentConfirmedCount":174,"deadCount":2,"confirmedCount":260,"suspectedCount":0,"curedCount":84,"country":[{"id":248047,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":53,"confirmedCount":77,"suspectedCount":0,"curedCount":24,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952009,"countryName":"新加坡","countryId":"3"},{"id":248050,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":49,"confirmedCount":62,"suspectedCount":0,"curedCount":12,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":951002,"countryName":"日本","countryId":"6"},{"id":248046,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":20,"confirmedCount":35,"suspectedCount":0,"curedCount":15,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952010,"countryName":"泰国","countryId":"2"},{"id":248051,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":20,"confirmedCount":30,"suspectedCount":0,"curedCount":10,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":951004,"countryName":"韩国","countryId":"7"},{"id":248048,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":15,"confirmedCount":22,"suspectedCount":0,"curedCount":7,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952007,"countryName":"马来西亚","countryId":"4"},{"id":248053,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":9,"confirmedCount":16,"suspectedCount":0,"curedCount":7,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952011,"countryName":"越南","countryId":"9"},{"id":248061,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":5,"confirmedCount":9,"suspectedCount":0,"curedCount":4,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955019,"countryName":"阿联酋","countryId":"10"},{"id":248054,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953005,"countryName":"尼泊尔","countryId":"10"},{"id":248059,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953007,"countryName":"斯里兰卡","countryId":"10"},{"id":248069,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952008,"countryName":"菲律宾","countryId":"10"},{"id":248057,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952003,"countryName":"柬埔寨","countryId":"10"},{"id":248063,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953003,"countryName":"印度","countryId":"10"}]},{"continentName":"欧洲","currentConfirmedCount":29,"deadCount":1,"confirmedCount":47,"suspectedCount":0,"curedCount":17,"country":[{"id":248058,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":15,"confirmedCount":16,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963003,"countryName":"德国","countryId":"10"},{"id":248049,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":7,"confirmedCount":12,"suspectedCount":0,"curedCount":4,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961002,"countryName":"法国","countryId":"5"},{"id":248064,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965008,"countryName":"意大利","countryId":"10"},{"id":248067,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965015,"countryName":"西班牙","countryId":"10"},{"id":248065,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":9,"suspectedCount":0,"curedCount":8,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961007,"countryName":"英国","countryId":"10"},{"id":248068,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":962005,"countryName":"瑞典","countryId":"10"},{"id":248062,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":962002,"countryName":"芬兰","countryId":"10"},{"id":248066,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964006,"countryName":"俄罗斯","countryId":"10"},{"id":248080,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961001,"countryName":"比利时","countryId":"10"}]},{"continentName":"北美洲","currentConfirmedCount":18,"deadCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":5,"country":[{"id":248052,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":12,"confirmedCount":15,"suspectedCount":0,"curedCount":3,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":971002,"countryName":"美国","countryId":"8"},{"id":248056,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":6,"confirmedCount":8,"suspectedCount":0,"curedCount":2,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":971001,"countryName":"加拿大","countryId":"10"}]},{"continentName":"大洋洲","currentConfirmedCount":5,"deadCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":10,"country":[{"id":248055,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":5,"confirmedCount":15,"suspectedCount":0,"curedCount":10,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":990001,"countryName":"澳大利亚","countryId":"10"}]},{"continentName":"非洲","currentConfirmedCount":1,"deadCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"country":[{"id":248108,"createTime":1581992704000,"modifyTime":1581992704000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":981002,"countryName":"埃及","countryId":"10"}]}]

class SARSCov {
  int id;
  int createTime;
  int modifyTime;
  String imgUrl;
  String summary;
  bool deleted;
  String countRemark;
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  int seriousCount;
  int suspectedIncr;
  int currentConfirmedIncr;
  int confirmedIncr;
  int curedIncr;
  int deadIncr;
  int seriousIncr;
  List<String> remark1;
  List<String> remark2;
  List<String> remark3;
  String remark4;
  String remark5;
  List<String> note1;
  List<String> note2;
  List<String> note3;
  String generalRemark;
  String abroadRemark;
  List<MarqueeBean> marquee;
  List<QuanGuoTrendChartBean> quanGuoTrendChart;
  List<HbFeiHbTrendChartBean> hbFeiHbTrendChart;

  List<Province> provinces;
  List<Continent> continents;

  List<RumourBean> rumour;
  List<WikiListBean> wikiList;
  List<RecommendBean> recommend;

  static SARSCov fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SARSCov bean = SARSCov();
    bean.id = map['id'];
    bean.createTime = map['createTime'];
    bean.modifyTime = map['modifyTime'];
    bean.imgUrl = map['imgUrl'];
    bean.summary = map['summary'];
    bean.deleted = map['deleted'];
    bean.countRemark = map['countRemark'];
    bean.currentConfirmedCount = map['currentConfirmedCount'];
    bean.confirmedCount = map['confirmedCount'];
    bean.suspectedCount = map['suspectedCount'];
    bean.curedCount = map['curedCount'];
    bean.deadCount = map['deadCount'];
    bean.seriousCount = map['seriousCount'];
    bean.suspectedIncr = map['suspectedIncr'];
    bean.currentConfirmedIncr = map['currentConfirmedIncr'];
    bean.confirmedIncr = map['confirmedIncr'];
    bean.curedIncr = map['curedIncr'];
    bean.deadIncr = map['deadIncr'];
    bean.seriousIncr = map['seriousIncr'];
    bean.remark1 = map['remark1'].split('：');
    bean.remark2 = map['remark2'].split('：');
    bean.remark3 = map['remark3'].split('：');
    bean.remark4 = map['remark4'];
    bean.remark5 = map['remark5'];
    bean.note1 = map['note1'].split('：');
    bean.note2 = map['note2'].split('：');
    bean.note3 = map['note3'].split('：');
    bean.generalRemark = map['generalRemark'];
    bean.abroadRemark = map['abroadRemark'];
    bean.marquee = List()
      ..addAll(
          (map['marquee'] as List ?? []).map((o) => MarqueeBean.fromMap(o)));
    bean.quanGuoTrendChart = List()
      ..addAll((map['quanguoTrendChart'] as List ?? [])
          .map((o) => QuanGuoTrendChartBean.fromMap(o)));
    bean.hbFeiHbTrendChart = List()
      ..addAll((map['hbFeiHbTrendChart'] as List ?? [])
          .map((o) => HbFeiHbTrendChartBean.fromMap(o)));
    bean.provinces = List()
      ..addAll(
          (map['provinces'] as List ?? []).map((o) => Province.fromMap(o)));
    bean.continents = List()
      ..addAll(
          (map['continents'] as List ?? []).map((o) => Continent.fromMap(o)));

    bean.rumour = List()
      ..addAll((map['rumour'] as List ?? []).map((o) => RumourBean.fromMap(o)));
    bean.wikiList = List()
      ..addAll(
          (map['wiki_list'] as List ?? []).map((o) => WikiListBean.fromMap(o)));
    bean.recommend = List()
      ..addAll((map['recommend'] as List ?? [])
          .map((o) => RecommendBean.fromMap(o)));
    return bean;
  }

  Map toJson() => {
        "id": id,
        "createTime": createTime,
        "modifyTime": modifyTime,
        "imgUrl": imgUrl,
        "summary": summary,
        "deleted": deleted,
        "countRemark": countRemark,
        "currentConfirmedCount": currentConfirmedCount,
        "confirmedCount": confirmedCount,
        "suspectedCount": suspectedCount,
        "curedCount": curedCount,
        "deadCount": deadCount,
        "seriousCount": seriousCount,
        "suspectedIncr": suspectedIncr,
        "currentConfirmedIncr": currentConfirmedIncr,
        "confirmedIncr": confirmedIncr,
        "curedIncr": curedIncr,
        "deadIncr": deadIncr,
        "seriousIncr": seriousIncr,
        "remark1": remark1,
        "remark2": remark2,
        "remark3": remark3,
        "remark4": remark4,
        "remark5": remark5,
        "note1": note1,
        "note2": note2,
        "note3": note3,
        "generalRemark": generalRemark,
        "abroadRemark": abroadRemark,
        "marquee": marquee,
        "quanguoTrendChart": quanGuoTrendChart,
        "hbFeiHbTrendChart": hbFeiHbTrendChart,
        "provinces": provinces,
        "continents": continents,
        "rumour": rumour,
        "wiki_list": wikiList,
        "recommend": recommend,
      };
}

/// imgUrl : "https://img1.dxycdn.com/2020/0214/103/3396575592886584759-135.png"
/// title : "新增确诊"

class HbFeiHbTrendChartBean {
  String imgUrl;
  String title;

  static HbFeiHbTrendChartBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HbFeiHbTrendChartBean hbFeiHbTrendChartBean = HbFeiHbTrendChartBean();
    hbFeiHbTrendChartBean.imgUrl = map['imgUrl'];
    hbFeiHbTrendChartBean.title = map['title'];
    return hbFeiHbTrendChartBean;
  }

  Map toJson() => {
        "imgUrl": imgUrl,
        "title": title,
      };
}

/// imgUrl : "https://img1.dxycdn.com/2020/0214/159/3396575532757028839-135.png"
/// title : "新增疑似/新增确诊"

class QuanGuoTrendChartBean {
  String imgUrl;
  String title;

  static QuanGuoTrendChartBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    QuanGuoTrendChartBean quanguoTrendChartBean = QuanGuoTrendChartBean();
    quanguoTrendChartBean.imgUrl = map['imgUrl'];
    quanguoTrendChartBean.title = map['title'];
    return quanguoTrendChartBean;
  }

  Map toJson() => {
        "imgUrl": imgUrl,
        "title": title,
      };
}

/// id : 398
/// marqueeLabel : "卫健委"
/// marqueeContent : "首次官方公布近两千医务人员感染"
/// marqueeLink : "https://dxy.me/XyNMCD"

class MarqueeBean {
  int id;
  String marqueeLabel;
  String marqueeContent;
  String marqueeLink;

  static MarqueeBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MarqueeBean marqueeBean = MarqueeBean();
    marqueeBean.id = map['id'];
    marqueeBean.marqueeLabel = map['marqueeLabel'];
    marqueeBean.marqueeContent = map['marqueeContent'];
    marqueeBean.marqueeLink = map['marqueeLink'];
    return marqueeBean;
  }

  Map toJson() => {
        "id": id,
        "marqueeLabel": marqueeLabel,
        "marqueeContent": marqueeContent,
        "marqueeLink": marqueeLink,
      };
}

/// id : 50
/// date : "2020-01-23"
/// start : "2020-01-23T01:57:00.000Z"
/// end : "2020-01-23T15:59:59.000Z"
/// type : 4
/// no : "南充川R60720"
/// memo : ""
/// no_sub : ""
/// pos_start : "南充"
/// pos_end : "武胜县烈面镇"
/// source : "https://mp.weixin.qq.com/s/jEBlMLCgSTD9AcpcV1yRtg"
/// who : "央视新闻"
/// verified : 1
/// created_at : "2020-01-27T10:02:43.000Z"
/// updated_at : "2020-01-27T10:02:43.000Z"

class SameRide {
  int id;
  String date;
  String start;
  String end;
  String type;
  String no;
  String memo;
  String noSub;
  String posStart;
  String posEnd;
  String source;
  String who;
  int verified;
  String createdAt;
  String updatedAt;
  Color bgColor;

  static SameRide fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SameRide bean = SameRide();
    bean.id = map['id'];
    bean.date = map['date'];
    bean.start = map['start'];
    bean.end = map['end'];
    bean.type = map['type'] == 1
        ? "飞机"
        : map['type'] == 2
            ? "火车"
            : map['type'] == 3
                ? "地铁"
                : map['type'] == 4
                    ? "客运"
                    : map['type'] == 5
                        ? "公交车"
                        : map['type'] == 6 ? "出租车" : "其他";
    bean.no = map['no'];
    bean.memo = map['memo'];
    bean.noSub = map['no_sub'];
    bean.posStart = map['pos_start'];
    bean.posEnd = map['pos_end'];
    bean.source = map['source'];
    bean.who = map['who'];
    bean.verified = map['verified'];
    bean.createdAt = map['created_at'];
    bean.updatedAt = map['updated_at'];
    bean.bgColor = themeColors[Random().nextInt(10)];
    return bean;
  }

  Map toJson() => {
        "id": id,
        "date": date,
        "start": start,
        "end": end,
        "type": type,
        "no": no,
        "memo": memo,
        "no_sub": noSub,
        "pos_start": posStart,
        "pos_end": posEnd,
        "source": source,
        "who": who,
        "verified": verified,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

/// continentName : "亚洲"
/// currentConfirmedCount : 375
/// deadCount : 2
/// confirmedCount : 433
/// suspectedCount : 0
/// curedCount : 56
/// country : [{"id":140151,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":243,"confirmedCount":253,"suspectedCount":0,"curedCount":9,"deadCount":1,"comment":"","sort":0,"operator":"zhangjing1","locationId":951002,"countryName":"日本","countryId":"6"},{"id":140148,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":50,"confirmedCount":67,"suspectedCount":0,"curedCount":17,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":952009,"countryName":"新加坡","countryId":"3"},{"id":140147,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":23,"confirmedCount":33,"suspectedCount":0,"curedCount":10,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":952010,"countryName":"泰国","countryId":"2"},{"id":140152,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":21,"confirmedCount":28,"suspectedCount":0,"curedCount":7,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":951004,"countryName":"韩国","countryId":"7"},{"id":140149,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":16,"confirmedCount":19,"suspectedCount":0,"curedCount":3,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":952007,"countryName":"马来西亚","countryId":"4"},{"id":140154,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":9,"confirmedCount":16,"suspectedCount":0,"curedCount":7,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":952011,"countryName":"越南","countryId":"9"},{"id":140162,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":7,"confirmedCount":8,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":955019,"countryName":"阿联酋","countryId":"10"},{"id":140164,"createTime":1581730446000,"modifyTime":1581730446000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":953003,"countryName":"印度","countryId":"10"},{"id":140155,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":953005,"countryName":"尼泊尔","countryId":"10"},{"id":140160,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":953007,"countryName":"斯里兰卡","countryId":"10"},{"id":140170,"createTime":1581730446000,"modifyTime":1581730446000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":1,"deadCount":1,"comment":"","sort":0,"operator":"zhangjing1","locationId":952008,"countryName":"菲律宾","countryId":"10"},{"id":140158,"createTime":1581730445000,"modifyTime":1581730445000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"zhangjing1","locationId":952003,"countryName":"柬埔寨","countryId":"10"}]

class Continent {
  String continentName;
  int currentConfirmedCount;
  int deadCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  List<CountryBean> country;

  static Continent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Continent continent = Continent();
    continent.continentName = map['continentName'];
    continent.currentConfirmedCount = map['currentConfirmedCount'];
    continent.deadCount = map['deadCount'];
    continent.confirmedCount = map['confirmedCount'];
    continent.suspectedCount = map['suspectedCount'];
    continent.curedCount = map['curedCount'];
    continent.country = List()
      ..addAll(
          (map['country'] as List ?? []).map((o) => CountryBean.fromMap(o)));
    return continent;
  }

  Map toJson() => {
        "continentName": continentName,
        "currentConfirmedCount": currentConfirmedCount,
        "deadCount": deadCount,
        "confirmedCount": confirmedCount,
        "suspectedCount": suspectedCount,
        "curedCount": curedCount,
        "country": country,
      };
}

/// id : 140151
/// createTime : 1581730445000
/// modifyTime : 1581730445000
/// tags : ""
/// countryType : 2
/// currentConfirmedCount : 243
/// confirmedCount : 253
/// suspectedCount : 0
/// curedCount : 9
/// deadCount : 1
/// comment : ""
/// sort : 0
/// operator : "zhangjing1"
/// locationId : 951002
/// countryName : "日本"
/// countryId : "6"

class CountryBean {
  int id;
  int createTime;
  int modifyTime;
  String tags;
  int countryType;
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  String comment;
  int sort;
  String operator;
  int locationId;
  String countryName;
  String countryId;

  static CountryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountryBean countryBean = CountryBean();
    countryBean.id = map['id'];
    countryBean.createTime = map['createTime'];
    countryBean.modifyTime = map['modifyTime'];
    countryBean.tags = map['tags'];
    countryBean.countryType = map['countryType'];
    countryBean.currentConfirmedCount = map['currentConfirmedCount'];
    countryBean.confirmedCount = map['confirmedCount'];
    countryBean.suspectedCount = map['suspectedCount'];
    countryBean.curedCount = map['curedCount'];
    countryBean.deadCount = map['deadCount'];
    countryBean.comment = map['comment'];
    countryBean.sort = map['sort'];
    countryBean.operator = map['operator'];
    countryBean.locationId = map['locationId'];
    countryBean.countryName = map['countryName'];
    countryBean.countryId = map['countryId'];
    return countryBean;
  }

  Map toJson() => {
        "id": id,
        "createTime": createTime,
        "modifyTime": modifyTime,
        "tags": tags,
        "countryType": countryType,
        "currentConfirmedCount": currentConfirmedCount,
        "confirmedCount": confirmedCount,
        "suspectedCount": suspectedCount,
        "curedCount": curedCount,
        "deadCount": deadCount,
        "comment": comment,
        "sort": sort,
        "operator": operator,
        "locationId": locationId,
        "countryName": countryName,
        "countryId": countryId,
      };
}

/// provinceName : "湖北省"
/// provinceShortName : "湖北"
/// currentConfirmedCount : 48175
/// confirmedCount : 54406
/// suspectedCount : 0
/// curedCount : 4774
/// deadCount : 1457
/// comment : ""
/// locationId : 420000
/// cities : [{"cityName":"武汉","currentConfirmedCount":34289,"confirmedCount":37914,"suspectedCount":0,"curedCount":2502,"deadCount":1123,"locationId":420100},{"cityName":"孝感","currentConfirmedCount":2739,"confirmedCount":3114,"suspectedCount":0,"curedCount":313,"deadCount":62,"locationId":420900},{"cityName":"黄冈","currentConfirmedCount":2138,"confirmedCount":2817,"suspectedCount":0,"curedCount":611,"deadCount":68,"locationId":421100},{"cityName":"荆州","currentConfirmedCount":1254,"confirmedCount":1478,"suspectedCount":0,"curedCount":192,"deadCount":32,"locationId":421000},{"cityName":"随州","currentConfirmedCount":1117,"confirmedCount":1232,"suspectedCount":0,"curedCount":96,"deadCount":19,"locationId":421300},{"cityName":"襄阳","currentConfirmedCount":1025,"confirmedCount":1128,"suspectedCount":0,"curedCount":85,"deadCount":18,"locationId":420600},{"cityName":"鄂州","currentConfirmedCount":960,"confirmedCount":1192,"suspectedCount":0,"curedCount":199,"deadCount":33,"locationId":420700},{"cityName":"宜昌","currentConfirmedCount":799,"confirmedCount":906,"suspectedCount":0,"curedCount":92,"deadCount":15,"locationId":420500},{"cityName":"黄石","currentConfirmedCount":797,"confirmedCount":980,"suspectedCount":0,"curedCount":170,"deadCount":13,"locationId":420200},{"cityName":"荆门","currentConfirmedCount":762,"confirmedCount":902,"suspectedCount":0,"curedCount":112,"deadCount":28,"locationId":420800},{"cityName":"咸宁","currentConfirmedCount":705,"confirmedCount":840,"suspectedCount":0,"curedCount":127,"deadCount":8,"locationId":421200},{"cityName":"十堰","currentConfirmedCount":495,"confirmedCount":597,"suspectedCount":0,"curedCount":100,"deadCount":2,"locationId":420300},{"cityName":"仙桃","currentConfirmedCount":434,"confirmedCount":514,"suspectedCount":0,"curedCount":63,"deadCount":17,"locationId":429004},{"cityName":"天门","currentConfirmedCount":391,"confirmedCount":422,"suspectedCount":0,"curedCount":21,"deadCount":10,"locationId":429006},{"cityName":"恩施州","currentConfirmedCount":169,"confirmedCount":244,"suspectedCount":0,"curedCount":71,"deadCount":4,"locationId":422800},{"cityName":"潜江","currentConfirmedCount":99,"confirmedCount":116,"suspectedCount":0,"curedCount":12,"deadCount":5,"locationId":429005},{"cityName":"神农架林区","currentConfirmedCount":2,"confirmedCount":10,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":429021}]

class Province {
  String provinceName;
  String provinceShortName;
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  String comment;
  int locationId;
  List<CitiesBean> cities;

  static Province fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Province bean = Province();
    bean.provinceName = map['provinceName'];
    bean.provinceShortName = map['provinceShortName'];
    bean.currentConfirmedCount = map['currentConfirmedCount'];
    bean.confirmedCount = map['confirmedCount'];
    bean.suspectedCount = map['suspectedCount'];
    bean.curedCount = map['curedCount'];
    bean.deadCount = map['deadCount'];
    bean.comment = map['comment'];
    bean.locationId = map['locationId'];
    bean.cities = List()
      ..addAll((map['cities'] as List ?? []).map((o) => CitiesBean.fromMap(o)));
    return bean;
  }

  Map toJson() => {
        "provinceName": provinceName,
        "provinceShortName": provinceShortName,
        "currentConfirmedCount": currentConfirmedCount,
        "confirmedCount": confirmedCount,
        "suspectedCount": suspectedCount,
        "curedCount": curedCount,
        "deadCount": deadCount,
        "comment": comment,
        "locationId": locationId,
        "cities": cities,
      };
}

/// cityName : "武汉"
/// currentConfirmedCount : 34289
/// confirmedCount : 37914
/// suspectedCount : 0
/// curedCount : 2502
/// deadCount : 1123
/// locationId : 420100

class CitiesBean {
  String cityName;
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  int locationId;

  static CitiesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CitiesBean citiesBean = CitiesBean();
    citiesBean.cityName = map['cityName'];
    citiesBean.currentConfirmedCount = map['currentConfirmedCount'];
    citiesBean.confirmedCount = map['confirmedCount'];
    citiesBean.suspectedCount = map['suspectedCount'];
    citiesBean.curedCount = map['curedCount'];
    citiesBean.deadCount = map['deadCount'];
    citiesBean.locationId = map['locationId'];
    return citiesBean;
  }

  Map toJson() => {
        "cityName": cityName,
        "currentConfirmedCount": currentConfirmedCount,
        "confirmedCount": confirmedCount,
        "suspectedCount": suspectedCount,
        "curedCount": curedCount,
        "deadCount": deadCount,
        "locationId": locationId,
      };
}

/// title : "燕窝可以提升免疫系统，预防新型冠状病毒"
/// author : "美国普渡大学农业与生物系食品工程专业博士"
/// authordesc : "美国普渡大学农业与生物系食品工程专业博士"
/// id : "e8c8ebcd0f8d55abea6249b79a340796"
/// date : "2020-02-16"
/// markstyle : "fake"
/// result : "假"
/// explain : "伪科学"
/// abstract : "“燕窝它是水解的”是一个莫名其妙的说法..."
/// tag : ["新型冠状病毒","燕窝"]
/// type : 1
/// videourl : ""
/// cover : "https://p.qpic.cn/jiaozhen/0/eac581e61731a9b49c5cfbcd5a6e9984/0?imageView2/2/w/150/h/90"
/// coverrect : "https://p.qpic.cn/jiaozhen/0/eac581e61731a9b49c5cfbcd5a6e9984/0"
/// coversqual : "https://p.qpic.cn/jiaozhen/0/eac581e61731a9b49c5cfbcd5a6e9984/0?imageView2/2/w/300/h/300"
/// section : ""
/// iscolled : false
/// arttype : "normal"

class Rumour {
  String title;
  String author;
  String authorDesc;
  String id;
  String date;
  String markStyle;
  String result;
  String explain;
  String abstract;
  List<String> tag;
  int type;
  String videoUrl;
  String cover;
  String coverRect;
  String coverSqual;
  String section;
  bool isColled;
  String artType;

  static Rumour fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Rumour bean = Rumour();
    bean.title = map['title'];
    bean.author = map['author'];
    bean.authorDesc = map['authordesc'];
    bean.id = map['id'];
    bean.date = map['date'];
    bean.markStyle = map['markstyle'];
    bean.result = map['result'];
    bean.explain = map['explain'];
    bean.abstract = map['abstract'];
    bean.tag = List()
      ..addAll((map['tag'] as List ?? []).map((o) => o.toString()));
    bean.type = map['type'];
    bean.videoUrl = map['videourl'];
    bean.cover = map['cover'];
    bean.coverRect = map['coverrect'];
    bean.coverSqual = map['coversqual'];
    bean.section = map['section'];
    bean.isColled = map['iscolled'];
    bean.artType = map['arttype'];
    return bean;
  }

  Map toJson() => {
        "title": title,
        "author": author,
        "authordesc": authorDesc,
        "id": id,
        "date": date,
        "markstyle": markStyle,
        "result": result,
        "explain": explain,
        "abstract": abstract,
        "tag": tag,
        "type": type,
        "videourl": videoUrl,
        "cover": cover,
        "coverrect": coverRect,
        "coversqual": coverSqual,
        "section": section,
        "iscolled": isColled,
        "arttype": artType,
      };
}

/// adoptType : 1
/// createTime : 1581721940000
/// dataInfoOperator : ""
/// dataInfoState : 0
/// dataInfoTime : 1581721940000
/// entryWay : 1
/// id : 4410
/// infoSource : "央视新闻"
/// infoType : 1
/// modifyTime : 1581721940000
/// provinceId : "42"
/// provinceName : "湖北省"
/// pubDate : 1581721637000
/// pubDateStr : "8分钟前"
/// sourceUrl : "http://m.weibo.cn/2656274875/4472127040128904"
/// summary : "2月14日0—24时，湖北省新增新冠肺炎病例2420例(含临床诊断病例1138例、核减前一日临床诊断病例22例)全省累计治愈出院4774例(含临床诊断病例631例)。全省累计病亡1457例(含临床诊断病例69例)。现有疑似病例5534人，当日排除1702人，集中隔离5149人。累计追踪密切接触者176148人，尚在接受医学观察77323人。"
/// title : "湖北新增2420例，累计54406例"

class CovNews {
  int adoptType;
  int createTime;
  String dataInfoOperator;
  int dataInfoState;
  int dataInfoTime;
  int entryWay;
  int id;
  String infoSource;
  int infoType;
  int modifyTime;
  String provinceId;
  String provinceName;
  int pubDate;
  String pubDateStr;
  String sourceUrl;
  String summary;
  String title;

  static CovNews fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CovNews bean = CovNews();
    bean.adoptType = map['adoptType'];
    bean.createTime = map['createTime'];
    bean.dataInfoOperator = map['dataInfoOperator'];
    bean.dataInfoState = map['dataInfoState'];
    bean.dataInfoTime = map['dataInfoTime'];
    bean.entryWay = map['entryWay'];
    bean.id = map['id'];
    bean.infoSource = map['infoSource'];
    bean.infoType = map['infoType'];
    bean.modifyTime = map['modifyTime'];
    bean.provinceId = map['provinceId'];
    bean.provinceName = map['provinceName'];
    bean.pubDate = map['pubDate'];
    bean.pubDateStr = map['pubDateStr'];
    bean.sourceUrl = map['sourceUrl'];
    bean.summary = map['summary'];
    bean.title = map['title'];
    return bean;
  }

  Map toJson() => {
        "adoptType": adoptType,
        "createTime": createTime,
        "dataInfoOperator": dataInfoOperator,
        "dataInfoState": dataInfoState,
        "dataInfoTime": dataInfoTime,
        "entryWay": entryWay,
        "id": id,
        "infoSource": infoSource,
        "infoType": infoType,
        "modifyTime": modifyTime,
        "provinceId": provinceId,
        "provinceName": provinceName,
        "pubDate": pubDate,
        "pubDateStr": pubDateStr,
        "sourceUrl": sourceUrl,
        "summary": summary,
        "title": title,
      };
}

/// times : "截至2月15日16时02分"
/// cachetime : "2020-02-15 16:03:01"
/// province : "河北"
/// contotal : "291"
/// deathtotal : "3"
/// sustotal : "33"
/// curetotal : "92"
/// banner : "https://n.sinaimg.cn/news/66ceb6d9/20200129/banner.png"
/// citys : [{"cityName":"石家庄","currentConfirmedCount":20,"confirmedCount":27,"suspectedCount":0,"curedCount":7,"deadCount":0},{"cityName":"廊坊","currentConfirmedCount":17,"confirmedCount":29,"suspectedCount":0,"curedCount":12,"deadCount":0},{"cityName":"沧州","currentConfirmedCount":30,"confirmedCount":46,"suspectedCount":0,"curedCount":14,"deadCount":2},{"cityName":"邯郸","currentConfirmedCount":22,"confirmedCount":31,"suspectedCount":0,"curedCount":9,"deadCount":0},{"cityName":"保定","currentConfirmedCount":15,"confirmedCount":32,"suspectedCount":0,"curedCount":17,"deadCount":0},{"cityName":"邢台","currentConfirmedCount":13,"confirmedCount":22,"suspectedCount":0,"curedCount":8,"deadCount":1},{"cityName":"衡水","currentConfirmedCount":4,"confirmedCount":8,"suspectedCount":0,"curedCount":4,"deadCount":0},{"cityName":"承德","currentConfirmedCount":4,"confirmedCount":7,"suspectedCount":0,"curedCount":3,"deadCount":0},{"cityName":"唐山","currentConfirmedCount":37,"confirmedCount":46,"suspectedCount":0,"curedCount":9,"deadCount":0},{"cityName":"张家口","currentConfirmedCount":26,"confirmedCount":33,"suspectedCount":0,"curedCount":7,"deadCount":0},{"cityName":"秦皇岛","currentConfirmedCount":8,"confirmedCount":10,"suspectedCount":0,"curedCount":2,"deadCount":0}]
/// history : [{"date":"02.14","currentConfirmedCount":201,"confirmedCount":291,"suspectedCount":33,"curedCount":87,"deadCount":3},{"date":"02.13","currentConfirmedCount":211,"confirmedCount":283,"suspectedCount":39,"curedCount":69,"deadCount":3},{"date":"2.12","currentConfirmedCount":208,"confirmedCount":265,"suspectedCount":37,"curedCount":54,"deadCount":3},{"date":"02.11","currentConfirmedCount":201,"confirmedCount":251,"suspectedCount":43,"curedCount":48,"deadCount":2},{"date":"02.09","currentConfirmedCount":181,"confirmedCount":218,"suspectedCount":61,"curedCount":35,"deadCount":2},{"date":"02.08","currentConfirmedCount":174,"confirmedCount":206,"suspectedCount":76,"curedCount":30,"deadCount":2},{"date":"02.07","currentConfirmedCount":169,"confirmedCount":195,"suspectedCount":81,"curedCount":25,"deadCount":1},{"date":"02.06","currentConfirmedCount":154,"confirmedCount":171,"suspectedCount":117,"curedCount":16,"deadCount":1},{"date":"02.05","currentConfirmedCount":149,"confirmedCount":157,"suspectedCount":133,"curedCount":7,"deadCount":1},{"date":"02.04","currentConfirmedCount":130,"confirmedCount":135,"suspectedCount":117,"curedCount":4,"deadCount":1},{"date":"02.03","currentConfirmedCount":122,"confirmedCount":126,"suspectedCount":93,"curedCount":3,"deadCount":1},{"date":"02.02","currentConfirmedCount":109,"confirmedCount":113,"suspectedCount":108,"curedCount":3,"deadCount":1},{"date":"02.01","currentConfirmedCount":100,"confirmedCount":104,"suspectedCount":104,"curedCount":3,"deadCount":1},{"date":"01.31","currentConfirmedCount":95,"confirmedCount":96,"suspectedCount":88,"curedCount":0,"deadCount":1},{"date":"01.30","currentConfirmedCount":81,"confirmedCount":82,"suspectedCount":78,"curedCount":0,"deadCount":1},{"date":"01.29","currentConfirmedCount":64,"confirmedCount":65,"suspectedCount":68,"curedCount":0,"deadCount":1},{"date":"01.28","currentConfirmedCount":47,"confirmedCount":48,"suspectedCount":56,"curedCount":0,"deadCount":1},{"date":"01.27","currentConfirmedCount":32,"confirmedCount":33,"suspectedCount":54,"curedCount":0,"deadCount":1},{"date":"01.26","currentConfirmedCount":17,"confirmedCount":18,"suspectedCount":16,"curedCount":0,"deadCount":1},{"date":"01.25","currentConfirmedCount":12,"confirmedCount":13,"suspectedCount":5,"curedCount":0,"deadCount":1},{"date":"01.24","currentConfirmedCount":7,"confirmedCount":8,"suspectedCount":0,"curedCount":0,"deadCount":1},{"date":"01.23","currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":1},{"date":"01.22","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0}]

class ProvinceDataBean {
  String times;
  String cacheTime;
  String province;
  String conTotal;
  String deathTotal;
  String susTotal;
  String cureTotal;
  String banner;
  List<CitiesBean> cities;
  List<HistoryBean> history;

  static ProvinceDataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProvinceDataBean bean = ProvinceDataBean();
    bean.times = map['times'];
    bean.cacheTime = map['cachetime'];
    bean.province = map['province'];
    bean.conTotal = map['contotal'];
    bean.deathTotal = map['deathtotal'];
    bean.susTotal = map['sustotal'];
    bean.cureTotal = map['curetotal'];
    bean.banner = map['banner'];
    bean.cities = List()
      ..addAll((map['cities'] as List ?? []).map((o) => CitiesBean.fromMap(o)));
    bean.history = List()
      ..addAll(
          (map['history'] as List ?? []).map((o) => HistoryBean.fromMap(o)));
    return bean;
  }

  Map toJson() => {
        "times": times,
        "cachetime": cacheTime,
        "province": province,
        "contotal": conTotal,
        "deathtotal": deathTotal,
        "sustotal": susTotal,
        "curetotal": cureTotal,
        "banner": banner,
        "cities": cities,
        "history": history,
      };
}

/// date : "02.14"
/// currentConfirmedCount : 201
/// confirmedCount : 291
/// suspectedCount : 33
/// curedCount : 87
/// deadCount : 3

class HistoryBean {
  String date;
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;

  static HistoryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HistoryBean historyBean = HistoryBean();
    historyBean.date = map['date'];
    historyBean.currentConfirmedCount = map['currentConfirmedCount'];
    historyBean.confirmedCount = map['confirmedCount'];
    historyBean.suspectedCount = map['suspectedCount'];
    historyBean.curedCount = map['curedCount'];
    historyBean.deadCount = map['deadCount'];
    return historyBean;
  }

  Map toJson() => {
        "date": date,
        "currentConfirmedCount": currentConfirmedCount,
        "confirmedCount": confirmedCount,
        "suspectedCount": suspectedCount,
        "curedCount": curedCount,
        "deadCount": deadCount,
      };
}

/// id : "imxyqvz3152896"
/// cid : 51922
/// title : "北京市餐饮行业协会发布2471家外卖供餐门店名单"
/// stitle : ""
/// cTime : "2020-02-15 19:40:30"
/// pub_time : 1581766830
/// tags : ["外卖","新冠肺炎","北京"]
/// modelID : "news_news"
/// thumb : ""
/// media : "北京日报客户端"
/// comment : {"title":"","URL":"","origID":"","enabled":true,"ID":"comos-imxyqvz3152896","unifyToSubject":true,"vote":true,"groupid":"gn:comos-ihnzhfz9427973","channel":"gn"}
/// url : "https://news.sina.cn/gn/2020-02-15/detail-iimxyqvz3152896.d.html"
/// expId : "15818123925524sinawap5e488aa886dc0364070781"
/// reqId : ""

class ProvinceNews {
  String id;
  int cid;
  String title;
  String sTitle;
  String cTime;
  int pubTime;
  List<String> tags;
  String modelID;
  String thumb;
  String media;
  CommentBean comment;
  String url;
  String expId;
  String reqId;

  static ProvinceNews fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProvinceNews bean = ProvinceNews();
    bean.id = map['id'];
    bean.cid = map['cid'];
    bean.title = map['title'];
    bean.sTitle = map['stitle'];
    bean.cTime = map['cTime'];
    bean.pubTime = map['pub_time'];
    bean.tags = List()
      ..addAll((map['tags'] as List ?? []).map((o) => o.toString()));
    bean.modelID = map['modelID'];
    bean.thumb = map['thumb'];
    bean.media = map['media'];
    bean.comment = CommentBean.fromMap(map['comment']);
    bean.url = map['url'];
    bean.expId = map['expId'];
    bean.reqId = map['reqId'];
    return bean;
  }

  Map toJson() => {
        "id": id,
        "cid": cid,
        "title": title,
        "stitle": sTitle,
        "cTime": cTime,
        "pub_time": pubTime,
        "tags": tags,
        "modelID": modelID,
        "thumb": thumb,
        "media": media,
        "comment": comment,
        "url": url,
        "expId": expId,
        "reqId": reqId,
      };
}

/// title : ""
/// URL : ""
/// origID : ""
/// enabled : true
/// ID : "comos-imxyqvz3152896"
/// unifyToSubject : true
/// vote : true
/// groupid : "gn:comos-ihnzhfz9427973"
/// channel : "gn"

class CommentBean {
  String title;
  String url;
  String origID;
  bool enabled;
  String id;
  bool unifyToSubject;
  bool vote;
  String groupId;
  String channel;

  static CommentBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommentBean commentBean = CommentBean();
    commentBean.title = map['title'];
    commentBean.url = map['URL'];
    commentBean.origID = map['origID'];
    commentBean.enabled = map['enabled'];
    commentBean.id = map['ID'];
    commentBean.unifyToSubject = map['unifyToSubject'];
    commentBean.vote = map['vote'];
    commentBean.groupId = map['groupid'];
    commentBean.channel = map['channel'];
    return commentBean;
  }

  Map toJson() => {
        "title": title,
        "URL": url,
        "origID": origID,
        "enabled": enabled,
        "ID": id,
        "unifyToSubject": unifyToSubject,
        "vote": vote,
        "groupid": groupId,
        "channel": channel,
      };
}

/// _id : "5e3a904acaad215a7c5820ec"
/// bigPic : "http://inews.gtimg.com/newsapp_ls/0/11307030967/0"
/// sharePic : "http://inews.gtimg.com/newsapp_ls/0/11307031419/0"
/// pubtime : "20200207"

class Analyze {
  String id;
  String bigPic;
  String sharePic;
  String pubTime;

  static Analyze fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Analyze bean = Analyze();
    bean.id = map['_id'];
    bean.bigPic = map['bigPic'];
    bean.sharePic = map['sharePic'];
    bean.pubTime = formatDateByStr(map['pubtime'],
        formats: [yyyy, '年', mm, '月', dd, '日 ', EEEE_ZH]);
    return bean;
  }

  Map toJson() => {
        "_id": id,
        "bigPic": bigPic,
        "sharePic": sharePic,
        "pubtime": pubTime,
      };
}

/// confid : "29-75"
/// province : "广西壮族自治区"
/// city : "南宁市"
/// county : "马山县"
/// location : ""
/// user_num : ""
/// user_name : "覃某某，男，30岁"
/// other_info : "马山人，住南宁市马山县金钗镇乐江村塘乐屯，为2月14日确诊病例覃某某的儿子"
/// track : "[{\"time\":\"1月28日\",\"action\":\"与同一村屯的确诊病例罗某某有同餐史\"},{\"time\":\"2月15日\",\"action\":\"转入市级定点救治医院进行隔离治疗。\"}]"
/// target : ""
/// pub_time : "2020-02-16 00:00:00"
/// source : "广西日报 "
/// source_url : "https://mp.weixin.qq.com/s/ORUgmzPZRb4DDeKnJiR4zg"
/// contact : ""
/// contact_detail : ""
/// hashtag : "4720d16245bcd93583d0149f9efad955"
/// lasttime : "2020-02-16 14:33:16"

class Trajectory {
  String confId;
  String province;
  String city;
  String county;
  String location;
  String userNum;
  String userName;
  String otherInfo;
  List<Track> track;
  String target;
  String pubTime;
  String source;
  String sourceUrl;
  String contact;
  String contactDetail;
  String hashTag;
  String lastTime;

  static Trajectory fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Trajectory listBean = Trajectory();
    listBean.confId = map['confid'];
    listBean.province = map['province'];
    listBean.city = map['city'];
    listBean.county = map['county'];
    listBean.location = map['location'];
    listBean.userNum = map['user_num'];
    listBean.userName = map['user_name'];
    listBean.otherInfo = map['other_info'];
    listBean.track = List()
      ..addAll((json.decode(map['track']) as List ?? [])
          .map((o) => Track.fromMap(o)));
    listBean.target = map['target'];
    listBean.pubTime = map['pub_time'];
    listBean.source = map['source'];
    listBean.sourceUrl = map['source_url'];
    listBean.contact = map['contact'];
    listBean.contactDetail = map['contact_detail'];
    listBean.hashTag = map['hashtag'];
    listBean.lastTime = map['lasttime'];
    return listBean;
  }

  Map toJson() => {
        "confid": confId,
        "province": province,
        "city": city,
        "county": county,
        "location": location,
        "user_num": userNum,
        "user_name": userName,
        "other_info": otherInfo,
        "track": track,
        "target": target,
        "pub_time": pubTime,
        "source": source,
        "source_url": sourceUrl,
        "contact": contact,
        "contact_detail": contactDetail,
        "hashtag": hashTag,
        "lasttime": lastTime,
      };
}

/// time : "2月5日"
/// action : "其作为密切接触者，在固安县定点医院进行隔离治疗"

class Track {
  String time;
  String action;

  static Track fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Track bean = Track();
    bean.time = map['time'];
    bean.action = map['action'];
    return bean;
  }

  Map toJson() => {
        "time": time,
        "action": action,
      };
}

/// id : 130
/// createTime : 1581927430000
/// modifyTime : 1581927430000
/// contentType : 4
/// title : "疫情期间宅在家，肚子越来越大？这些食物推荐给你"
/// imgUrl : "https://img1.dxycdn.com/2020/0217/055/3397163273262062794-135.jpg"
/// linkUrl : "https://mp.weixin.qq.com/s/NaWm7-N2lnZnhVTdnc_fJA"
/// recordStatus : 1
/// sort : 274
/// operator : "gehaotuo"

class RecommendBean {
  int id;
  int createTime;
  int modifyTime;
  int contentType;
  String title;
  String imgUrl;
  String linkUrl;
  int recordStatus;
  int sort;
  String operator;

  static RecommendBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RecommendBean recommendBean = RecommendBean();
    recommendBean.id = map['id'];
    recommendBean.createTime = map['createTime'];
    recommendBean.modifyTime = map['modifyTime'];
    recommendBean.contentType = map['contentType'];
    recommendBean.title = map['title'];
    recommendBean.imgUrl = map['imgUrl'];
    recommendBean.linkUrl = map['linkUrl'];
    recommendBean.recordStatus = map['recordStatus'];
    recommendBean.sort = map['sort'];
    recommendBean.operator = map['operator'];
    return recommendBean;
  }

  Map toJson() => {
        "id": id,
        "createTime": createTime,
        "modifyTime": modifyTime,
        "contentType": contentType,
        "title": title,
        "imgUrl": imgUrl,
        "linkUrl": linkUrl,
        "recordStatus": recordStatus,
        "sort": sort,
        "operator": operator,
      };
}

/// id : 1
/// title : "什么是新型冠状病毒？"
/// imgUrl : ""
/// linkUrl : "https://ask.dxy.com/ama/index#/disease/24677/info/0"
/// description : "此次流行的冠状病毒为一种新发现的冠状病毒，国际病毒分类委员会命名为 SARS-Cov-2。因为人群缺少对新型病毒株的免疫力，所以人群普遍易感。"
/// sort : 99

class WikiListBean {
  int id;
  String title;
  String imgUrl;
  String linkUrl;
  String description;
  int sort;

  static WikiListBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WikiListBean wiki_list = WikiListBean();
    wiki_list.id = map['id'];
    wiki_list.title = map['title'];
    wiki_list.imgUrl = map['imgUrl'];
    wiki_list.linkUrl = map['linkUrl'];
    wiki_list.description = map['description'];
    wiki_list.sort = map['sort'];
    return wiki_list;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "imgUrl": imgUrl,
        "linkUrl": linkUrl,
        "description": description,
        "sort": sort,
      };
}

/// id : 160
/// title : "温州确诊病例有 40% 是变异病毒？"
/// mainSummary : "广州疾控中心辟谣：新型冠状病毒未发生明显的变异"
/// summary : ""
/// body : "近日，「温州 490 例里有 40% 是全新变异的病毒，疾控中心现在要排查 3 万多人从温州回广东的这批人」这一谣言在广州地区用户微信群转发。广州疾控中心表示，我国最新研究表明：新型冠状病毒未发生明显的变异。对新型冠状病毒的密切监测也表明，不论是环境中分离的病毒，还是前期在人体中分离的病毒，再到近日分离的病毒，均未发现明显的变异。"
/// sourceUrl : ""
/// score : 1000
/// rumorType : 0

class RumourBean {
  int id;
  String title;
  String mainSummary;
  String summary;
  String body;
  String sourceUrl;
  int score;
  int rumorType;
  String rumorText;
  String rumorIcon;

  static RumourBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RumourBean rumourBean = RumourBean();
    rumourBean.id = map['id'];
    rumourBean.title = map['title'];
    rumourBean.mainSummary = map['mainSummary'];
    rumourBean.summary = map['summary'];
    rumourBean.body = map['body'];
    rumourBean.sourceUrl = map['sourceUrl'];
    rumourBean.score = map['score'];
    rumourBean.rumorType = map['rumorType'];
    rumourBean.rumorText = map['rumorType'] == 0
        ? "images/rumor_text.png"
        : map['rumorType'] == 2
            ? "images/shangwudinglun_text.png"
            : "images/kexin_text.png";
    rumourBean.rumorIcon = map['rumorType'] == 0
        ? "images/rumor_icon.png"
        : map['rumorType'] == 2
            ? "images/shangwudinglun_icon.png"
            : "images/kexin_icon.png";
    return rumourBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "mainSummary": mainSummary,
        "summary": summary,
        "body": body,
        "sourceUrl": sourceUrl,
        "score": score,
        "rumorType": rumorType,
      };
}

class PreventManualBase {
  List<PreventManual> result1;
  List<PreventManual> result2;

  static PreventManualBase fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PreventManualBase bean = PreventManualBase();
    bean.result1 = List()
      ..addAll(
          (map['result1'] as List ?? []).map((o) => PreventManual.fromMap(o)));
    bean.result2 = List()
      ..addAll(
          (map['result2'] as List ?? []).map((o) => PreventManual.fromMap(o)));
    return bean;
  }

  Map toJson() => {
        "result1": result1,
        "result2": result2,
      };
}

/// title : "菜场买菜，如何远离新型冠状病毒？"
/// abs : "建议外出买菜者错峰出行，减少逗留，戴好口罩，保持距离，注意洗手，回家清洁。"
/// h5url : "https://h5.baike.qq.com/mobile/article.html?docid=tx000010015wpnnw&adtag=txxw.op.fybox"
/// image : ""
/// author_info : {"name":"姜太一","icon":"","title":"副主任医师","department":"感染中心","hospital":"首都医科大学附属北京佑安医院"}

class PreventManual {
  String title;
  String abs;
  String h5url;
  String image;
  AuthorInfoBean authorInfo;

  static PreventManual fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PreventManual bean = PreventManual();
    bean.title = map['title'];
    bean.abs = map['abs'];
    bean.h5url = map['h5url'];
    bean.image = map['image'];
    bean.authorInfo = AuthorInfoBean.fromMap(map['author_info']);
    return bean;
  }

  Map toJson() => {
        "title": title,
        "abs": abs,
        "h5url": h5url,
        "image": image,
        "author_info": authorInfo,
      };
}

/// name : "姜太一"
/// icon : ""
/// title : "副主任医师"
/// department : "感染中心"
/// hospital : "首都医科大学附属北京佑安医院"

class AuthorInfoBean {
  String name;
  String icon;
  String title;
  String department;
  String hospital;

  static AuthorInfoBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuthorInfoBean authorInfo = AuthorInfoBean();
    authorInfo.name = map['name'];
    authorInfo.icon = map['icon'];
    authorInfo.title = map['title'];
    authorInfo.department = map['department'];
    authorInfo.hospital = map['hospital'];
    return authorInfo;
  }

  Map toJson() => {
        "name": name,
        "icon": icon,
        "title": title,
        "department": department,
        "hospital": hospital,
      };
}
