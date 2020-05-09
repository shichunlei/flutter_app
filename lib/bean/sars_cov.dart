import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../page_index.dart';

/// id : 1
/// createTime : 1579537899000
/// modifyTime : 1585181713000
/// imgUrl : "http://49.232.173.220:3001/images/distribution-nationale.png?time=1585182329729"
/// dailyPics : ["https://img1.dxycdn.com/2020/0211/763/3395998884005602079-135.png","https://img1.dxycdn.com/2020/0211/362/3395998896890788910-135.png","https://img1.dxycdn.com/2020/0211/365/3395998905480724211-135.png","https://img1.dxycdn.com/2020/0211/364/3395998916217859778-135.png","https://img1.dxycdn.com/2020/0211/922/3395998929103046444-135.png","https://img1.dxycdn.com/2020/0211/089/3395998939840182072-135.png"]
/// summary : ""
/// deleted : false
/// countRemark : ""
/// currentConfirmedCount : 4834
/// confirmedCount : 81920
/// suspectedCount : 474
/// curedCount : 73799
/// deadCount : 3287
/// seriousCount : 1399
/// remark1 : "易感人群：人群普遍易感。老年人及有基础疾病者感染后病情较重，儿童及婴幼儿也有发病"
/// remark2 : "潜伏期：一般为 3～7 天，最长不超过 14 天，潜伏期内可能存在传染性，其中无症状病例传染性非常罕见"
/// remark3 : "宿主：野生动物，可能为中华菊头蝠"
/// remark4 : ""
/// remark5 : ""
/// note1 : "病毒：SARS-CoV-2，其导致疾病命名 COVID-19"
/// note2 : "传染源：新冠肺炎的患者。无症状感染者也可能成为传染源。"
/// note3 : "传播途径：经呼吸道飞沫、接触传播是主要的传播途径。气溶胶传播和消化道等传播途径尚待明确。"
/// generalRemark : "1. 3 月 12 日国家卫健委确诊补订遗漏 12 例确诊病例（非 12 日新增），暂无具体省份信息。 2. 浙江省 12 例外省治愈暂无具体省份信息。"
/// abroadRemark : ""
/// marquee : [{"id":1737,"marqueeLabel":"全球疫情","marqueeContent":"美国成为现存新冠感染最多的国家","marqueeLink":"https://dxy.me/Sg1rjk"},{"id":1738,"marqueeLabel":"恢复","marqueeContent":"武汉 4 月 8 日将恢复商业航班","marqueeLink":"https://dxy.me/PR2Eha"},{"id":1739,"marqueeLabel":"最新消息","marqueeContent":"英国查尔斯王子新冠病毒检测阳性","marqueeLink":"https://dxy.me/1P0gqf"}]
/// quanguoTrendChart : [{"imgUrl":"https://img1.dxycdn.com/2020/0324/278/3403801351376518263-135.png","title":"新增疑似/新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0324/812/3403847865872006755-135.png","title":"境外输入"},{"imgUrl":"https://img1.dxycdn.com/2020/0324/547/3403847848692336947-135.png","title":"现存确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0324/775/3403801407211095604-135.png","title":"治愈"},{"imgUrl":"https://img1.dxycdn.com/2020/0324/250/3403801424390727199-135.png","title":"死亡"}]
/// hbFeiHbTrendChart : [{"imgUrl":"https://img1.dxycdn.com/2020/0325/741/3403976603221840149-135.png","title":"非湖北新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0325/960/3403975761408398645-135.png","title":"湖北新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0325/018/3403975785030543028-135.png","title":"湖北现存确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0325/656/3403975810800347601-135.png","title":"非湖北现存确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0325/340/3403975838717812269-135.png","title":"治愈/死亡"}]
/// foreignTrendChart : [{"imgUrl":"https://img1.dxycdn.com/2020/0320/702/3403079914982117944-135.png","title":"国外新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/396/3403079925719536561-135.png","title":"国外累计确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/139/3403079936457225524-135.png","title":"国外死亡"}]
/// importantForeignTrendChart : [{"imgUrl":"https://img1.dxycdn.com/2020/0320/450/3403077453965772423-135.png","title":"重点国家新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/276/3403077462555980566-135.png","title":"日本新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/340/3403077473293125942-135.png","title":"意大利新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/723/3403077481883334043-135.png","title":"伊朗新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/266/3403077492620752785-135.png","title":"美国新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/870/3403077503358171278-135.png","title":"法国新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/053/3403077511947832997-135.png","title":"德国新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/878/3403077520537768006-135.png","title":"西班牙新增确诊"},{"imgUrl":"https://img1.dxycdn.com/2020/0320/443/3403077531275186665-135.png","title":"韩国新增确诊"}]
/// foreignTrendChartGlobal : [{"imgUrl":"https://img1.dxycdn.com/2020/0319/740/3402859458605738923-135.png","title":"Daily New Cases"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/351/3402856772103846114-135.png","title":"Total Confirmed Cases"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/236/3402856782841001789-135.png","title":"Total Deaths Cases"}]
/// importantForeignTrendChartGlobal : [{"imgUrl":"https://img1.dxycdn.com/2020/0319/122/3402856838675578578-135.png","title":"Daily New Cases"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/685/3402856849412997239-135.png","title":"Japan"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/477/3402856860150678804-135.png","title":"Italy"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/454/3402856873035581014-135.png","title":"Iran"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/022/3402856883772999714-135.png","title":"U.S.A."},{"imgUrl":"https://img1.dxycdn.com/2020/0319/529/3402856894510155506-135.png","title":"France"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/211/3402856905247574064-135.png","title":"Germany"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/054/3402856913837508985-135.png","title":"Spain"},{"imgUrl":"https://img1.dxycdn.com/2020/0319/088/3402856928870157852-135.png","title":"Republic of Korea"}]
/// foreignStatistics : {"currentConfirmedCount":323870,"confirmedCount":380146,"suspectedCount":4,"curedCount":38720,"deadCount":17556}
/// globalStatistics : {"currentConfirmedCount":328704,"confirmedCount":462066,"curedCount":112519,"deadCount":20843}
/// globalOtherTrendChartData : "https://file1.dxycdn.com/2020/0325/690/3403979839479981647-135.json"
/// provinces : [{"provinceName":"湖北省","provinceShortName":"湖北","currentConfirmedCount":3827,"confirmedCount":67801,"suspectedCount":0,"curedCount":60811,"deadCount":3163,"comment":"","locationId":420000,"cities":[{"cityName":"武汉","currentConfirmedCount":3793,"confirmedCount":50006,"suspectedCount":0,"curedCount":43687,"deadCount":2526,"locationId":420100},{"cityName":"孝感","currentConfirmedCount":10,"confirmedCount":3518,"suspectedCount":0,"curedCount":3380,"deadCount":128,"locationId":420900},{"cityName":"鄂州","currentConfirmedCount":7,"confirmedCount":1394,"suspectedCount":0,"curedCount":1328,"deadCount":59,"locationId":420700},{"cityName":"荆门","currentConfirmedCount":3,"confirmedCount":928,"suspectedCount":0,"curedCount":886,"deadCount":39,"locationId":420800},{"cityName":"荆州","currentConfirmedCount":2,"confirmedCount":1580,"suspectedCount":0,"curedCount":1527,"deadCount":51,"locationId":421000},{"cityName":"随州","currentConfirmedCount":2,"confirmedCount":1307,"suspectedCount":0,"curedCount":1260,"deadCount":45,"locationId":421300},{"cityName":"襄阳","currentConfirmedCount":2,"confirmedCount":1175,"suspectedCount":0,"curedCount":1134,"deadCount":39,"locationId":420600},{"cityName":"黄石","currentConfirmedCount":2,"confirmedCount":1015,"suspectedCount":0,"curedCount":974,"deadCount":39,"locationId":420200},{"cityName":"宜昌","currentConfirmedCount":2,"confirmedCount":931,"suspectedCount":0,"curedCount":893,"deadCount":36,"locationId":420500},{"cityName":"仙桃","currentConfirmedCount":2,"confirmedCount":575,"suspectedCount":0,"curedCount":551,"deadCount":22,"locationId":429004},{"cityName":"潜江","currentConfirmedCount":2,"confirmedCount":198,"suspectedCount":0,"curedCount":187,"deadCount":9,"locationId":429005},{"cityName":"黄冈","currentConfirmedCount":0,"confirmedCount":2907,"suspectedCount":0,"curedCount":2782,"deadCount":125,"locationId":421100},{"cityName":"咸宁","currentConfirmedCount":0,"confirmedCount":836,"suspectedCount":0,"curedCount":821,"deadCount":15,"locationId":421200},{"cityName":"十堰","currentConfirmedCount":0,"confirmedCount":672,"suspectedCount":0,"curedCount":664,"deadCount":8,"locationId":420300},{"cityName":"天门","currentConfirmedCount":0,"confirmedCount":496,"suspectedCount":0,"curedCount":481,"deadCount":15,"locationId":429006},{"cityName":"恩施州","currentConfirmedCount":0,"confirmedCount":252,"suspectedCount":0,"curedCount":245,"deadCount":7,"locationId":422800},{"cityName":"神农架林区","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":429021}]},{"provinceName":"香港","provinceShortName":"香港","currentConfirmedCount":304,"confirmedCount":410,"suspectedCount":24,"curedCount":102,"deadCount":4,"comment":"","locationId":810000,"cities":[]},{"provinceName":"台湾","provinceShortName":"台湾","currentConfirmedCount":204,"confirmedCount":235,"suspectedCount":19,"curedCount":29,"deadCount":2,"comment":"","locationId":710000,"cities":[]},{"provinceName":"北京市","provinceShortName":"北京","currentConfirmedCount":150,"confirmedCount":561,"suspectedCount":2,"curedCount":403,"deadCount":8,"comment":"北京卫健委未明确大部分治愈与死亡病例的分区归属，因此北京市下辖分区的现存确诊暂无法获取。","locationId":110000,"cities":[{"cityName":"境外输入","currentConfirmedCount":134,"confirmedCount":145,"suspectedCount":2,"curedCount":11,"deadCount":0,"locationId":0},{"cityName":"朝阳区","currentConfirmedCount":72,"confirmedCount":72,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110105},{"cityName":"海淀区","currentConfirmedCount":64,"confirmedCount":64,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110108},{"cityName":"西城区","currentConfirmedCount":53,"confirmedCount":53,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110102},{"cityName":"丰台区","currentConfirmedCount":40,"confirmedCount":43,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":110106},{"cityName":"大兴区","currentConfirmedCount":23,"confirmedCount":39,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":110115},{"cityName":"外地来京","currentConfirmedCount":23,"confirmedCount":25,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":0},{"cityName":"昌平区","currentConfirmedCount":19,"confirmedCount":29,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":110114},{"cityName":"通州区","currentConfirmedCount":18,"confirmedCount":19,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":110112},{"cityName":"房山区","currentConfirmedCount":13,"confirmedCount":16,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":110111},{"cityName":"东城区","currentConfirmedCount":13,"confirmedCount":14,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":110101},{"cityName":"怀柔区","currentConfirmedCount":7,"confirmedCount":7,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110116},{"cityName":"密云区","currentConfirmedCount":7,"confirmedCount":7,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110118},{"cityName":"石景山区","currentConfirmedCount":5,"confirmedCount":14,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":110107},{"cityName":"门头沟区","currentConfirmedCount":1,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":110109},{"cityName":"延庆区","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":110119},{"cityName":"顺义区","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":110113},{"cityName":"待明确地区","currentConfirmedCount":-343,"confirmedCount":0,"suspectedCount":0,"curedCount":335,"deadCount":8,"locationId":0}]},{"provinceName":"上海市","provinceShortName":"上海","currentConfirmedCount":116,"confirmedCount":451,"suspectedCount":19,"curedCount":330,"deadCount":5,"comment":"因未公布分区死亡和治愈，仅展示累计确诊和现存确诊","locationId":310000,"cities":[{"cityName":"境外输入","currentConfirmedCount":109,"confirmedCount":112,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":0},{"cityName":"外地来沪","currentConfirmedCount":4,"confirmedCount":111,"suspectedCount":0,"curedCount":107,"deadCount":0,"locationId":0},{"cityName":"宝山区","currentConfirmedCount":2,"confirmedCount":22,"suspectedCount":0,"curedCount":19,"deadCount":1,"locationId":310113},{"cityName":"嘉定区","currentConfirmedCount":1,"confirmedCount":9,"suspectedCount":0,"curedCount":7,"deadCount":1,"locationId":310114},{"cityName":"浦东新区","currentConfirmedCount":0,"confirmedCount":61,"suspectedCount":0,"curedCount":60,"deadCount":1,"locationId":310115},{"cityName":"闵行区","currentConfirmedCount":0,"confirmedCount":19,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":310112},{"cityName":"徐汇区","currentConfirmedCount":0,"confirmedCount":18,"suspectedCount":0,"curedCount":17,"deadCount":1,"locationId":310104},{"cityName":"静安区","currentConfirmedCount":0,"confirmedCount":16,"suspectedCount":0,"curedCount":15,"deadCount":1,"locationId":310106},{"cityName":"松江区","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":310117},{"cityName":"长宁区","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":310105},{"cityName":"普陀区","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":310107},{"cityName":"杨浦区","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":310110},{"cityName":"奉贤区","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":310120},{"cityName":"虹口区","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":310109},{"cityName":"黄浦区","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":310101},{"cityName":"青浦区","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":310118},{"cityName":"金山区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":310116},{"cityName":"崇明区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":310151}]},{"provinceName":"广东省","provinceShortName":"广东","currentConfirmedCount":89,"confirmedCount":1433,"suspectedCount":5,"curedCount":1336,"deadCount":8,"comment":"深圳：确诊病例含19例境外输入病例；广州：确诊病例含22例境外输入病例；中山：确诊病例含2例境外输入病例；东莞：确诊病例含1例境外输入病例；佛山：确诊病例含3例境外输入病例；梅州：确诊病例含1例境外输入病例；肇庆：确诊病例含1例境外输入病例；珠海：确诊病例含2例境外输入病例；揭阳：确诊病例含1例境外输入病例；湛江：确诊病例含2例境外输入病例。","locationId":440000,"cities":[{"cityName":"广州","currentConfirmedCount":50,"confirmedCount":388,"suspectedCount":4,"curedCount":337,"deadCount":1,"locationId":440100},{"cityName":"深圳","currentConfirmedCount":24,"confirmedCount":441,"suspectedCount":1,"curedCount":414,"deadCount":3,"locationId":440300},{"cityName":"佛山","currentConfirmedCount":7,"confirmedCount":91,"suspectedCount":0,"curedCount":84,"deadCount":0,"locationId":440600},{"cityName":"珠海","currentConfirmedCount":3,"confirmedCount":101,"suspectedCount":0,"curedCount":97,"deadCount":1,"locationId":440400},{"cityName":"中山","currentConfirmedCount":2,"confirmedCount":68,"suspectedCount":0,"curedCount":66,"deadCount":0,"locationId":442000},{"cityName":"湛江","currentConfirmedCount":1,"confirmedCount":23,"suspectedCount":0,"curedCount":22,"deadCount":0,"locationId":440800},{"cityName":"肇庆","currentConfirmedCount":1,"confirmedCount":20,"suspectedCount":0,"curedCount":18,"deadCount":1,"locationId":441200},{"cityName":"梅州","currentConfirmedCount":1,"confirmedCount":17,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":441400},{"cityName":"揭阳","currentConfirmedCount":1,"confirmedCount":9,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":445200},{"cityName":"潮州","currentConfirmedCount":1,"confirmedCount":6,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":445100},{"cityName":"东莞","currentConfirmedCount":0,"confirmedCount":100,"suspectedCount":0,"curedCount":99,"deadCount":1,"locationId":441900},{"cityName":"惠州","currentConfirmedCount":0,"confirmedCount":62,"suspectedCount":0,"curedCount":62,"deadCount":0,"locationId":441300},{"cityName":"汕头","currentConfirmedCount":0,"confirmedCount":25,"suspectedCount":0,"curedCount":25,"deadCount":0,"locationId":440500},{"cityName":"江门","currentConfirmedCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":23,"deadCount":0,"locationId":440700},{"cityName":"阳江","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":441700},{"cityName":"茂名","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":440900},{"cityName":"清远","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":441800},{"cityName":"韶关","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":9,"deadCount":1,"locationId":440200},{"cityName":"汕尾","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":441500},{"cityName":"河源","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":441600},{"cityName":"待明确地区","currentConfirmedCount":-2,"confirmedCount":0,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":0}]},{"provinceName":"福建省","provinceShortName":"福建","currentConfirmedCount":26,"confirmedCount":322,"suspectedCount":0,"curedCount":295,"deadCount":1,"comment":"新增境外输入4例","locationId":350000,"cities":[{"cityName":"境外输入人员","currentConfirmedCount":26,"confirmedCount":26,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"福州","currentConfirmedCount":0,"confirmedCount":72,"suspectedCount":0,"curedCount":71,"deadCount":1,"locationId":350100},{"cityName":"莆田","currentConfirmedCount":0,"confirmedCount":56,"suspectedCount":0,"curedCount":56,"deadCount":0,"locationId":350300},{"cityName":"泉州","currentConfirmedCount":0,"confirmedCount":47,"suspectedCount":0,"curedCount":47,"deadCount":0,"locationId":350500},{"cityName":"厦门","currentConfirmedCount":0,"confirmedCount":35,"suspectedCount":0,"curedCount":35,"deadCount":0,"locationId":350200},{"cityName":"宁德","currentConfirmedCount":0,"confirmedCount":26,"suspectedCount":0,"curedCount":26,"deadCount":0,"locationId":350900},{"cityName":"漳州","currentConfirmedCount":0,"confirmedCount":20,"suspectedCount":0,"curedCount":20,"deadCount":0,"locationId":350600},{"cityName":"南平","currentConfirmedCount":0,"confirmedCount":20,"suspectedCount":0,"curedCount":20,"deadCount":0,"locationId":350700},{"cityName":"三明","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":350400},{"cityName":"龙岩","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":350800}]},{"provinceName":"澳门","provinceShortName":"澳门","currentConfirmedCount":20,"confirmedCount":30,"suspectedCount":4,"curedCount":10,"deadCount":0,"comment":"确诊病例中含5例境外输入病例","locationId":820000,"cities":[]},{"provinceName":"浙江省","provinceShortName":"浙江","currentConfirmedCount":19,"confirmedCount":1241,"suspectedCount":0,"curedCount":1221,"deadCount":1,"comment":"2月10日通报核减的12例在浙江省治愈的外省病例，根据国家最新要求重新纳入累计病例。","locationId":330000,"cities":[{"cityName":"境外输入","currentConfirmedCount":19,"confirmedCount":24,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":0},{"cityName":"温州","currentConfirmedCount":0,"confirmedCount":504,"suspectedCount":0,"curedCount":503,"deadCount":1,"locationId":330300},{"cityName":"杭州","currentConfirmedCount":0,"confirmedCount":181,"suspectedCount":0,"curedCount":181,"deadCount":0,"locationId":330100},{"cityName":"宁波","currentConfirmedCount":0,"confirmedCount":157,"suspectedCount":0,"curedCount":157,"deadCount":0,"locationId":330200},{"cityName":"台州","currentConfirmedCount":0,"confirmedCount":146,"suspectedCount":0,"curedCount":146,"deadCount":0,"locationId":331000},{"cityName":"金华","currentConfirmedCount":0,"confirmedCount":55,"suspectedCount":0,"curedCount":55,"deadCount":0,"locationId":330700},{"cityName":"嘉兴","currentConfirmedCount":0,"confirmedCount":45,"suspectedCount":0,"curedCount":45,"deadCount":0,"locationId":330400},{"cityName":"绍兴","currentConfirmedCount":0,"confirmedCount":42,"suspectedCount":0,"curedCount":42,"deadCount":0,"locationId":330600},{"cityName":"省十里丰监狱","currentConfirmedCount":0,"confirmedCount":36,"suspectedCount":0,"curedCount":36,"deadCount":0,"locationId":0},{"cityName":"丽水","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":331100},{"cityName":"衢州","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":330800},{"cityName":"湖州","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":330500},{"cityName":"舟山","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":330900}]},{"provinceName":"甘肃省","provinceShortName":"甘肃","currentConfirmedCount":13,"confirmedCount":136,"suspectedCount":0,"curedCount":121,"deadCount":2,"comment":"","locationId":620000,"cities":[{"cityName":"境外输入","currentConfirmedCount":13,"confirmedCount":45,"suspectedCount":0,"curedCount":32,"deadCount":0,"locationId":0},{"cityName":"兰州","currentConfirmedCount":0,"confirmedCount":36,"suspectedCount":0,"curedCount":34,"deadCount":2,"locationId":620100},{"cityName":"天水","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":620500},{"cityName":"平凉","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":620800},{"cityName":"定西","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":621100},{"cityName":"甘南","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":623000},{"cityName":"白银","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":620400},{"cityName":"陇南","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":621200},{"cityName":"庆阳","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":621000},{"cityName":"临夏","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":622900},{"cityName":"张掖","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":620700},{"cityName":"金昌","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":620300}]},{"provinceName":"天津市","provinceShortName":"天津","currentConfirmedCount":11,"confirmedCount":147,"suspectedCount":0,"curedCount":133,"deadCount":3,"comment":"","locationId":120000,"cities":[{"cityName":"境外输入","currentConfirmedCount":11,"confirmedCount":11,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"宝坻区","currentConfirmedCount":0,"confirmedCount":60,"suspectedCount":0,"curedCount":58,"deadCount":2,"locationId":120115},{"cityName":"河东区","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":14,"deadCount":1,"locationId":120102},{"cityName":"河北区","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":120105},{"cityName":"北辰区","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":120113},{"cityName":"南开区","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":120104},{"cityName":"和平区","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":120101},{"cityName":"外地来津","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":-1},{"cityName":"东丽区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":120110},{"cityName":"宁河区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":120117},{"cityName":"河西区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":120103},{"cityName":"西青区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":120111},{"cityName":"滨海新区","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":120116},{"cityName":"武清区","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":120114},{"cityName":"红桥区","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":120106},{"cityName":"津南区","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":120112}]},{"provinceName":"山东省","provinceShortName":"山东","currentConfirmedCount":10,"confirmedCount":769,"suspectedCount":0,"curedCount":752,"deadCount":7,"comment":"","locationId":370000,"cities":[{"cityName":"境外输入","currentConfirmedCount":10,"confirmedCount":10,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"济宁","currentConfirmedCount":0,"confirmedCount":260,"suspectedCount":0,"curedCount":260,"deadCount":0,"locationId":370800},{"cityName":"青岛","currentConfirmedCount":0,"confirmedCount":61,"suspectedCount":0,"curedCount":60,"deadCount":1,"locationId":370200},{"cityName":"临沂","currentConfirmedCount":0,"confirmedCount":49,"suspectedCount":0,"curedCount":49,"deadCount":0,"locationId":371300},{"cityName":"济南","currentConfirmedCount":0,"confirmedCount":47,"suspectedCount":0,"curedCount":47,"deadCount":0,"locationId":370100},{"cityName":"烟台","currentConfirmedCount":0,"confirmedCount":47,"suspectedCount":0,"curedCount":47,"deadCount":0,"locationId":370600},{"cityName":"潍坊","currentConfirmedCount":0,"confirmedCount":44,"suspectedCount":0,"curedCount":44,"deadCount":0,"locationId":370700},{"cityName":"威海","currentConfirmedCount":0,"confirmedCount":38,"suspectedCount":0,"curedCount":37,"deadCount":1,"locationId":371000},{"cityName":"聊城","currentConfirmedCount":0,"confirmedCount":38,"suspectedCount":0,"curedCount":38,"deadCount":0,"locationId":371500},{"cityName":"德州","currentConfirmedCount":0,"confirmedCount":37,"suspectedCount":0,"curedCount":35,"deadCount":2,"locationId":371400},{"cityName":"泰安","currentConfirmedCount":0,"confirmedCount":35,"suspectedCount":0,"curedCount":33,"deadCount":2,"locationId":370900},{"cityName":"淄博","currentConfirmedCount":0,"confirmedCount":30,"suspectedCount":0,"curedCount":29,"deadCount":1,"locationId":370300},{"cityName":"枣庄","currentConfirmedCount":0,"confirmedCount":24,"suspectedCount":0,"curedCount":24,"deadCount":0,"locationId":370400},{"cityName":"菏泽","currentConfirmedCount":0,"confirmedCount":18,"suspectedCount":0,"curedCount":18,"deadCount":0,"locationId":371700},{"cityName":"日照","currentConfirmedCount":0,"confirmedCount":16,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":371100},{"cityName":"滨州","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":15,"deadCount":0,"locationId":371600}]},{"provinceName":"四川省","provinceShortName":"四川","currentConfirmedCount":8,"confirmedCount":547,"suspectedCount":2,"curedCount":536,"deadCount":3,"comment":"成都市包含境外输入病例 4例","locationId":510000,"cities":[{"cityName":"成都","currentConfirmedCount":8,"confirmedCount":152,"suspectedCount":2,"curedCount":141,"deadCount":3,"locationId":510100},{"cityName":"甘孜州","currentConfirmedCount":0,"confirmedCount":78,"suspectedCount":0,"curedCount":78,"deadCount":0,"locationId":513300},{"cityName":"达州","currentConfirmedCount":0,"confirmedCount":42,"suspectedCount":0,"curedCount":42,"deadCount":0,"locationId":511700},{"cityName":"南充","currentConfirmedCount":0,"confirmedCount":39,"suspectedCount":0,"curedCount":39,"deadCount":0,"locationId":511300},{"cityName":"广安","currentConfirmedCount":0,"confirmedCount":30,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":511600},{"cityName":"泸州","currentConfirmedCount":0,"confirmedCount":24,"suspectedCount":0,"curedCount":24,"deadCount":0,"locationId":510500},{"cityName":"巴中","currentConfirmedCount":0,"confirmedCount":24,"suspectedCount":0,"curedCount":24,"deadCount":0,"locationId":511900},{"cityName":"绵阳","currentConfirmedCount":0,"confirmedCount":22,"suspectedCount":0,"curedCount":22,"deadCount":0,"locationId":510700},{"cityName":"内江","currentConfirmedCount":0,"confirmedCount":22,"suspectedCount":0,"curedCount":22,"deadCount":0,"locationId":511000},{"cityName":"德阳","currentConfirmedCount":0,"confirmedCount":18,"suspectedCount":0,"curedCount":18,"deadCount":0,"locationId":510600},{"cityName":"遂宁","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":510900},{"cityName":"攀枝花","currentConfirmedCount":0,"confirmedCount":16,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":510400},{"cityName":"凉山州","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":513400},{"cityName":"宜宾","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":511500},{"cityName":"自贡","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":510300},{"cityName":"眉山","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":511400},{"cityName":"雅安","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":511800},{"cityName":"广元","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":510800},{"cityName":"资阳","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":512000},{"cityName":"乐山","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":511100},{"cityName":"阿坝州","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":513200}]},{"provinceName":"江苏省","provinceShortName":"江苏","currentConfirmedCount":7,"confirmedCount":638,"suspectedCount":0,"curedCount":631,"deadCount":0,"comment":"","locationId":320000,"cities":[{"cityName":"境外输入","currentConfirmedCount":7,"confirmedCount":7,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"南京","currentConfirmedCount":0,"confirmedCount":93,"suspectedCount":0,"curedCount":93,"deadCount":0,"locationId":320100},{"cityName":"苏州","currentConfirmedCount":0,"confirmedCount":87,"suspectedCount":0,"curedCount":87,"deadCount":0,"locationId":320500},{"cityName":"徐州","currentConfirmedCount":0,"confirmedCount":79,"suspectedCount":0,"curedCount":79,"deadCount":0,"locationId":320300},{"cityName":"淮安","currentConfirmedCount":0,"confirmedCount":66,"suspectedCount":0,"curedCount":66,"deadCount":0,"locationId":320800},{"cityName":"无锡","currentConfirmedCount":0,"confirmedCount":55,"suspectedCount":0,"curedCount":55,"deadCount":0,"locationId":320200},{"cityName":"常州","currentConfirmedCount":0,"confirmedCount":51,"suspectedCount":0,"curedCount":51,"deadCount":0,"locationId":320400},{"cityName":"连云港","currentConfirmedCount":0,"confirmedCount":48,"suspectedCount":0,"curedCount":48,"deadCount":0,"locationId":320700},{"cityName":"南通","currentConfirmedCount":0,"confirmedCount":40,"suspectedCount":0,"curedCount":40,"deadCount":0,"locationId":320600},{"cityName":"泰州","currentConfirmedCount":0,"confirmedCount":37,"suspectedCount":0,"curedCount":37,"deadCount":0,"locationId":321200},{"cityName":"盐城","currentConfirmedCount":0,"confirmedCount":27,"suspectedCount":0,"curedCount":27,"deadCount":0,"locationId":320900},{"cityName":"扬州","currentConfirmedCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":23,"deadCount":0,"locationId":321000},{"cityName":"宿迁","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":321300},{"cityName":"镇江","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":321100}]},{"provinceName":"陕西省","provinceShortName":"陕西","currentConfirmedCount":7,"confirmedCount":250,"suspectedCount":1,"curedCount":240,"deadCount":3,"comment":"","locationId":610000,"cities":[{"cityName":"境外输入","currentConfirmedCount":5,"confirmedCount":5,"suspectedCount":1,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"西安","currentConfirmedCount":3,"confirmedCount":120,"suspectedCount":0,"curedCount":114,"deadCount":3,"locationId":610100},{"cityName":"咸阳","currentConfirmedCount":1,"confirmedCount":17,"suspectedCount":0,"curedCount":16,"deadCount":0,"locationId":610400},{"cityName":"渭南","currentConfirmedCount":1,"confirmedCount":15,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":610500},{"cityName":"安康","currentConfirmedCount":0,"confirmedCount":26,"suspectedCount":0,"curedCount":26,"deadCount":0,"locationId":610900},{"cityName":"汉中","currentConfirmedCount":0,"confirmedCount":26,"suspectedCount":0,"curedCount":26,"deadCount":0,"locationId":610700},{"cityName":"宝鸡","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":610300},{"cityName":"延安","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":610600},{"cityName":"铜川","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":610200},{"cityName":"商洛","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":611000},{"cityName":"榆林","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":610800},{"cityName":"韩城","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":610581},{"cityName":"杨凌","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"待明确地区","currentConfirmedCount":-3,"confirmedCount":0,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":0}]},{"provinceName":"云南省","provinceShortName":"云南","currentConfirmedCount":4,"confirmedCount":178,"suspectedCount":0,"curedCount":172,"deadCount":2,"comment":"","locationId":530000,"cities":[{"cityName":"境外输入","currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"昆明","currentConfirmedCount":0,"confirmedCount":53,"suspectedCount":0,"curedCount":53,"deadCount":0,"locationId":530100},{"cityName":"昭通","currentConfirmedCount":0,"confirmedCount":25,"suspectedCount":0,"curedCount":25,"deadCount":0,"locationId":530600},{"cityName":"西双版纳","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":14,"deadCount":1,"locationId":532800},{"cityName":"玉溪","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":13,"deadCount":1,"locationId":530400},{"cityName":"曲靖","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":530300},{"cityName":"大理州","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":0},{"cityName":"红河州","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":0},{"cityName":"保山","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":530500},{"cityName":"丽江","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":530700},{"cityName":"德宏州","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":0},{"cityName":"普洱","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":530800},{"cityName":"楚雄州","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":0},{"cityName":"文山州","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":0},{"cityName":"临沧","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":530900}]},{"provinceName":"河北省","provinceShortName":"河北","currentConfirmedCount":3,"confirmedCount":319,"suspectedCount":0,"curedCount":310,"deadCount":6,"comment":"","locationId":130000,"cities":[{"cityName":"唐山","currentConfirmedCount":2,"confirmedCount":58,"suspectedCount":0,"curedCount":55,"deadCount":1,"locationId":130200},{"cityName":"境外输入","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"沧州","currentConfirmedCount":0,"confirmedCount":48,"suspectedCount":0,"curedCount":45,"deadCount":3,"locationId":130900},{"cityName":"张家口","currentConfirmedCount":0,"confirmedCount":41,"suspectedCount":0,"curedCount":41,"deadCount":0,"locationId":130700},{"cityName":"保定","currentConfirmedCount":0,"confirmedCount":32,"suspectedCount":0,"curedCount":32,"deadCount":0,"locationId":130600},{"cityName":"邯郸","currentConfirmedCount":0,"confirmedCount":32,"suspectedCount":0,"curedCount":32,"deadCount":0,"locationId":130400},{"cityName":"廊坊","currentConfirmedCount":0,"confirmedCount":30,"suspectedCount":0,"curedCount":30,"deadCount":0,"locationId":131000},{"cityName":"石家庄","currentConfirmedCount":0,"confirmedCount":29,"suspectedCount":0,"curedCount":29,"deadCount":0,"locationId":130100},{"cityName":"邢台","currentConfirmedCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":22,"deadCount":1,"locationId":130500},{"cityName":"秦皇岛","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":9,"deadCount":1,"locationId":130300},{"cityName":"衡水","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":131100},{"cityName":"承德","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":130800}]},{"provinceName":"河南省","provinceShortName":"河南","currentConfirmedCount":2,"confirmedCount":1274,"suspectedCount":0,"curedCount":1250,"deadCount":22,"comment":"","locationId":410000,"cities":[{"cityName":"境外输入","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"信阳","currentConfirmedCount":0,"confirmedCount":274,"suspectedCount":0,"curedCount":272,"deadCount":2,"locationId":411500},{"cityName":"郑州","currentConfirmedCount":0,"confirmedCount":157,"suspectedCount":0,"curedCount":152,"deadCount":5,"locationId":410100},{"cityName":"南阳","currentConfirmedCount":0,"confirmedCount":156,"suspectedCount":0,"curedCount":153,"deadCount":3,"locationId":411300},{"cityName":"驻马店","currentConfirmedCount":0,"confirmedCount":139,"suspectedCount":0,"curedCount":139,"deadCount":0,"locationId":411700},{"cityName":"商丘","currentConfirmedCount":0,"confirmedCount":91,"suspectedCount":0,"curedCount":88,"deadCount":3,"locationId":411400},{"cityName":"周口","currentConfirmedCount":0,"confirmedCount":76,"suspectedCount":0,"curedCount":75,"deadCount":1,"locationId":411600},{"cityName":"平顶山","currentConfirmedCount":0,"confirmedCount":58,"suspectedCount":0,"curedCount":57,"deadCount":1,"locationId":410400},{"cityName":"新乡","currentConfirmedCount":0,"confirmedCount":57,"suspectedCount":0,"curedCount":54,"deadCount":3,"locationId":410700},{"cityName":"安阳","currentConfirmedCount":0,"confirmedCount":53,"suspectedCount":0,"curedCount":53,"deadCount":0,"locationId":410500},{"cityName":"许昌","currentConfirmedCount":0,"confirmedCount":39,"suspectedCount":0,"curedCount":38,"deadCount":1,"locationId":411000},{"cityName":"漯河","currentConfirmedCount":0,"confirmedCount":35,"suspectedCount":0,"curedCount":35,"deadCount":0,"locationId":411100},{"cityName":"焦作","currentConfirmedCount":0,"confirmedCount":32,"suspectedCount":0,"curedCount":31,"deadCount":1,"locationId":410800},{"cityName":"洛阳","currentConfirmedCount":0,"confirmedCount":31,"suspectedCount":0,"curedCount":30,"deadCount":1,"locationId":410300},{"cityName":"开封","currentConfirmedCount":0,"confirmedCount":26,"suspectedCount":0,"curedCount":26,"deadCount":0,"locationId":410200},{"cityName":"鹤壁","currentConfirmedCount":0,"confirmedCount":19,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":410600},{"cityName":"濮阳","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":410900},{"cityName":"三门峡","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":6,"deadCount":1,"locationId":411200},{"cityName":"济源","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":419001}]},{"provinceName":"重庆市","provinceShortName":"重庆","currentConfirmedCount":2,"confirmedCount":578,"suspectedCount":1,"curedCount":570,"deadCount":6,"comment":"","locationId":500000,"cities":[{"cityName":"境外输入","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":1,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"万州区","currentConfirmedCount":0,"confirmedCount":118,"suspectedCount":0,"curedCount":114,"deadCount":4,"locationId":500101},{"cityName":"江北区","currentConfirmedCount":0,"confirmedCount":28,"suspectedCount":0,"curedCount":28,"deadCount":0,"locationId":500105},{"cityName":"云阳县","currentConfirmedCount":0,"confirmedCount":25,"suspectedCount":0,"curedCount":25,"deadCount":0,"locationId":500235},{"cityName":"合川区","currentConfirmedCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":23,"deadCount":0,"locationId":500117},{"cityName":"綦江区","currentConfirmedCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":23,"deadCount":0,"locationId":500110},{"cityName":"长寿区","currentConfirmedCount":0,"confirmedCount":22,"suspectedCount":0,"curedCount":22,"deadCount":0,"locationId":500115},{"cityName":"奉节县","currentConfirmedCount":0,"confirmedCount":22,"suspectedCount":0,"curedCount":22,"deadCount":0,"locationId":500236},{"cityName":"九龙坡区","currentConfirmedCount":0,"confirmedCount":21,"suspectedCount":0,"curedCount":20,"deadCount":1,"locationId":500107},{"cityName":"开州区","currentConfirmedCount":0,"confirmedCount":21,"suspectedCount":0,"curedCount":20,"deadCount":1,"locationId":500154},{"cityName":"忠县","currentConfirmedCount":0,"confirmedCount":21,"suspectedCount":0,"curedCount":21,"deadCount":0,"locationId":500233},{"cityName":"渝中区","currentConfirmedCount":0,"confirmedCount":20,"suspectedCount":0,"curedCount":20,"deadCount":0,"locationId":500103},{"cityName":"垫江县","currentConfirmedCount":0,"confirmedCount":20,"suspectedCount":0,"curedCount":20,"deadCount":0,"locationId":500231},{"cityName":"潼南区","currentConfirmedCount":0,"confirmedCount":18,"suspectedCount":0,"curedCount":18,"deadCount":0,"locationId":500152},{"cityName":"渝北区","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":500112},{"cityName":"两江新区","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":-1},{"cityName":"南岸区","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":15,"deadCount":0,"locationId":500108},{"cityName":"石柱县","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":15,"deadCount":0,"locationId":500240},{"cityName":"大足区","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":500111},{"cityName":"巫溪县","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":500238},{"cityName":"铜梁区","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":500151},{"cityName":"丰都县","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":500230},{"cityName":"巫山县","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":500237},{"cityName":"沙坪坝区","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":500106},{"cityName":"璧山区","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":500120},{"cityName":"荣昌区","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":500153},{"cityName":"大渡口区","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":500104},{"cityName":"巴南区","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":500113},{"cityName":"涪陵区","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":500102},{"cityName":"永川区","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":500118},{"cityName":"江津区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":500116},{"cityName":"梁平区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":500155},{"cityName":"高新区","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":0},{"cityName":"黔江区","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500114},{"cityName":"城口县","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500229},{"cityName":"彭水县","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":500243},{"cityName":"武隆区","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":500156},{"cityName":"秀山县","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":500241},{"cityName":"酉阳县","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"万盛经开区","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0}]},{"provinceName":"黑龙江省","provinceShortName":"黑龙江","currentConfirmedCount":2,"confirmedCount":484,"suspectedCount":0,"curedCount":469,"deadCount":13,"comment":"","locationId":230000,"cities":[{"cityName":"境外输入","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"哈尔滨","currentConfirmedCount":0,"confirmedCount":198,"suspectedCount":0,"curedCount":194,"deadCount":4,"locationId":230100},{"cityName":"双鸭山","currentConfirmedCount":0,"confirmedCount":52,"suspectedCount":0,"curedCount":49,"deadCount":3,"locationId":230500},{"cityName":"绥化","currentConfirmedCount":0,"confirmedCount":47,"suspectedCount":0,"curedCount":43,"deadCount":4,"locationId":231200},{"cityName":"鸡西","currentConfirmedCount":0,"confirmedCount":46,"suspectedCount":0,"curedCount":46,"deadCount":0,"locationId":230300},{"cityName":"齐齐哈尔","currentConfirmedCount":0,"confirmedCount":43,"suspectedCount":0,"curedCount":42,"deadCount":1,"locationId":230200},{"cityName":"大庆","currentConfirmedCount":0,"confirmedCount":26,"suspectedCount":0,"curedCount":25,"deadCount":1,"locationId":230600},{"cityName":"七台河","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":230900},{"cityName":"佳木斯","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":15,"deadCount":0,"locationId":230800},{"cityName":"牡丹江","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":15,"deadCount":0,"locationId":231000},{"cityName":"黑河","currentConfirmedCount":0,"confirmedCount":14,"suspectedCount":0,"curedCount":14,"deadCount":0,"locationId":231100},{"cityName":"鹤岗","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":230400},{"cityName":"大兴安岭","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":232700},{"cityName":"伊春","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":230700}]},{"provinceName":"广西壮族自治区","provinceShortName":"广西","currentConfirmedCount":2,"confirmedCount":254,"suspectedCount":0,"curedCount":250,"deadCount":2,"comment":"","locationId":450000,"cities":[{"cityName":"境外输入","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"南宁","currentConfirmedCount":0,"confirmedCount":55,"suspectedCount":0,"curedCount":55,"deadCount":0,"locationId":450100},{"cityName":"北海","currentConfirmedCount":0,"confirmedCount":44,"suspectedCount":0,"curedCount":43,"deadCount":1,"locationId":450500},{"cityName":"桂林","currentConfirmedCount":0,"confirmedCount":32,"suspectedCount":0,"curedCount":32,"deadCount":0,"locationId":450300},{"cityName":"河池","currentConfirmedCount":0,"confirmedCount":28,"suspectedCount":0,"curedCount":27,"deadCount":1,"locationId":451200},{"cityName":"柳州","currentConfirmedCount":0,"confirmedCount":24,"suspectedCount":0,"curedCount":24,"deadCount":0,"locationId":450200},{"cityName":"防城港","currentConfirmedCount":0,"confirmedCount":19,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":450600},{"cityName":"玉林","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":450900},{"cityName":"来宾","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":451300},{"cityName":"钦州","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":450700},{"cityName":"贵港","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":450800},{"cityName":"梧州","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":450400},{"cityName":"贺州","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":451100},{"cityName":"百色","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":451000}]},{"provinceName":"山西省","provinceShortName":"山西","currentConfirmedCount":2,"confirmedCount":135,"suspectedCount":0,"curedCount":133,"deadCount":0,"comment":"","locationId":140000,"cities":[{"cityName":"境外输入","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"晋中","currentConfirmedCount":0,"confirmedCount":37,"suspectedCount":0,"curedCount":37,"deadCount":0,"locationId":140700},{"cityName":"太原","currentConfirmedCount":0,"confirmedCount":20,"suspectedCount":0,"curedCount":20,"deadCount":0,"locationId":140100},{"cityName":"运城","currentConfirmedCount":0,"confirmedCount":19,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":140800},{"cityName":"大同","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":140200},{"cityName":"晋城","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":140500},{"cityName":"长治","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":140400},{"cityName":"朔州","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":140600},{"cityName":"忻州","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":140900},{"cityName":"吕梁","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":141100},{"cityName":"阳泉","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":140300},{"cityName":"临汾","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":141000}]},{"provinceName":"吉林省","provinceShortName":"吉林","currentConfirmedCount":2,"confirmedCount":95,"suspectedCount":1,"curedCount":92,"deadCount":1,"comment":"","locationId":220000,"cities":[{"cityName":"长春","currentConfirmedCount":1,"confirmedCount":46,"suspectedCount":1,"curedCount":45,"deadCount":0,"locationId":220100},{"cityName":"梅河口","currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":220581},{"cityName":"四平市","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":14,"deadCount":1,"locationId":220300},{"cityName":"辽源","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":220400},{"cityName":"公主岭","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":220381},{"cityName":"通化","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":220500},{"cityName":"吉林市","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":220200},{"cityName":"延边","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":222400},{"cityName":"松原","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":220700},{"cityName":"白城","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":220800}]},{"provinceName":"内蒙古自治区","provinceShortName":"内蒙古","currentConfirmedCount":2,"confirmedCount":77,"suspectedCount":0,"curedCount":74,"deadCount":1,"comment":"","locationId":150000,"cities":[{"cityName":"境外输入人员","currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"鄂尔多斯","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":150600},{"cityName":"包头","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":150200},{"cityName":"赤峰","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":150400},{"cityName":"锡林郭勒盟","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":152500},{"cityName":"巴彦淖尔","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":7,"deadCount":1,"locationId":150800},{"cityName":"呼和浩特","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":150100},{"cityName":"通辽","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":150500},{"cityName":"呼伦贝尔","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":150700},{"cityName":"乌兰察布","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":150900},{"cityName":"乌海市","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":150300},{"cityName":"兴安盟","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":152200}]},{"provinceName":"江西省","provinceShortName":"江西","currentConfirmedCount":1,"confirmedCount":936,"suspectedCount":0,"curedCount":934,"deadCount":1,"comment":"","locationId":360000,"cities":[{"cityName":"境外输入","currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"locationId":0},{"cityName":"南昌","currentConfirmedCount":0,"confirmedCount":230,"suspectedCount":0,"curedCount":230,"deadCount":0,"locationId":360100},{"cityName":"新余","currentConfirmedCount":0,"confirmedCount":130,"suspectedCount":0,"curedCount":130,"deadCount":0,"locationId":360500},{"cityName":"上饶","currentConfirmedCount":0,"confirmedCount":123,"suspectedCount":0,"curedCount":123,"deadCount":0,"locationId":361100},{"cityName":"九江","currentConfirmedCount":0,"confirmedCount":118,"suspectedCount":0,"curedCount":118,"deadCount":0,"locationId":360400},{"cityName":"宜春","currentConfirmedCount":0,"confirmedCount":106,"suspectedCount":0,"curedCount":106,"deadCount":0,"locationId":360900},{"cityName":"赣州","currentConfirmedCount":0,"confirmedCount":76,"suspectedCount":0,"curedCount":75,"deadCount":1,"locationId":360700},{"cityName":"抚州","currentConfirmedCount":0,"confirmedCount":72,"suspectedCount":0,"curedCount":72,"deadCount":0,"locationId":361000},{"cityName":"萍乡","currentConfirmedCount":0,"confirmedCount":33,"suspectedCount":0,"curedCount":33,"deadCount":0,"locationId":360300},{"cityName":"吉安","currentConfirmedCount":0,"confirmedCount":22,"suspectedCount":0,"curedCount":22,"deadCount":0,"locationId":360800},{"cityName":"鹰潭","currentConfirmedCount":0,"confirmedCount":18,"suspectedCount":0,"curedCount":18,"deadCount":0,"locationId":360600},{"cityName":"景德镇","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":360200},{"cityName":"赣江新区","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0}]},{"provinceName":"辽宁省","provinceShortName":"辽宁","currentConfirmedCount":1,"confirmedCount":127,"suspectedCount":0,"curedCount":124,"deadCount":2,"comment":"","locationId":210000,"cities":[{"cityName":"境外输入","currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"沈阳","currentConfirmedCount":0,"confirmedCount":28,"suspectedCount":0,"curedCount":28,"deadCount":0,"locationId":210100},{"cityName":"大连","currentConfirmedCount":0,"confirmedCount":19,"suspectedCount":0,"curedCount":19,"deadCount":0,"locationId":210200},{"cityName":"锦州","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":12,"deadCount":0,"locationId":210700},{"cityName":"葫芦岛","currentConfirmedCount":0,"confirmedCount":12,"suspectedCount":0,"curedCount":11,"deadCount":1,"locationId":211400},{"cityName":"丹东","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":210600},{"cityName":"盘锦","currentConfirmedCount":0,"confirmedCount":11,"suspectedCount":0,"curedCount":11,"deadCount":0,"locationId":211100},{"cityName":"阜新","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":210900},{"cityName":"铁岭","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":211200},{"cityName":"朝阳","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":5,"deadCount":1,"locationId":211300},{"cityName":"鞍山","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":210300},{"cityName":"本溪","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":210500},{"cityName":"辽阳","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":211000},{"cityName":"营口","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":210800}]},{"provinceName":"湖南省","provinceShortName":"湖南","currentConfirmedCount":0,"confirmedCount":1018,"suspectedCount":0,"curedCount":1014,"deadCount":4,"comment":"","locationId":430000,"cities":[{"cityName":"长沙","currentConfirmedCount":0,"confirmedCount":242,"suspectedCount":0,"curedCount":240,"deadCount":2,"locationId":430100},{"cityName":"岳阳","currentConfirmedCount":0,"confirmedCount":156,"suspectedCount":0,"curedCount":155,"deadCount":1,"locationId":430600},{"cityName":"邵阳","currentConfirmedCount":0,"confirmedCount":102,"suspectedCount":0,"curedCount":101,"deadCount":1,"locationId":430500},{"cityName":"常德","currentConfirmedCount":0,"confirmedCount":82,"suspectedCount":0,"curedCount":82,"deadCount":0,"locationId":430700},{"cityName":"株洲","currentConfirmedCount":0,"confirmedCount":80,"suspectedCount":0,"curedCount":80,"deadCount":0,"locationId":430200},{"cityName":"娄底","currentConfirmedCount":0,"confirmedCount":76,"suspectedCount":0,"curedCount":76,"deadCount":0,"locationId":431300},{"cityName":"益阳","currentConfirmedCount":0,"confirmedCount":60,"suspectedCount":0,"curedCount":60,"deadCount":0,"locationId":430900},{"cityName":"衡阳","currentConfirmedCount":0,"confirmedCount":48,"suspectedCount":0,"curedCount":48,"deadCount":0,"locationId":430400},{"cityName":"永州","currentConfirmedCount":0,"confirmedCount":44,"suspectedCount":0,"curedCount":44,"deadCount":0,"locationId":431100},{"cityName":"怀化","currentConfirmedCount":0,"confirmedCount":40,"suspectedCount":0,"curedCount":40,"deadCount":0,"locationId":431200},{"cityName":"郴州","currentConfirmedCount":0,"confirmedCount":39,"suspectedCount":0,"curedCount":39,"deadCount":0,"locationId":431000},{"cityName":"湘潭","currentConfirmedCount":0,"confirmedCount":36,"suspectedCount":0,"curedCount":36,"deadCount":0,"locationId":430300},{"cityName":"湘西自治州","currentConfirmedCount":0,"confirmedCount":8,"suspectedCount":0,"curedCount":8,"deadCount":0,"locationId":433100},{"cityName":"张家界","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":430800}]},{"provinceName":"安徽省","provinceShortName":"安徽","currentConfirmedCount":0,"confirmedCount":990,"suspectedCount":0,"curedCount":984,"deadCount":6,"comment":"","locationId":340000,"cities":[{"cityName":"合肥","currentConfirmedCount":0,"confirmedCount":174,"suspectedCount":0,"curedCount":173,"deadCount":1,"locationId":340100},{"cityName":"蚌埠","currentConfirmedCount":0,"confirmedCount":160,"suspectedCount":0,"curedCount":155,"deadCount":5,"locationId":340300},{"cityName":"阜阳","currentConfirmedCount":0,"confirmedCount":155,"suspectedCount":0,"curedCount":155,"deadCount":0,"locationId":341200},{"cityName":"亳州","currentConfirmedCount":0,"confirmedCount":108,"suspectedCount":0,"curedCount":108,"deadCount":0,"locationId":341600},{"cityName":"安庆","currentConfirmedCount":0,"confirmedCount":83,"suspectedCount":0,"curedCount":83,"deadCount":0,"locationId":340800},{"cityName":"六安","currentConfirmedCount":0,"confirmedCount":69,"suspectedCount":0,"curedCount":69,"deadCount":0,"locationId":341500},{"cityName":"宿州","currentConfirmedCount":0,"confirmedCount":41,"suspectedCount":0,"curedCount":41,"deadCount":0,"locationId":341300},{"cityName":"马鞍山","currentConfirmedCount":0,"confirmedCount":38,"suspectedCount":0,"curedCount":38,"deadCount":0,"locationId":340500},{"cityName":"芜湖","currentConfirmedCount":0,"confirmedCount":34,"suspectedCount":0,"curedCount":34,"deadCount":0,"locationId":340200},{"cityName":"铜陵","currentConfirmedCount":0,"confirmedCount":29,"suspectedCount":0,"curedCount":29,"deadCount":0,"locationId":340700},{"cityName":"淮北","currentConfirmedCount":0,"confirmedCount":27,"suspectedCount":0,"curedCount":27,"deadCount":0,"locationId":340600},{"cityName":"淮南","currentConfirmedCount":0,"confirmedCount":27,"suspectedCount":0,"curedCount":27,"deadCount":0,"locationId":340400},{"cityName":"池州","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":341700},{"cityName":"滁州","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":341100},{"cityName":"黄山","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":9,"deadCount":0,"locationId":341000},{"cityName":"宣城","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":341800}]},{"provinceName":"海南省","provinceShortName":"海南","currentConfirmedCount":0,"confirmedCount":168,"suspectedCount":0,"curedCount":162,"deadCount":6,"comment":"","locationId":460000,"cities":[{"cityName":"三亚","currentConfirmedCount":0,"confirmedCount":54,"suspectedCount":0,"curedCount":53,"deadCount":1,"locationId":460200},{"cityName":"海口","currentConfirmedCount":0,"confirmedCount":39,"suspectedCount":0,"curedCount":39,"deadCount":0,"locationId":460100},{"cityName":"儋州","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":14,"deadCount":1,"locationId":460400},{"cityName":"万宁","currentConfirmedCount":0,"confirmedCount":13,"suspectedCount":0,"curedCount":13,"deadCount":0,"locationId":469006},{"cityName":"澄迈","currentConfirmedCount":0,"confirmedCount":9,"suspectedCount":0,"curedCount":8,"deadCount":1,"locationId":469023},{"cityName":"昌江","currentConfirmedCount":0,"confirmedCount":7,"suspectedCount":0,"curedCount":7,"deadCount":0,"locationId":469026},{"cityName":"琼海","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":5,"deadCount":1,"locationId":469002},{"cityName":"临高","currentConfirmedCount":0,"confirmedCount":6,"suspectedCount":0,"curedCount":6,"deadCount":0,"locationId":469024},{"cityName":"陵水","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":469028},{"cityName":"定安","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":1,"locationId":469021},{"cityName":"文昌","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":469005},{"cityName":"东方","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":2,"deadCount":1,"locationId":469007},{"cityName":"保亭","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":469029},{"cityName":"乐东","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":469027},{"cityName":"琼中","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":469030}]},{"provinceName":"贵州省","provinceShortName":"贵州","currentConfirmedCount":0,"confirmedCount":146,"suspectedCount":0,"curedCount":144,"deadCount":2,"comment":"3 月 17 日贵阳市新增 1 例境外输入无症状感染者","locationId":520000,"cities":[{"cityName":"贵阳","currentConfirmedCount":0,"confirmedCount":36,"suspectedCount":0,"curedCount":35,"deadCount":1,"locationId":520100},{"cityName":"遵义","currentConfirmedCount":0,"confirmedCount":32,"suspectedCount":0,"curedCount":32,"deadCount":0,"locationId":520300},{"cityName":"毕节","currentConfirmedCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":23,"deadCount":0,"locationId":520500},{"cityName":"黔南州","currentConfirmedCount":0,"confirmedCount":17,"suspectedCount":0,"curedCount":17,"deadCount":0,"locationId":522700},{"cityName":"六盘水","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":9,"deadCount":1,"locationId":520200},{"cityName":"铜仁","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":520600},{"cityName":"黔东南州","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":10,"deadCount":0,"locationId":522600},{"cityName":"安顺","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":520400},{"cityName":"黔西南州","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":522300}]},{"provinceName":"新疆维吾尔自治区","provinceShortName":"新疆","currentConfirmedCount":0,"confirmedCount":76,"suspectedCount":0,"curedCount":73,"deadCount":3,"comment":"","locationId":650000,"cities":[{"cityName":"乌鲁木齐","currentConfirmedCount":0,"confirmedCount":23,"suspectedCount":0,"curedCount":23,"deadCount":0,"locationId":650100},{"cityName":"伊犁州","currentConfirmedCount":0,"confirmedCount":18,"suspectedCount":0,"curedCount":18,"deadCount":0,"locationId":654000},{"cityName":"兵团第四师","currentConfirmedCount":0,"confirmedCount":10,"suspectedCount":0,"curedCount":9,"deadCount":1,"locationId":0},{"cityName":"兵团第八师石河子市","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":3,"deadCount":1,"locationId":0},{"cityName":"兵团第九师","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":3,"deadCount":1,"locationId":0},{"cityName":"昌吉州","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":0},{"cityName":"吐鲁番市","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":650400},{"cityName":"巴州","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":511902},{"cityName":"兵团第十二师","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":0},{"cityName":"兵团第六师五家渠市","currentConfirmedCount":0,"confirmedCount":2,"suspectedCount":0,"curedCount":2,"deadCount":0,"locationId":0},{"cityName":"兵团第七师","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"阿克苏地区","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":652900}]},{"provinceName":"宁夏回族自治区","provinceShortName":"宁夏","currentConfirmedCount":0,"confirmedCount":75,"suspectedCount":0,"curedCount":75,"deadCount":0,"comment":"","locationId":640000,"cities":[{"cityName":"银川","currentConfirmedCount":0,"confirmedCount":36,"suspectedCount":0,"curedCount":36,"deadCount":0,"locationId":640100},{"cityName":"吴忠","currentConfirmedCount":0,"confirmedCount":28,"suspectedCount":0,"curedCount":28,"deadCount":0,"locationId":640300},{"cityName":"固原","currentConfirmedCount":0,"confirmedCount":5,"suspectedCount":0,"curedCount":5,"deadCount":0,"locationId":640400},{"cityName":"中卫","currentConfirmedCount":0,"confirmedCount":4,"suspectedCount":0,"curedCount":4,"deadCount":0,"locationId":640500},{"cityName":"宁东","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":0},{"cityName":"石嘴山","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":640200}]},{"provinceName":"青海省","provinceShortName":"青海","currentConfirmedCount":0,"confirmedCount":18,"suspectedCount":0,"curedCount":18,"deadCount":0,"comment":"","locationId":630000,"cities":[{"cityName":"西宁","currentConfirmedCount":0,"confirmedCount":15,"suspectedCount":0,"curedCount":15,"deadCount":0,"locationId":630100},{"cityName":"海北州","currentConfirmedCount":0,"confirmedCount":3,"suspectedCount":0,"curedCount":3,"deadCount":0,"locationId":632200}]},{"provinceName":"西藏自治区","provinceShortName":"西藏","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","locationId":540000,"cities":[{"cityName":"拉萨","currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"locationId":540100}]}]
/// continents : [{"continentName":"欧洲","currentConfirmedCount":42047,"deadCount":1809,"confirmedCount":46485,"suspectedCount":0,"curedCount":2629,"country":[{"id":1085963,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":17750,"confirmedCount":21157,"suspectedCount":0,"curedCount":1966,"deadCount":1441,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965008,"countryShortCode":"ITA","countryFullName":"Italy","statisticsData":"https://file1.dxycdn.com/2020/0315/993/3402160517102843054-135.json","countryName":"意大利","countryId":"10"},{"id":1085965,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":5627,"confirmedCount":6393,"suspectedCount":0,"curedCount":571,"deadCount":195,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965015,"countryShortCode":"ESP","countryFullName":"Spain","statisticsData":"https://file1.dxycdn.com/2020/0315/812/3402160512807875660-135.json","countryName":"西班牙","countryId":"10"},{"id":1085957,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":4843,"confirmedCount":4866,"suspectedCount":0,"curedCount":14,"deadCount":9,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963003,"countryShortCode":"DEU","countryFullName":"Germany","statisticsData":"https://file1.dxycdn.com/2020/0315/631/3402160538577680475-135.json","countryName":"德国","countryId":"10"},{"id":1085948,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":4373,"confirmedCount":4500,"suspectedCount":0,"curedCount":36,"deadCount":91,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961002,"countryShortCode":"FRA","countryFullName":"France","statisticsData":"https://file1.dxycdn.com/2020/0315/929/3402160538577857318-135.json","countryName":"法国","countryId":"5"},{"id":1086002,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1175,"confirmedCount":1189,"suspectedCount":0,"curedCount":3,"deadCount":11,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963008,"countryShortCode":"CHE","countryFullName":"Switzerland","statisticsData":"https://file1.dxycdn.com/2020/0315/786/3402160525692954837-135.json","countryName":"瑞士","countryId":"10"},{"id":1086057,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1101,"confirmedCount":1140,"suspectedCount":0,"curedCount":18,"deadCount":21,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961007,"countryShortCode":"GBR","countryFullName":"The United Kingdom","statisticsData":"https://file1.dxycdn.com/2020/0315/364/3402160538577680395-135.json","countryName":"英国","countryId":"10"},{"id":1086011,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1043,"confirmedCount":1046,"suspectedCount":0,"curedCount":0,"deadCount":3,"comment":"","sort":0,"operator":"wangjinyuan","locationId":962004,"countryShortCode":"NOR","countryFullName":"Norway","statisticsData":"https://file1.dxycdn.com/2020/0315/616/3402160534282889764-135.json","countryName":"挪威","countryId":"10"},{"id":1085966,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":953,"confirmedCount":961,"suspectedCount":0,"curedCount":0,"deadCount":8,"comment":"","sort":0,"operator":"wangjinyuan","locationId":962005,"countryShortCode":"SWE","countryFullName":"Sweden","statisticsData":"https://file1.dxycdn.com/2020/0315/516/3402160512807875646-135.json","countryName":"瑞典","countryId":"10"},{"id":1086013,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":947,"confirmedCount":959,"suspectedCount":0,"curedCount":0,"deadCount":12,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961006,"countryShortCode":"NLD","countryFullName":"Netherlands","statisticsData":"https://file1.dxycdn.com/2020/0315/850/3402160510660568773-135.json","countryName":"荷兰","countryId":"10"},{"id":1086010,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":826,"confirmedCount":827,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":962001,"countryShortCode":"DNK","countryFullName":"Denmark","statisticsData":"https://file1.dxycdn.com/2020/0315/831/3402160489185731552-135.json","countryName":"丹麦","countryId":"10"},{"id":1085978,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":685,"confirmedCount":689,"suspectedCount":0,"curedCount":1,"deadCount":3,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961001,"countryShortCode":"BEL","countryFullName":"Belgium","statisticsData":"https://file1.dxycdn.com/2020/0315/838/3402160514955359353-135.json","countryName":"比利时","countryId":"10"},{"id":1086004,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":648,"confirmedCount":655,"suspectedCount":0,"curedCount":6,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963001,"countryShortCode":"AUT","countryFullName":"Austria","statisticsData":"https://file1.dxycdn.com/2020/0315/012/3402160532135229192-135.json","countryName":"奥地利","countryId":"10"},{"id":1086005,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":225,"confirmedCount":228,"suspectedCount":0,"curedCount":0,"deadCount":3,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965007,"countryShortCode":"GRC","countryFullName":"Greece","statisticsData":"https://file1.dxycdn.com/2020/0315/800/3402160534282889817-135.json","countryName":"希腊","countryId":"10"},{"id":1085961,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":223,"confirmedCount":224,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":962002,"countryShortCode":"FIN","countryFullName":"Finland","statisticsData":"https://file1.dxycdn.com/2020/0315/473/3402160538577857276-135.json","countryName":"芬兰","countryId":"10"},{"id":1086064,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":189,"confirmedCount":189,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963002,"countryShortCode":"CZE","countryFullName":"Czechia","statisticsData":"https://file1.dxycdn.com/2020/0315/497/3402160532135229255-135.json","countryName":"捷克","countryId":"10"},{"id":1086205,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":181,"confirmedCount":181,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965014,"countryShortCode":"SVN","countryFullName":"Slovenia","statisticsData":"https://file1.dxycdn.com/2020/0315/527/3402160510660391945-135.json","countryName":"斯洛文尼亚","countryId":"10"},{"id":1086020,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":156,"confirmedCount":156,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":962003,"countryShortCode":"ISL","countryFullName":"Iceland","statisticsData":"https://file1.dxycdn.com/2020/0315/786/3402160514955359317-135.json","countryName":"冰岛","countryId":"10"},{"id":1086059,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":128,"confirmedCount":129,"suspectedCount":0,"curedCount":0,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961003,"countryShortCode":"IRL","countryFullName":"Ireland","statisticsData":"https://file1.dxycdn.com/2020/0315/153/3402160510660568721-135.json","countryName":"爱尔兰","countryId":"10"},{"id":1086111,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":112,"confirmedCount":112,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965010,"countryShortCode":"PRT","countryFullName":"Portugal","statisticsData":"https://file1.dxycdn.com/2020/0315/256/3402160527840261777-135.json","countryName":"葡萄牙","countryId":"10"},{"id":1086009,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":109,"confirmedCount":109,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964002,"countryShortCode":"EST","countryFullName":"Estonia","statisticsData":"https://file1.dxycdn.com/2020/0315/704/3402160514955359338-135.json","countryName":"爱沙尼亚","countryId":"10"},{"id":1086203,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":101,"confirmedCount":104,"suspectedCount":0,"curedCount":0,"deadCount":3,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963006,"countryShortCode":"POL","countryFullName":"Poland","statisticsData":"https://file1.dxycdn.com/2020/0315/811/3402160506365424422-135.json","countryName":"波兰","countryId":"10"},{"id":1086008,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":98,"confirmedCount":101,"suspectedCount":0,"curedCount":3,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965011,"countryShortCode":"ROU","countryFullName":"Romania","statisticsData":"https://file1.dxycdn.com/2020/0315/131/3402160534282712963-135.json","countryName":"罗马尼亚","countryId":"10"},{"id":1086062,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":66,"confirmedCount":73,"suspectedCount":0,"curedCount":2,"deadCount":5,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965012,"countryShortCode":"SMR","countryFullName":"San Marino","statisticsData":"https://file1.dxycdn.com/2020/0315/846/3402160508513085010-135.json","countryName":"圣马力诺","countryId":"10"},{"id":1085964,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":56,"confirmedCount":59,"suspectedCount":0,"curedCount":3,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964006,"countryShortCode":"RUS","countryFullName":"Russian Federation","statisticsData":"https://file1.dxycdn.com/2020/0315/629/3402160517102843039-135.json","countryName":"俄罗斯","countryId":"10"},{"id":1086060,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":50,"confirmedCount":51,"suspectedCount":0,"curedCount":0,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961004,"countryShortCode":"LUX","countryFullName":"Luxembourg","statisticsData":"https://file1.dxycdn.com/2020/0315/943/3402160538577857289-135.json","countryName":"卢森堡","countryId":"10"},{"id":1086222,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":46,"confirmedCount":46,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965013,"countryShortCode":"SRB","countryFullName":"Serbia","statisticsData":"https://file1.dxycdn.com/2020/0315/316/3402160534282712994-135.json","countryName":"塞尔维亚","countryId":"10"},{"id":1086230,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":44,"confirmedCount":44,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963007,"countryShortCode":"SVK","countryFullName":"Slovakia","statisticsData":"https://file1.dxycdn.com/2020/0315/353/3402160510660391916-135.json","countryName":"斯洛伐克","countryId":"10"},{"id":1086001,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":37,"confirmedCount":37,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965005,"countryShortCode":"HRV","countryFullName":"Croatia","statisticsData":"https://file1.dxycdn.com/2020/0315/154/3402160527840438555-135.json","countryName":"克罗地亚","countryId":"10"},{"id":1086236,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":37,"confirmedCount":38,"suspectedCount":0,"curedCount":0,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965001,"countryShortCode":"ALB","countryFullName":"Albania","statisticsData":"https://file1.dxycdn.com/2020/0315/852/3402160525692954728-135.json","countryName":"阿尔巴尼亚","countryId":"10"},{"id":1086233,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":36,"confirmedCount":36,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965004,"countryShortCode":"BGR","countryFullName":"Bulgaria","statisticsData":"https://file1.dxycdn.com/2020/0315/249/3402160532135229245-135.json","countryName":"保加利亚","countryId":"10"},{"id":1086067,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":30,"confirmedCount":30,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955006,"countryShortCode":"GEO","countryFullName":"Georgia","statisticsData":"https://file1.dxycdn.com/2020/0315/126/3402160506365424445-135.json","countryName":"格鲁吉亚","countryId":"10"},{"id":1086204,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":29,"confirmedCount":30,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963004,"countryShortCode":"HUN","countryFullName":"Hungary","statisticsData":"https://file1.dxycdn.com/2020/0315/954/3402160538577857255-135.json","countryName":"匈牙利","countryId":"10"},{"id":1086152,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":26,"confirmedCount":26,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964003,"countryShortCode":"LVA","countryFullName":"Latvia","statisticsData":"https://file1.dxycdn.com/2020/0315/786/3402160540725164137-135.json","countryName":"拉脱维亚","countryId":"10"},{"id":1086206,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":21,"confirmedCount":21,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965003,"countryShortCode":"BIH","countryFullName":"Bosnia and Herzegovina","statisticsData":"https://file1.dxycdn.com/2020/0315/908/3402160538577857266-135.json","countryName":"波黑","countryId":"10"},{"id":1086231,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":18,"confirmedCount":18,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965019,"countryShortCode":"MLT","countryFullName":"Malta","statisticsData":"https://file1.dxycdn.com/2020/0315/267/3402160529987922302-135.json","countryName":"马耳他","countryId":"10"},{"id":1086012,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":13,"confirmedCount":13,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"MKD","countryFullName":"North Macedonia","statisticsData":"https://file1.dxycdn.com/2020/0315/506/3402160514955536186-135.json","countryName":"北马其顿","countryId":"10"},{"id":1086234,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":12,"confirmedCount":12,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964005,"countryShortCode":"MDA","countryFullName":"Republic of Moldova","statisticsData":"https://file1.dxycdn.com/2020/0315/234/3402160527840438516-135.json","countryName":"摩尔多瓦","countryId":"10"},{"id":1086017,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":10,"confirmedCount":12,"suspectedCount":0,"curedCount":2,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964001,"countryShortCode":"BLR","countryFullName":"Belarus","statisticsData":"https://file1.dxycdn.com/2020/0315/436/3402160510660391933-135.json","countryName":"白俄罗斯","countryId":"10"},{"id":1086015,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":8,"confirmedCount":8,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964004,"countryShortCode":"LTU","countryFullName":"Lithuania","statisticsData":"https://file1.dxycdn.com/2020/0315/774/3402160536430196722-135.json","countryName":"立陶宛","countryId":"10"},{"id":1086036,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":961005,"countryShortCode":"MCO","countryFullName":"Monaco","statisticsData":"https://file1.dxycdn.com/2020/0315/266/3402160525692954743-135.json","countryName":"摩纳哥","countryId":"10"},{"id":1086107,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":964007,"countryShortCode":"UKR","countryFullName":"Ukraine","statisticsData":"https://file1.dxycdn.com/2020/0315/280/3402160525692954803-135.json","countryName":"乌克兰","countryId":"10"},{"id":1086495,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"FO","countryFullName":"Faroe Islands","statisticsData":"https://file1.dxycdn.com/2020/0315/071/3402160536430196701-135.json","countryName":"法罗群岛","countryId":"10"},{"id":1086508,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"Jersey","countryFullName":"","statisticsData":"https://file1.dxycdn.com/2020/0315/207/3402160529987922326-135.json","countryName":"泽西岛","countryId":"10"},{"id":1086068,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":2,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965002,"countryShortCode":"AND","countryFullName":"Andorra","statisticsData":"https://file1.dxycdn.com/2020/0315/231/3402160534282712957-135.json","countryName":"安道尔","countryId":"10"},{"id":1086140,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":963005,"countryShortCode":"LIE","countryFullName":"Liechtenstein","statisticsData":"https://file1.dxycdn.com/2020/0315/312/3402160514955359362-135.json","countryName":"列支敦士登","countryId":"10"},{"id":1086220,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":965017,"countryShortCode":"VAT","countryFullName":"Holy See","statisticsData":"https://file1.dxycdn.com/2020/0315/719/3402160489185554691-135.json","countryName":"梵蒂冈","countryId":"10"},{"id":1086496,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"CIB","countryFullName":"Gibraltar","statisticsData":"https://file1.dxycdn.com/2020/0315/482/3402160529987745496-135.json","countryName":"直布罗陀","countryId":"10"},{"id":1086497,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"Guernsey","countryFullName":"","statisticsData":"https://file1.dxycdn.com/2020/0315/950/3402160517102843046-135.json","countryName":"根西岛","countryId":"10"}]},{"continentName":"亚洲","currentConfirmedCount":28583,"deadCount":3936,"confirmedCount":105173,"suspectedCount":0,"curedCount":72654,"country":[{"countryType":2,"currentConfirmedCount":10826,"confirmedCount":81054,"suspectedCount":0,"curedCount":67024,"deadCount":3204,"locationId":951001,"countryShortCode":"CHN","countryFullName":"China","statisticsData":"https://file1.dxycdn.com/2020/0315/383/3402160527840261656-135.json","countryName":"中国","countryId":"999"},{"id":1085993,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":7779,"confirmedCount":12729,"suspectedCount":0,"curedCount":4339,"deadCount":611,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955007,"countryShortCode":"IRN","countryFullName":"Iran (Islamic Republic of)","statisticsData":"https://file1.dxycdn.com/2020/0315/596/3402160510660568739-135.json","countryName":"伊朗","countryId":"10"},{"id":1085950,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":7253,"confirmedCount":8162,"suspectedCount":0,"curedCount":834,"deadCount":75,"comment":"","sort":0,"operator":"wangjinyuan","locationId":951004,"countryShortCode":"KOR","countryFullName":"Republic of Korea","statisticsData":"https://file1.dxycdn.com/2020/0315/779/3402160514955536234-135.json","countryName":"韩国","countryId":"7"},{"id":1085949,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":630,"confirmedCount":787,"suspectedCount":0,"curedCount":135,"deadCount":22,"comment":"","sort":0,"operator":"wangjinyuan","locationId":951002,"countryShortCode":"JPN","countryFullName":"Japan","statisticsData":"https://file1.dxycdn.com/2020/0315/220/3402160536430373556-135.json","countryName":"日本","countryId":"6"},{"id":1086058,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":338,"confirmedCount":338,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955015,"countryShortCode":"QAT","countryFullName":"Qatar","statisticsData":"https://file1.dxycdn.com/2020/0315/741/3402160510660391882-135.json","countryName":"卡塔尔","countryId":"10"},{"id":1085947,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":206,"confirmedCount":238,"suspectedCount":0,"curedCount":32,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952007,"countryShortCode":"MYS","countryFullName":"Malaysia","statisticsData":"https://file1.dxycdn.com/2020/0315/777/3402160506365601260-135.json","countryName":"马来西亚","countryId":"4"},{"id":1085994,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":193,"confirmedCount":195,"suspectedCount":0,"curedCount":2,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955009,"countryShortCode":"ISR","countryFullName":"Israel","statisticsData":"https://file1.dxycdn.com/2020/0315/982/3402160514955536220-135.json","countryName":"以色列","countryId":"10"},{"id":1085998,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":151,"confirmedCount":211,"suspectedCount":0,"curedCount":60,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955004,"countryShortCode":"BHR","countryFullName":"Bahrain","statisticsData":"https://file1.dxycdn.com/2020/0315/852/3402160536430196734-135.json","countryName":"巴林","countryId":"10"},{"id":1086066,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":113,"confirmedCount":117,"suspectedCount":0,"curedCount":2,"deadCount":2,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952005,"countryShortCode":"IDN","countryFullName":"Indonesia","statisticsData":"https://file1.dxycdn.com/2020/0315/308/3402160527840438594-135.json","countryName":"印度尼西亚","countryId":"10"},{"id":1085946,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":107,"confirmedCount":212,"suspectedCount":0,"curedCount":105,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952009,"countryShortCode":"SGP","countryFullName":"Singapore","statisticsData":"https://file1.dxycdn.com/2020/0315/901/3402160525692777969-135.json","countryName":"新加坡","countryId":"3"},{"id":1085967,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":104,"confirmedCount":111,"suspectedCount":0,"curedCount":1,"deadCount":6,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952008,"countryShortCode":"PHL","countryFullName":"Philippines","statisticsData":"https://file1.dxycdn.com/2020/0315/180/3402160512807875628-135.json","countryName":"菲律宾","countryId":"10"},{"id":1085962,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":102,"confirmedCount":107,"suspectedCount":0,"curedCount":3,"deadCount":2,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953003,"countryShortCode":"IND","countryFullName":"India","statisticsData":"https://file1.dxycdn.com/2020/0315/045/3402160534282889835-135.json","countryName":"印度","countryId":"10"},{"id":1086069,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":102,"confirmedCount":103,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955016,"countryShortCode":"SAU","countryFullName":"Saudi Arabia","statisticsData":"https://file1.dxycdn.com/2020/0315/830/3402160536430373532-135.json","countryName":"沙特阿拉伯","countryId":"10"},{"id":1085997,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":100,"confirmedCount":100,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955011,"countryShortCode":"KWT","countryFullName":"Kuwait","statisticsData":"https://file1.dxycdn.com/2020/0315/529/3402160514955359370-135.json","countryName":"科威特","countryId":"10"},{"id":1085995,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":89,"confirmedCount":93,"suspectedCount":0,"curedCount":1,"deadCount":3,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955012,"countryShortCode":"LBN","countryFullName":"Lebanon","statisticsData":"https://file1.dxycdn.com/2020/0315/735/3402160529987745467-135.json","countryName":"黎巴嫩","countryId":"10"},{"id":1085945,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":78,"confirmedCount":114,"suspectedCount":0,"curedCount":35,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952010,"countryShortCode":"THA","countryFullName":"Thailand","statisticsData":"https://file1.dxycdn.com/2020/0315/926/3402160512808052473-135.json","countryName":"泰国","countryId":"2"},{"id":1085996,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":77,"confirmedCount":110,"suspectedCount":0,"curedCount":24,"deadCount":9,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955008,"countryShortCode":"IRQ","countryFullName":"Iraq","statisticsData":"https://file1.dxycdn.com/2020/0315/762/3402160510660568794-135.json","countryName":"伊拉克","countryId":"10"},{"id":1085960,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":65,"confirmedCount":85,"suspectedCount":0,"curedCount":20,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955019,"countryShortCode":"ARE","countryFullName":"United Arab Emirates","statisticsData":"https://file1.dxycdn.com/2020/0315/584/3402160508513084973-135.json","countryName":"阿联酋","countryId":"10"},{"id":1086320,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":40,"confirmedCount":40,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952002,"countryShortCode":"BRN","countryFullName":"Brunei Darussalam","statisticsData":"https://file1.dxycdn.com/2020/0315/199/3402160540725164222-135.json","countryName":"文莱","countryId":"10"},{"id":1085952,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":37,"confirmedCount":53,"suspectedCount":0,"curedCount":16,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952011,"countryShortCode":"VNM","countryFullName":"Vietnam","statisticsData":"https://file1.dxycdn.com/2020/0315/607/3402160529987745446-135.json","countryName":"越南","countryId":"9"},{"id":1086218,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":35,"confirmedCount":35,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955014,"countryShortCode":"PSE","countryFullName":"occupied Palestinian territory","statisticsData":"https://file1.dxycdn.com/2020/0315/967/3402160532135229211-135.json","countryName":"巴勒斯坦","countryId":"10"},{"id":1086006,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":33,"confirmedCount":34,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953006,"countryShortCode":"PAK","countryFullName":"Pakistan","statisticsData":"https://file1.dxycdn.com/2020/0315/432/3402160525692777910-135.json","countryName":"巴基斯坦","countryId":"10"},{"id":1086237,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":21,"confirmedCount":21,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955005,"countryShortCode":"CYP","countryFullName":"Cyprus","statisticsData":"https://file1.dxycdn.com/2020/0315/686/3402160529987745486-135.json","countryName":"塞浦路斯","countryId":"10"},{"id":1086063,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":20,"confirmedCount":20,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955002,"countryShortCode":"ARM","countryFullName":"Armenia","statisticsData":"https://file1.dxycdn.com/2020/0315/583/3402160508513085016-135.json","countryName":"亚美尼亚","countryId":"10"},{"id":1085999,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":16,"confirmedCount":16,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955001,"countryShortCode":"AFG","countryFullName":"Afghanistan","statisticsData":"https://file1.dxycdn.com/2020/0315/904/3402160536430373521-135.json","countryName":"阿富汗","countryId":"10"},{"id":1086018,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":12,"confirmedCount":19,"suspectedCount":0,"curedCount":6,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955003,"countryShortCode":"AZE","countryFullName":"Azerbaijan","statisticsData":"https://file1.dxycdn.com/2020/0315/304/3402160506365424432-135.json","countryName":"阿塞拜疆","countryId":"10"},{"id":1086000,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":11,"confirmedCount":20,"suspectedCount":0,"curedCount":9,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955013,"countryShortCode":"OMN","countryFullName":"Oman","statisticsData":"https://file1.dxycdn.com/2020/0315/945/3402160506365601313-135.json","countryName":"阿曼","countryId":"10"},{"id":1086229,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":11,"confirmedCount":11,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953004,"countryShortCode":"MDV","countryFullName":"Maldives","statisticsData":"https://file1.dxycdn.com/2020/0315/023/3402160529987922354-135.json","countryName":"马尔代夫","countryId":"10"},{"id":1085958,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":10,"confirmedCount":11,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953007,"countryShortCode":"LKA","countryFullName":"Sri Lanka","statisticsData":"https://file1.dxycdn.com/2020/0315/984/3402160532135406053-135.json","countryName":"斯里兰卡","countryId":"10"},{"id":1086396,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":6,"confirmedCount":6,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955018,"countryShortCode":"TUR","countryFullName":"Turkey","statisticsData":"https://file1.dxycdn.com/2020/0315/952/3402160538577680436-135.json","countryName":"土耳其","countryId":"10"},{"id":1086500,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":6,"confirmedCount":6,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":954001,"countryShortCode":"KAZ","countryFullName":"Kazakhstan","countryName":"哈萨克斯坦","countryId":"10"},{"id":1085956,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":4,"confirmedCount":5,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":952003,"countryShortCode":"KHM","countryFullName":"Cambodia","statisticsData":"https://file1.dxycdn.com/2020/0315/664/3402160527840261727-135.json","countryName":"柬埔寨","countryId":"10"},{"id":1086319,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953001,"countryShortCode":"BGD","countryFullName":"Bangladesh","statisticsData":"https://file1.dxycdn.com/2020/0315/485/3402160532135406028-135.json","countryName":"孟加拉国","countryId":"10"},{"id":1086507,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"REU","countryFullName":"Réunion","statisticsData":"https://file1.dxycdn.com/2020/0315/016/3402160527840261639-135.json","countryName":"留尼汪","countryId":"10"},{"id":1086219,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953002,"countryShortCode":"BTN","countryFullName":"Bhutan","statisticsData":"https://file1.dxycdn.com/2020/0315/431/3402160508513085059-135.json","countryName":"不丹","countryId":"10"},{"id":1086317,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"MNG","countryFullName":"Mongolia","statisticsData":"https://file1.dxycdn.com/2020/0315/947/3402160536430373542-135.json","countryName":"蒙古","countryId":"10"},{"id":1085953,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":953005,"countryShortCode":"NPL","countryFullName":"Nepal","statisticsData":"https://file1.dxycdn.com/2020/0315/813/3402160536430196712-135.json","countryName":"尼泊尔","countryId":"10"},{"id":1086110,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":955010,"countryShortCode":"JOR","countryFullName":"Jordan","statisticsData":"https://file1.dxycdn.com/2020/0315/225/3402160532135229235-135.json","countryName":"约旦","countryId":"10"}]},{"continentName":"北美洲","currentConfirmedCount":3030,"deadCount":58,"confirmedCount":3103,"suspectedCount":0,"curedCount":15,"country":[{"id":1085951,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2660,"confirmedCount":2726,"suspectedCount":0,"curedCount":10,"deadCount":56,"comment":"","sort":0,"operator":"wangjinyuan","locationId":971002,"countryShortCode":"USA","countryFullName":"United States of America","statisticsData":"https://file1.dxycdn.com/2020/0315/553/3402160512808052518-135.json","countryName":"美国","countryId":"8"},{"id":1085955,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":248,"confirmedCount":253,"suspectedCount":0,"curedCount":4,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":971001,"countryShortCode":"CAN","countryFullName":"Canada","statisticsData":"https://file1.dxycdn.com/2020/0315/505/3402160534282712951-135.json","countryName":"加拿大","countryId":"10"},{"id":1086318,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":42,"confirmedCount":43,"suspectedCount":0,"curedCount":0,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":972007,"countryShortCode":"PAN","countryFullName":"Panama","statisticsData":"https://file1.dxycdn.com/2020/0315/692/3402160525692954763-135.json","countryName":"巴拿马","countryId":"10"},{"id":1086019,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":40,"confirmedCount":41,"suspectedCount":0,"curedCount":1,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":971003,"countryShortCode":"MEX","countryFullName":"Mexico","statisticsData":"https://file1.dxycdn.com/2020/0315/566/3402160534282889843-135.json","countryName":"墨西哥","countryId":"10"},{"id":1086225,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":22,"confirmedCount":22,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":972002,"countryShortCode":"CRI","countryFullName":"Costa Rica","statisticsData":"https://file1.dxycdn.com/2020/0315/133/3402160534282889827-135.json","countryName":"哥斯达黎加","countryId":"10"},{"id":1086401,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":4,"confirmedCount":4,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":974004,"countryShortCode":"CUB","countryFullName":"Cuba","statisticsData":"https://file1.dxycdn.com/2020/0315/600/3402160504218117572-135.json","countryName":"古巴","countryId":"10"},{"id":1086492,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"MTQ","countryFullName":"Martinique","statisticsData":"https://file1.dxycdn.com/2020/0315/454/3402160527840438534-135.json","countryName":"马提尼克","countryId":"10"},{"id":1086403,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":972005,"countryShortCode":"HND","countryFullName":"Honduras","statisticsData":"https://file1.dxycdn.com/2020/0315/610/3402160540725341073-135.json","countryName":"洪都拉斯","countryId":"10"},{"id":1086493,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"Saint Martin","countryFullName":"Saint Martin","statisticsData":"https://file1.dxycdn.com/2020/0315/871/3402160512808052481-135.json","countryName":"圣马丁岛","countryId":"10"},{"id":1086065,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":974006,"countryShortCode":"DOM","countryFullName":"Dominican Republic","statisticsData":"https://file1.dxycdn.com/2020/0315/651/3402160506365601251-135.json","countryName":"多米尼加","countryId":"10"},{"id":1086398,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":974009,"countryShortCode":"JAM","countryFullName":"Jamaica","statisticsData":"https://file1.dxycdn.com/2020/0315/250/3402160540725341015-135.json","countryName":"牙买加","countryId":"10"},{"id":1086487,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":974013,"countryShortCode":"TTO","countryFullName":"Trinidad & Tobago","countryName":"特立尼达和多巴哥","countryId":"10"},{"id":1086494,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"Saint Barthelemy","countryFullName":"","statisticsData":"https://file1.dxycdn.com/2020/0315/092/3402160508512908125-135.json","countryName":"圣巴泰勒米","countryId":"10"},{"id":1086501,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":972004,"countryShortCode":"GTM","countryFullName":"Guatemala","countryName":"危地马拉","countryId":"10"},{"id":1086506,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":974012,"countryShortCode":"VCT","countryFullName":"Saint Vincent and the Grenadines","statisticsData":"https://file1.dxycdn.com/2020/0315/434/3402160510660391899-135.json","countryName":"圣文森特和格林纳丁斯","countryId":"10"},{"id":1086533,"createTime":1584260898000,"modifyTime":1584260898000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":974001,"countryShortCode":"ATG","countryFullName":"Antigua & Barbuda","countryName":"安提瓜和巴布达","countryId":"10"}]},{"continentName":"其他","currentConfirmedCount":263,"deadCount":7,"confirmedCount":697,"suspectedCount":0,"curedCount":427,"country":[{"id":1085980,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":263,"confirmedCount":697,"suspectedCount":0,"curedCount":427,"deadCount":7,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"Princess","countryFullName":"International conveyance (Diamond Princess)","statisticsData":"https://file1.dxycdn.com/2020/0315/381/3402160536430196671-135.json","countryName":"钻石公主号邮轮","countryId":"10"}]},{"continentName":"大洋洲","currentConfirmedCount":254,"deadCount":3,"confirmedCount":281,"suspectedCount":0,"curedCount":24,"country":[{"id":1085954,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":245,"confirmedCount":272,"suspectedCount":0,"curedCount":24,"deadCount":3,"comment":"","sort":0,"operator":"wangjinyuan","locationId":990001,"countryShortCode":"AUS","countryFullName":"Australia","statisticsData":"https://file1.dxycdn.com/2020/0315/646/3402160532135406038-135.json","countryName":"澳大利亚","countryId":"10"},{"id":1086016,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":8,"confirmedCount":8,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":990007,"countryShortCode":"NZL","countryFullName":"New Zealand","statisticsData":"https://file1.dxycdn.com/2020/0315/194/3402160489185731566-135.json","countryName":"新西兰","countryId":"10"},{"id":1086498,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"PYF","countryFullName":"French Polynesia","statisticsData":"https://file1.dxycdn.com/2020/0315/877/3402160512807875636-135.json","countryName":"法属波利尼西亚","countryId":"10"}]},{"continentName":"南美洲","currentConfirmedCount":356,"deadCount":4,"confirmedCount":361,"suspectedCount":0,"curedCount":1,"country":[{"id":1086007,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":151,"confirmedCount":151,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973003,"countryShortCode":"BRA","countryFullName":"Brazil","statisticsData":"https://file1.dxycdn.com/2020/0315/559/3402160538577857305-135.json","countryName":"巴西","countryId":"10"},{"id":1086123,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":61,"confirmedCount":61,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973004,"countryShortCode":"CHL","countryFullName":"Chile","statisticsData":"https://file1.dxycdn.com/2020/0315/808/3402160527840261646-135.json","countryName":"智利","countryId":"10"},{"id":1086124,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":42,"confirmedCount":45,"suspectedCount":0,"curedCount":1,"deadCount":2,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973001,"countryShortCode":"ARG","countryFullName":"Argentina","statisticsData":"https://file1.dxycdn.com/2020/0315/963/3402160508513085001-135.json","countryName":"阿根廷","countryId":"10"},{"id":1086224,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":28,"confirmedCount":28,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973008,"countryShortCode":"PER","countryFullName":"Peru","statisticsData":"https://file1.dxycdn.com/2020/0315/005/3402160540725341040-135.json","countryName":"秘鲁","countryId":"10"},{"id":1086061,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":22,"confirmedCount":23,"suspectedCount":0,"curedCount":0,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973006,"countryShortCode":"ECU","countryFullName":"Ecuador","statisticsData":"https://file1.dxycdn.com/2020/0315/922/3402160517103019900-135.json","countryName":"厄瓜多尔","countryId":"10"},{"id":1086226,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":22,"confirmedCount":22,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973005,"countryShortCode":"COL","countryFullName":"Colombia","statisticsData":"https://file1.dxycdn.com/2020/0315/269/3402160512808052512-135.json","countryName":"哥伦比亚","countryId":"10"},{"id":1086503,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":10,"confirmedCount":10,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"VEN","countryFullName":"Venezuela","countryName":"委内瑞拉","countryId":"10"},{"id":1086228,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":6,"confirmedCount":6,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973009,"countryShortCode":"PRY","countryFullName":"Paraguay","statisticsData":"https://file1.dxycdn.com/2020/0315/004/3402160529987922312-135.json","countryName":"巴拉圭","countryId":"10"},{"id":1086504,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":6,"confirmedCount":6,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973011,"countryShortCode":"URY","countryFullName":"Uruguay","countryName":"乌拉圭","countryId":"10"},{"id":1086491,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":5,"confirmedCount":5,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"GUF","countryFullName":"French Guiana","statisticsData":"https://file1.dxycdn.com/2020/0315/094/3402160504218117592-135.json","countryName":"法属圭亚那","countryId":"10"},{"id":1086399,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973002,"countryShortCode":"BOL","countryFullName":"Bolivia (Plurinational State of)","statisticsData":"https://file1.dxycdn.com/2020/0315/679/3402160529987745516-135.json","countryName":"玻利维亚","countryId":"10"},{"id":1086505,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973010,"countryShortCode":"SUR","countryFullName":"Suriname","countryName":"苏里南","countryId":"10"},{"id":1086402,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":973007,"countryShortCode":"GUY","countryFullName":"Guyana","statisticsData":"https://file1.dxycdn.com/2020/0315/264/3402160506365424412-135.json","countryName":"圭亚那","countryId":"10"}]},{"continentName":"非洲","currentConfirmedCount":227,"deadCount":7,"confirmedCount":267,"suspectedCount":0,"curedCount":33,"country":[{"id":1085979,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":87,"confirmedCount":110,"suspectedCount":0,"curedCount":21,"deadCount":2,"comment":"","sort":0,"operator":"wangjinyuan","locationId":981002,"countryShortCode":"EGY","countryFullName":"Egypt","statisticsData":"https://file1.dxycdn.com/2020/0315/246/3402160540725341003-135.json","countryName":"埃及","countryId":"10"},{"id":1086223,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":38,"confirmedCount":38,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":984011,"countryShortCode":"ZAF","countryFullName":"South Africa","statisticsData":"https://file1.dxycdn.com/2020/0315/417/3402160540725164203-135.json","countryName":"南非","countryId":"10"},{"id":1086003,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":25,"confirmedCount":37,"suspectedCount":0,"curedCount":10,"deadCount":2,"comment":"","sort":0,"operator":"wangjinyuan","locationId":981001,"countryShortCode":"DZA","countryFullName":"Algeria","statisticsData":"https://file1.dxycdn.com/2020/0315/112/3402160514955536226-135.json","countryName":"阿尔及利亚","countryId":"10"},{"id":1086108,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":20,"confirmedCount":22,"suspectedCount":0,"curedCount":2,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":982014,"countryShortCode":"SEN","countryFullName":"Senegal","statisticsData":"https://file1.dxycdn.com/2020/0315/435/3402160508513085044-135.json","countryName":"塞内加尔","countryId":"10"},{"id":1086151,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":18,"confirmedCount":18,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":981006,"countryShortCode":"TUN","countryFullName":"Tunisia","statisticsData":"https://file1.dxycdn.com/2020/0315/984/3402160538577857284-135.json","countryName":"突尼斯","countryId":"10"},{"id":1086109,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":14,"confirmedCount":16,"suspectedCount":0,"curedCount":0,"deadCount":2,"comment":"","sort":0,"operator":"wangjinyuan","locationId":981004,"countryShortCode":"MAR","countryFullName":"Morocco","statisticsData":"https://file1.dxycdn.com/2020/0315/520/3402160510660391844-135.json","countryName":"摩洛哥","countryId":"10"},{"id":1086221,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":3,"confirmedCount":3,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":983001,"countryShortCode":"CMR","countryFullName":"Cameroon","statisticsData":"https://file1.dxycdn.com/2020/0315/373/3402160506365424402-135.json","countryName":"喀麦隆","countryId":"10"},{"id":1086014,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":982013,"countryShortCode":"NGA","countryFullName":"Nigeria","statisticsData":"https://file1.dxycdn.com/2020/0315/705/3402160532135406075-135.json","countryName":"尼日利亚","countryId":"10"},{"id":1086235,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":982002,"countryShortCode":"BFA","countryFullName":"Burkina Faso","statisticsData":"https://file1.dxycdn.com/2020/0315/667/3402160525692777928-135.json","countryName":"布基纳法索","countryId":"10"},{"id":1086397,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"COD","countryFullName":"Democratic Republic of the Congo","statisticsData":"https://file1.dxycdn.com/2020/0315/118/3402160512808052491-135.json","countryName":"刚果（金）","countryId":"10"},{"id":1086488,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":982006,"countryShortCode":"GHA","countryFullName":"Ghana","countryName":"加纳","countryId":"10"},{"id":1086509,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":984009,"countryShortCode":"NAM","countryFullName":"Namibia","countryName":"纳米比亚","countryId":"10"},{"id":1086532,"createTime":1584260898000,"modifyTime":1584260898000,"tags":"","countryType":2,"currentConfirmedCount":2,"confirmedCount":2,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":985007,"countryShortCode":"SYC","countryFullName":"Seychelles","countryName":"塞舌尔","countryId":"10"},{"id":1086227,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":982016,"countryShortCode":"TGO","countryFullName":"Togo","statisticsData":"https://file1.dxycdn.com/2020/0315/916/3402160508512908168-135.json","countryName":"多哥","countryId":"10"},{"id":1086400,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":982004,"countryShortCode":"CIV","countryFullName":"Cote d Ivoire","statisticsData":"https://file1.dxycdn.com/2020/0315/055/3402160534282712929-135.json","countryName":"科特迪瓦","countryId":"10"},{"id":1086489,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":983004,"countryShortCode":"GA","countryFullName":"","countryName":"加蓬","countryId":"10"},{"id":1086490,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":985005,"countryShortCode":"KE","countryFullName":"","countryName":"肯尼亚","countryId":"10"},{"id":1086499,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":985004,"countryShortCode":"ETH","countryFullName":"Ethiopia","countryName":"埃塞俄比亚","countryId":"10"},{"id":1086527,"createTime":1584260898000,"modifyTime":1584260898000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"GNQ","countryFullName":"Eq.Guinea","countryName":"赤道几内亚","countryId":"10"},{"id":1086528,"createTime":1584260898000,"modifyTime":1584260898000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":985006,"countryShortCode":"RWA","countryFullName":"Rwanda","countryName":"卢旺达","countryId":"10"},{"id":1086529,"createTime":1584260898000,"modifyTime":1584260898000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":0,"countryShortCode":"GIN","countryFullName":"Guinea","countryName":"几内亚","countryId":"10"},{"id":1086530,"createTime":1584260898000,"modifyTime":1584260898000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":982012,"countryShortCode":"MRT","countryFullName":"Mauritania","countryName":"毛里塔尼亚","countryId":"10"},{"id":1086531,"createTime":1584260898000,"modifyTime":1584260898000,"tags":"","countryType":2,"currentConfirmedCount":1,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":0,"comment":"","sort":0,"operator":"wangjinyuan","locationId":984010,"countryShortCode":"SWZ","countryFullName":"Swaziland","countryName":"斯威士兰","countryId":"10"},{"id":1086502,"createTime":1584260897000,"modifyTime":1584260897000,"tags":"","countryType":2,"currentConfirmedCount":0,"confirmedCount":1,"suspectedCount":0,"curedCount":0,"deadCount":1,"comment":"","sort":0,"operator":"wangjinyuan","locationId":981005,"countryShortCode":"SDN","countryFullName":"Sudan","countryName":"苏丹","countryId":"10"}]}]
/// rumour : [{"id":181,"title":"可在家使用新冠病毒试剂盒自测？","mainSummary":"北京市药监局提示：普通市民家庭不可自行使用","summary":"","body":"近日，有人在朋友圈兜售某公司生产的新冠病毒抗体检测试剂盒，单价 150 元，并宣称可以家庭自行使用。对此，北京市药监局提示，经批准注册的新冠病毒检测试剂盒，均需要具备 PCR 实验室及专用设备的医疗机构才能完成检测，普通市民家庭不可自行使用，市民不要轻信虚假宣传，出现相关症状应及时就医。","sourceUrl":"","score":1000,"rumorType":0},{"id":184,"title":"疫情期间大强度锻炼可提高抵抗力？","mainSummary":"国家体育总局体育科学研究所研究员徐建方：长时间大强度的运动，会导致身体机能失调，免疫功能下降","summary":"","body":"长时间大强度的运动，会导致身体机能失调，免疫功能下降，并且运动损伤风险增加。因此，特别忌讳平常不运动、锻炼搞突击。什么样的运动强度是适宜的：运动后感觉轻度的呼吸急促，周身微热，面色微红，内心感觉轻松愉快。虽然稍微感觉有点疲乏，但是经过休息以后可以消除，并且没有疼痛和麻木。","sourceUrl":"","score":1000,"rumorType":0},{"id":182,"title":"吃降压药会增加感染病毒的风险？","mainSummary":"丁香医生团队辟谣：目前没有任何动物和临床研究数据证实这种说法的可靠性","summary":"","body":"因现有研究显示 ACE2 是新型冠状病毒入侵人体的关键，网传服用 ACEI（血管紧张素转化酶抑制剂）类降压药会增加感染新冠病毒的风险。但目前没有任何动物和临床研究数据证实。擅自停用降压药会导致血压波动，给高血压患者带来更大的危险。对高血压患者而言，所有的药物调整都要在专科医生的指导下进行。","sourceUrl":"","score":197,"rumorType":0},{"id":183,"title":"改用吸痰机后，武汉死亡人数减半？","mainSummary":"刘良教授辟谣：没有干预过任何个例的临床治疗","summary":"","body":"有传闻称：「病患遗体解剖发现死者肺部出现大量痰栓，而痰栓是由呼吸机使用所产生，致人缺氧而死。昨天开始，急救改用吸痰机，帮助武汉死亡人数减半，这需要感谢遗体捐献者和同济法医系刘良教授团队的努力。」对此，刘良教授亲自辟谣：没有干预过任何个例的临床治疗。\n法医学专家表示：「痰栓不是呼吸机导致的，而是由肺部黏液病变形成的，属于疾病损害后的病理过程。」","sourceUrl":"","score":196,"rumorType":0},{"id":180,"title":"第一例新冠肺炎患者来自美国？","mainSummary":"丁香医生团队查证：系翻译错误","summary":"","body":"网传的新闻截图原文「CDC confirms first coronavirus case of \"unknown\"origin in U.S.」的意思其实是：「美国疾控中心确认美国出现首例无法确定病源新冠肺炎患者。」网友说得好，只背单词不学语法的人，就不要瞎翻译了。","sourceUrl":"","score":195,"rumorType":0},{"id":179,"title":"新冠病毒传播途径有变化？","mainSummary":"科技部社会发展科技司司长吴远彬：目前研究结论显示，呼吸道飞沫和密切接触传播仍然是主要传播途径","summary":"","body":"28 日，科技部社会发展科技司司长吴远彬表示，目前研究结论显示，呼吸道飞沫和密切接触传播仍然是主要传播途径。粪口传播有一定风险，但传播能力和条件还需进一步相应研究证实。针对气溶胶传播，中国医科院实验动物所开展相应实验，气溶胶传播要同时满足密闭的空间、较长的时间、高浓度病毒三个条件，在这些条件下才有传染的可能性。通风条件良好的日常生活中气溶胶传播可能性小。","sourceUrl":"","score":193,"rumorType":0},{"id":177,"title":"十三名男女生感染 sk5 病毒？","mainSummary":"丁香医生团队查证：该谣言系 2018 年的旧谣言，造谣者已被查处","summary":"","body":"近日，部分网民转发「乐陵十三人染 sk5 病毒，参与抢救的医生已被隔离」的信息，其实，该谣言早在 2018 年就已经存在，且造谣者被依法查处。此次经乐陵市公安局侦查，确认该谣言在当前时期的首次转发者为董某玲（庆云县居住）。2020 年 2 月 27 日，董某玲因散布谣言扰乱公共秩序，已被公安机关依法处以行政拘留。","sourceUrl":"","score":192,"rumorType":0},{"id":173,"title":"十年前就有人预测疫情？","mainSummary":"上海图书馆查证：没有找到传闻里提到的这本书，同名文章也没有相关内容","summary":"","body":"网传「陈国生写的一本叫《实证化中医基础理论及运用》的书在十年前预言了这次肺炎疫情」。上海图书馆进行了查证，没有检索到这本书。\n在万方数据库里，可以查得陈国生所写《实证化中医基础理论依据及应用》这篇文章，发表在《2011 年全国天灾预测研讨学术会议论文集》中，题名和网传有一字之差，但能够对上年份和会议名称。但并未发现涉及任何与疫情预测相关的内容。","sourceUrl":"","score":191,"rumorType":0},{"id":14,"title":"戴多层口罩才能防住病毒?","mainSummary":"丁香医生团队辟谣：佩戴多层口罩可能造成呼吸不畅","summary":"","body":"不需要佩戴多层口罩。建议选择 N95/KN95 或普通外科口罩，并且一层就够，其他口罩防护效果不如这三种。佩戴多层口罩还可能造成呼吸不畅。\n","sourceUrl":"","score":190,"rumorType":0},{"id":178,"title":"确诊者家中的狗检测呈弱阳性？","mainSummary":"香港食卫局长陈肇始强调：虽查到弱阳性，但无证据显示狗会传播新冠病毒给人","summary":"","body":"据香港文汇网报道，香港渔护署发现一名新冠肺炎确诊患者饲养的宠物狗对病毒测试呈弱阳性反应。香港食物及卫生局长陈肇始 28 日强调，无证据显示狗会传播新冠病毒给人。她呼吁养宠物的市民注意个人卫生。\n\n陈肇始表示，这只狗会接受兽医的医学监察，并抽取样本化验，待测试结果呈阴性才会发还。","sourceUrl":"","score":190,"rumorType":1}]
/// wiki_list : [{"id":1,"title":"什么是新型冠状病毒？","imgUrl":"","linkUrl":"https://ask.dxy.com/ama/index#/disease/24677/info/0","description":"此次流行的冠状病毒为一种新发现的冠状病毒，国际病毒分类委员会命名为 SARS-Cov-2。因为人群缺少对新型病毒株的免疫力，所以人群普遍易感。","sort":99},{"id":2,"title":"帮你排除感染症状","imgUrl":"https://img1.dxycdn.com/2020/0126/335/3393120598787233917-66.png","linkUrl":"https://ask.dxy.com/ama/index#/disease/24677/info/1","description":"出现什么症状可能感染了新型冠状病毒？如何在家做好自我隔离？","sort":50},{"id":3,"title":"冠状病毒怕什么？","imgUrl":"https://img1.dxycdn.com/2020/0126/584/3393140198870641951-73.jpg","linkUrl":"https://ask.dxy.com/ama/index#/disease/24677/info/2","description":"哪些人容易感染新型冠状病毒？什么人容易变成重症？新型冠状病毒致病性如何？","sort":45},{"id":7,"title":"做好预防免感染","imgUrl":"https://img1.dxycdn.com/2020/0127/314/3393234046053613437-73.jpg","linkUrl":"https://ask.dxy.com/ama/index#/disease/24677/info/6","description":"人口不密集的地方可以不带口罩吗？口罩能重复带吗？煮沸后能重复使用吗？","sort":40},{"id":6,"title":"日常防护要到位","imgUrl":"https://img1.dxycdn.com/2020/0126/366/3393121524352686218-66.png","linkUrl":"https://ask.dxy.com/ama/index#/disease/24677/info/5","description":"新型冠状病毒肺炎流行，外卖还能吃吗？买不到消毒液家里消毒用什么替代？","sort":35},{"id":4,"title":"如何确诊感染？","imgUrl":"https://img1.dxycdn.com/2020/0126/838/3393121081971054723-66.png","linkUrl":"https://ask.dxy.com/ama/index#/disease/24677/info/3","description":"新型冠状病毒肺炎患者有什么临床表现？医生如何识别并确诊新型冠状病毒肺炎？","sort":4},{"id":5,"title":"治疗方法早知道","imgUrl":"https://img1.dxycdn.com/2020/0126/500/3393121414831020167-66.png","linkUrl":"https://ask.dxy.com/ama/index#/disease/24677/info/4","description":"潜伏期能检查出来吗？感染了新型冠状病毒一定会得肺炎吗？新冠肺炎如何治疗？","sort":3}]
/// recommend : [{"id":155,"createTime":1584084790000,"modifyTime":1584084790000,"contentType":4,"title":"1 个错误动作，严重烧伤！10 个消毒常见错误千万别再犯了","imgUrl":"https://img1.dxycdn.com/2020/0313/012/3401794963846645571-135.jpg","linkUrl":"https://mp.weixin.qq.com/s/Zaku42njWNpljKF3mViaiA","recordStatus":1,"sort":299,"operator":"zhengjiaxuan","countryType":1},{"id":154,"createTime":1583223980000,"modifyTime":1583223980000,"contentType":2,"title":"特殊时期，孩子感冒咳嗽了到底要不要去医院？","imgUrl":"https://img1.dxycdn.com/2020/0303/889/3399947603922974408-135.jpg","linkUrl":"https://mp.weixin.qq.com/s/T9QvVHgkE30lMn_fC3EBBw","recordStatus":1,"sort":298,"operator":"zhengjiaxuan","countryType":1},{"id":152,"createTime":1583223816000,"modifyTime":1583223816000,"contentType":1,"title":"电动口罩有没有用？","imgUrl":"https://img1.dxycdn.com/2020/0303/345/3399947210933784082-135.jpg","linkUrl":"https://mp.weixin.qq.com/s/c98MyhQiJ3aiNWjjseYGbg","recordStatus":1,"sort":297,"operator":"zhengjiaxuan","countryType":1},{"id":153,"createTime":1583223881000,"modifyTime":1583223881000,"contentType":2,"title":"因为疫情耽误的疫苗接种，该如何安排补种？","imgUrl":"https://img1.dxycdn.com/2020/0303/678/3399947393469903332-135.jpg","linkUrl":"https://mp.weixin.qq.com/s/dejV_MZSZSZvlpSliER1dQ","recordStatus":1,"sort":296,"operator":"zhengjiaxuan","countryType":1},{"id":151,"createTime":1583222405000,"modifyTime":1583222405000,"contentType":4,"title":"酒精、碘伏、紫外线怎么选？9 种常见消毒产品用法一篇说清楚","imgUrl":"https://img1.dxycdn.com/2020/0303/294/3399944217341691701-135.jpg","linkUrl":"https://mp.weixin.qq.com/s/54yWV3Ll9u1KfPmPa3fUEg","recordStatus":1,"sort":295,"operator":"zhengjiaxuan","countryType":1}]

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

  List<String> dailyPics;

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
  List<TrendChartBean> quanGuoTrendChart;
  List<TrendChartBean> hbFeiHbTrendChart;
  CountStatistics foreignStatistics;
  CountStatistics globalStatistics;
  List<GlobalOtherTrendChartData> globalOtherTrendChartData;

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
    bean.dailyPics = List()
      ..addAll((map['dailyPics'] as List ?? []).map((o) => o.toString()));
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
          .map((o) => TrendChartBean.fromMap(o)));
    bean.hbFeiHbTrendChart = List()
      ..addAll((map['hbFeiHbTrendChart'] as List ?? [])
          .map((o) => TrendChartBean.fromMap(o)));

    bean.foreignStatistics = CountStatistics.fromMap(map['foreignStatistics']);
    bean.globalStatistics = CountStatistics.fromMap(map['globalStatistics']);

    bean.globalOtherTrendChartData = List()
      ..addAll((map['globalOtherTrendChartData'] as List ?? [])
          .map((o) => GlobalOtherTrendChartData.fromMap(o)));

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
        "dailyPics": dailyPics,
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
        "foreignStatistics": foreignStatistics,
        "globalStatistics": globalStatistics,
        "globalOtherTrendChartData": globalOtherTrendChartData,
        "provinces": provinces,
        "continents": continents,
        "rumour": rumour,
        "wiki_list": wikiList,
        "recommend": recommend,
      };
}

/// confirmedCount : 4
/// confirmedIncr : 4
/// curedCount : 0
/// curedIncr : 0
/// currentConfirmedCount : 4
/// currentConfirmedIncr : 4
/// dateId : 20200121
/// deadCount : 0
/// deadIncr : 0
/// suspectedCount : 0
/// suspectedCountIncr : 0

class GlobalOtherTrendChartData {
  int confirmedCount;
  int confirmedIncr;
  int curedCount;
  int curedIncr;
  int currentConfirmedCount;
  int currentConfirmedIncr;
  int dateId;
  int deadCount;
  int deadIncr;
  int suspectedCount;
  int suspectedCountIncr;

  static GlobalOtherTrendChartData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GlobalOtherTrendChartData bean = GlobalOtherTrendChartData();
    bean.confirmedCount = map['confirmedCount'];
    bean.confirmedIncr = map['confirmedIncr'];
    bean.curedCount = map['curedCount'];
    bean.curedIncr = map['curedIncr'];
    bean.currentConfirmedCount = map['currentConfirmedCount'];
    bean.currentConfirmedIncr = map['currentConfirmedIncr'];
    bean.dateId = map['dateId'];
    bean.deadCount = map['deadCount'];
    bean.deadIncr = map['deadIncr'];
    bean.suspectedCount = map['suspectedCount'];
    bean.suspectedCountIncr = map['suspectedCountIncr'];
    return bean;
  }

  Map toJson() => {
        "confirmedCount": confirmedCount,
        "confirmedIncr": confirmedIncr,
        "curedCount": curedCount,
        "curedIncr": curedIncr,
        "currentConfirmedCount": currentConfirmedCount,
        "currentConfirmedIncr": currentConfirmedIncr,
        "dateId": dateId,
        "deadCount": deadCount,
        "deadIncr": deadIncr,
        "suspectedCount": suspectedCount,
        "suspectedCountIncr": suspectedCountIncr,
      };
}

/// currentConfirmedCount : 323870
/// confirmedCount : 380146
/// suspectedCount : 4
/// curedCount : 38720
/// deadCount : 17556

class CountStatistics {
  int currentConfirmedCount;
  int confirmedCount;
  int suspectedCount;
  int curedCount;
  int deadCount;
  int suspectedIncr;
  int currentConfirmedIncr;
  int confirmedIncr;
  int curedIncr;
  int deadIncr;

  static CountStatistics fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountStatistics statistics = CountStatistics();
    statistics.currentConfirmedCount = map['currentConfirmedCount'];
    statistics.confirmedCount = map['confirmedCount'];
    statistics.suspectedCount = map['suspectedCount'];
    statistics.curedCount = map['curedCount'];
    statistics.deadCount = map['deadCount'];
    statistics.suspectedIncr = map['suspectedIncr'];
    statistics.currentConfirmedIncr = map['currentConfirmedIncr'];
    statistics.confirmedIncr = map['confirmedIncr'];
    statistics.curedIncr = map['curedIncr'];
    statistics.deadIncr = map['deadIncr'];
    return statistics;
  }

  Map toJson() => {
        "currentConfirmedCount": currentConfirmedCount,
        "confirmedCount": confirmedCount,
        "suspectedCount": suspectedCount,
        "curedCount": curedCount,
        "deadCount": deadCount,
        "suspectedIncr": suspectedIncr,
        "currentConfirmedIncr": currentConfirmedIncr,
        "confirmedIncr": confirmedIncr,
        "curedIncr": curedIncr,
        "deadIncr": deadIncr,
      };
}

/// imgUrl : "https://img1.dxycdn.com/2020/0214/103/3396575592886584759-135.png"
/// title : "新增确诊"

class TrendChartBean {
  String imgUrl;
  String title;

  static TrendChartBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TrendChartBean trendChartBean = TrendChartBean();
    trendChartBean.imgUrl = map['imgUrl'];
    trendChartBean.title = map['title'];
    return trendChartBean;
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
  String countryShortCode;
  String countryFullName;
  String statisticsData;
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
    countryBean.countryShortCode = map['countryShortCode'];
    countryBean.countryFullName = map['countryFullName'];
    countryBean.statisticsData = map['statisticsData'];
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
        "countryShortCode": countryShortCode,
        "countryFullName": countryFullName,
        "statisticsData": statisticsData,
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
  Comment comment;
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
    bean.comment = Comment.fromMap(map['comment']);
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

class Comment {
  String title;
  String url;
  String origID;
  bool enabled;
  String id;
  bool unifyToSubject;
  bool vote;
  String groupId;
  String channel;

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Comment commentBean = Comment();
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
    WikiListBean wikiList = WikiListBean();
    wikiList.id = map['id'];
    wikiList.title = map['title'];
    wikiList.imgUrl = map['imgUrl'];
    wikiList.linkUrl = map['linkUrl'];
    wikiList.description = map['description'];
    wikiList.sort = map['sort'];
    return wikiList;
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
