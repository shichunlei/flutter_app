/// title : "Past The Stargazing Season"
/// artists : "Mili"
/// audioPath : "https://music.163.com/song/media/outer/url?id=29401202.mp3"
/// albumArtUrl : "https://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"

class Music {
  String title;
  String artists;
  String audioPath;
  String albumArtUrl;

  Music({this.title, this.artists, this.audioPath, this.albumArtUrl});

  static Music fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Music musicBean = Music();
    musicBean.title = map['title'];
    musicBean.artists = map['artists'];
    musicBean.audioPath = map['audioPath'];
    musicBean.albumArtUrl = map['albumArtUrl'];
    return musicBean;
  }

  Map toJson() => {
        "title": title,
        "artists": artists,
        "audioPath": audioPath,
        "albumArtUrl": albumArtUrl,
      };
}

List<Music> songsData = [
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400004U394g3ZqSXz.m4a?guid=2796982635&vkey=0741870AAFD65C360FBA75A7EE49860BD3E504939726C7FB58A5CA4EC07F905FCBD44DE5B910B3C4232C8D9A47AD9E088B3D1D2DFA4C02BE&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000eR8wf1H9AIh.jpg?max_age=2592000',
    title: '又见送情郎',
    artists: '王琪',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400002ZKWJ21Iqzpe.m4a?guid=2796982635&vkey=85729734C2B1CACA2C78013AB9E0C5454FBC51149956840A17DAD1E857422EC9178DDE203D51DC817B9792B89A39F46AF986D61365E5D3F3&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000003u7YSp2jv8zL.jpg?max_age=2592000',
    title: '送亲',
    artists: '王琪',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400001lZWGy3wSExc.m4a?guid=2796982635&vkey=5857C17B2E9A217654EE85336D1E8F9365C396845F8EDAD2A3B16E1EB70527F0B8742DEFE7005D5E2F8C6EABAA2748441EC02D6AE988B695&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M0000035jVc236fOjM.jpg?max_age=2592000',
    title: '红尘情痴',
    artists: '王琪',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400002zLKsf1qrKaq.m4a?guid=2796982635&vkey=7D5BD64104A26263D6DFB1927635324A3190CE06F5BA68EB644139C392561689679AB18AA51B2CDB3CC185C345F4510909166514BF892248&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000004CqsM73IMs7y.jpg?max_age=2592000',
    title: '站着等你三千年',
    artists: '王琪',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400003qf2r33lue13.m4a?guid=2796982635&vkey=E573F3629E03B4E83A043661C1DB0CCE99A33C1A26E76A27264435A1C4B068DB73AA207FDE1BB6D789FD997231044058AF68D113AFAAAF1C&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000002AsAzl0fHsXP.jpg?max_age=2592000',
    title: '赢在江湖',
    artists: '姜鹏',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400001eaMqi4Rfv95.m4a?guid=2796982635&vkey=827FC949E36BD5C1D6AD775AA3675C71B8CFBBD1E20F372974DC74DC8CCE3B8627EEB3A0A95C674B386ADB8E0F550A2C146E37A6534CE4A8&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000vk5dU1O8lQs.jpg?max_age=2592000',
    title: '万物生（梵语）',
    artists: '萨顶顶',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400003i9Ifn0SDlkd.m4a?guid=2796982635&vkey=1B927BD64FC530B3743295462FA9C3A49A2B7C37311959EC168817817E11982D1EDB8445CFB08D62D241D02549783D46DE0DBEEBAB2B8ADE&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000HqrR73Ovy3F.jpg?max_age=2592000',
    title: '万物生（国语）',
    artists: '萨顶顶',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400000NHaW52MQIeE.m4a?guid=2796982635&vkey=5C8794DDF5DA3DE83811B77A70539CC875F4BB19DB1A1A734EB9E9520811A27FF9C16F6F2F0C05277B1B2322321EACF6E59F7E1AE776E660&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000003wZs1S3qoU9J.jpg?max_age=2592000',
    title: '全世界宣布爱你',
    artists: '孙子涵、李潇潇',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400000Qq37c4bV6Tm.m4a?guid=2796982635&vkey=38DF15CBD5AD4355D04970E438488CC698FCCB9C5D8E9C8C36B89B1C1C49EA3C88D6A2CF627BF86AAC77EF827C4632BE2C23FD57E69A340B&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000002xsHEV0y3vLe.jpg?max_age=2592000',
    title: 'Ignite',
    artists: 'K-391、Alan Walker、Julie Bergan、胜利 (승리)',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400000xhio724WRmK.m4a?guid=2796982635&vkey=3F6C9D04AB9EEF91641499CE477946D9376C991756E87C3E4BA4AC450B23BDAAFAEE911235776391F672DC85A31B5899357937807E301269&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000001z1OuX41cBAx.jpg?max_age=2592000',
    title: '缘分一道桥',
    artists: '王力宏、谭维维',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400001WI9Aa0T7Yni.m4a?guid=2796982635&vkey=888209494B06082C4238ED9498B37F9639C897BF4F5F745869BB111181CCCE5092E6134D7D8EC121501E1FC9C8A3275EC7DEDC1B000765C6&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000004S9OCr1uiKcv.jpg?max_age=2592000',
    title: '渡我不渡她',
    artists: '孤独诗人',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400001FS7ce41y4dZ.m4a?guid=2796982635&vkey=7A12BB76CCF8C1AE5B6C5DA208C59AF85DC63044597932757246820D04DEFA5B60E6355A2C9B79A8AB16181FFB1FF93AADA72CC29C2A5190&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000004NiE4r2IRs6I.jpg?max_age=2592000',
    title: '多年以后',
    artists: '大欢',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C4000049yy4N3SQcyk.m4a?guid=2796982635&vkey=2F91FB75FCBA55550FAFCBDA36962802F91390B65215A4D8A3632114AA36F864D2344982E613810693BBF9EDDED2BDFB3B4BF5481675EF85&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000003shwy324oZyo.jpg?max_age=2592000',
    title: '被遗忘的回忆',
    artists: '二小姐',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400001MmaJX3tzmUW.m4a?guid=2796982635&vkey=D63EB03AB7E850B91F6B65172F6E4D098FB539E89EEEC3E8C929A289BB0BE5551DA53AD68F95B796080040F82CF84D3FAD769CB66D070BBC&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000HYV6S2UjqUh.jpg?max_age=2592000',
    title: '隔壁泰山',
    artists: '阿里郎',
  ),
  Music(
    audioPath:
        'http://124.89.197.18/amobile.music.tc.qq.com/C400000DWjrF1HSCPL.m4a?guid=2796982635&vkey=30E7261536CBF7A54034E7931DD6769FB7F73D28BD7A286ED8C564AD14FA403CBB091D51EA6E9BB82A9DA26E2AA04E3D559DAB0BB51DCC6C&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000f6Ing0O09Et.jpg?max_age=2592000',
    title: '干就完了',
    artists: '金久哲',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1398633928.mp3',
    albumArtUrl:
        'http://p1.music.126.net/qz6xHSzC4gERYzfEVx6F-Q==/109951164443883328.jpg?param=130y130',
    title: 'Lose You To Love Me',
    artists: 'Selena Gomez',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1301027901.mp3',
    albumArtUrl:
        'http://p2.music.126.net/lIH4I7d7879op3sOfSUMrw==/109951163854904814.jpg?param=130y130',
    title: 'Just Like This',
    artists: 'Deepmaniak',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1300528275.mp3',
    albumArtUrl:
        'http://p1.music.126.net/gee-5oSaBNjcg3fhcBJdBQ==/109951163781396587.jpg?param=130y130',
    title: 'Sweet but Psycho',
    artists: 'Ava Max',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=436487129.mp3',
    albumArtUrl:
        'http://p1.music.126.net/9h_TA43qbHLTKwQrQzhLgQ==/18162832579997237.jpg?param=130y130',
    title: 'Move Your Body (Alan Walker Remix)',
    artists: 'Sia / Alan Walker',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=545947179.mp3',
    albumArtUrl:
        'http://p2.music.126.net/jzZQFQdFrb89H22tUA1Qlg==/109951163369745204.jpg?param=130y130',
    title: 'Flames',
    artists: 'David Guetta、Sia',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=81787305.mp3',
    albumArtUrl:
        'http://p2.music.126.net/ff8QRXiKefz7qUj6VeFHHg==/109951164375334868.jpg?param=177y177',
    title: 'Memories',
    artists: 'Maroon 5',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1698391.mp3',
    albumArtUrl:
        'http://p2.music.126.net/mUbPStazv0oF9yrkOiwQ6Q==/1699844976542424.jpg?param=130y130',
    title: 'Beat It',
    artists: 'Michael Jackson',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1357785909.mp3',
    albumArtUrl:
        'http://p1.music.126.net/USRrIEfSNxJ4JnfKp4f6pA==/109951164470147956.jpg?param=130y130',
    title: '野狼disco',
    artists: '宝石gem',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=4132379.mp3',
    albumArtUrl:
        'http://p2.music.126.net/rde3fYhAf7xUId0TDFSyBA==/2593747929926872.jpg?param=130y130',
    title: 'I Hate Myself For Loving You',
    artists: 'Joan Jett、the Blackhearts',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1334270932.mp3',
    albumArtUrl:
        'http://p2.music.126.net/J5vqHK0Hby0nUGe3a7bPXQ==/109951164088095370.jpg?param=130y130',
    title: '逃爱',
    artists: '于嘉乐',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=555984413.mp3',
    albumArtUrl:
        'http://p1.music.126.net/Y1IIadn7rjGrZA5IAKLtBA==/109951163270175127.jpg?param=130y130',
    title: '神话情话',
    artists: '齐豫、周华健',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1349292048.mp3',
    albumArtUrl:
        'http://p2.music.126.net/MLQl_7poLz2PTON6_JZZRQ==/109951163938219545.jpg?param=130y130',
    title: '心如止水',
    artists: 'Ice Paper',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=542152120.mp3',
    albumArtUrl:
        'http://p1.music.126.net/6w7oGzKqJAnEA6MJFSwT9A==/109951163167867712.jpg?param=130y130',
    title: 'Everything You Need',
    artists: 'Michael Learns To Rock',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=454261189.mp3',
    albumArtUrl:
        'http://p1.music.126.net/3-1bjRrwNuP3vwCY2gBWdA==/18714787418092660.jpg?param=130y130',
    title: '男人',
    artists: '葛林',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=26199445.mp3',
    albumArtUrl:
        'http://p1.music.126.net/N07DLBEqprGMTZH21VC0vw==/19129303300296000.jpg?param=130y130',
    title: 'The Phoenix',
    artists: 'Fall Out Boy',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=86360.mp3',
    albumArtUrl:
        'http://p2.music.126.net/2-_sPmCBnN6VfwFmONRy2Q==/46179488378975.jpg?param=130y130',
    title: '忘记时间',
    artists: '胡歌',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=26584442.mp3',
    albumArtUrl:
        'http://p1.music.126.net/KWonqfsj39pd5_Yyf2bE6g==/109951163856433553.jpg?param=130y130',
    title: '风的季节',
    artists: 'Soler',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=93588.mp3',
    albumArtUrl:
        'http://p1.music.126.net/R5mODGRm_AE-gTO860nUig==/31885837218014.jpg?param=130y130',
    title: '回到那一天',
    artists: '郝云',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=469699266.mp3',
    albumArtUrl:
        'http://p1.music.126.net/E1OLdBDVpfd70Z1mI-1odg==/18940187300130282.jpg?param=130y130',
    title: '最美情侣',
    artists: '白小白',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=28923579.mp3',
    albumArtUrl:
        'http://p2.music.126.net/eLu-ldZYiOYTmNHNvvAVZw==/18851126858251972.jpg?param=130y130',
    title: 'Fire',
    artists: 'Gavin Degraw',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=863489830.mp3',
    albumArtUrl:
        'http://p2.music.126.net/TVcuH5xcu23hc4-GBTp5Iw==/109951163560980668.jpg?param=130y130',
    title: '流浪',
    artists: '半阳',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1294910382.mp3',
    albumArtUrl:
        'http://p1.music.126.net/-9RTS6UaU55vo1t80Nz77w==/109951163421373581.jpg?param=130y130',
    title: '我的将军啊',
    artists: '半阳',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1313558186.mp3',
    albumArtUrl:
        'http://p1.music.126.net/yHRY23bKbLJjjbSnE-T8gA==/109951163575213436.jpg?param=130y130',
    title: '一曲相思',
    artists: '半阳',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1369798757.mp3',
    albumArtUrl:
        'http://p2.music.126.net/7ZKMPIvPcwaK08ffDBTjJw==/109951164124664532.jpg?param=130y130',
    title: '芒种',
    artists: '音阙诗听、赵方婧',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1297743701.mp3',
    albumArtUrl:
        'http://p2.music.126.net/h2OXvbTm9K2rTTZUtq-sag==/109951163549473808.jpg?param=130y130',
    title: '醉千年',
    artists: '李袁杰',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=29722582.mp3',
    albumArtUrl:
        'http://p1.music.126.net/SSGt30LAVJwW31-qreZDFA==/2532175280446455.jpg?param=130y130',
    title: '一百万个可能',
    artists: 'Christine Welch',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=404465743.mp3',
    albumArtUrl:
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
    title: '无归',
    artists: '叶里',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=29401202.mp3',
    albumArtUrl:
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
    title: 'Past The Stargazing Season',
    artists: 'Mili',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1343027531.mp3',
    albumArtUrl:
        'http://p2.music.126.net/mIbYsH3iFs-_2TivUFRHqg==/109951163858948073.jpg?param=130y130',
    title: '邦心',
    artists: '高进',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1346101474.mp3',
    albumArtUrl:
        'http://p2.music.126.net/qiJFfLYgdCHfDidTzEvf7g==/109951163879405661.jpg?param=130y130',
    title: '失控',
    artists: '高进',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=21312101.mp3',
    albumArtUrl:
        'http://p1.music.126.net/DSCFmn6dvu2MuQ9i_R6pww==/2534374302055079.jpg?param=130y130',
    title: 'Last Of The Wilds',
    artists: 'Nightwish',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=114369.mp3',
    albumArtUrl:
        'http://p1.music.126.net/a6dvfPjXRT2TNk0cBZHR7g==/60473139533392.jpg?param=130y130',
    title: '最近',
    artists: '李圣杰',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=436514312.mp3',
    albumArtUrl:
        'http://p2.music.126.net/34YW1QtKxJ_3YnX9ZzKhzw==/2946691234868155.jpg?param=130y130',
    title: '成都',
    artists: '赵雷',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=202373.mp3',
    albumArtUrl:
        'http://p2.music.126.net/wldFtES1Cjnbqr5bjlqQbg==/18876415625841069.jpg?param=130y130',
    title: '南方姑娘',
    artists: '赵雷',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=27678655.mp3',
    albumArtUrl:
        'http://p2.music.126.net/0uZ_bKtm4E188Uk9LFN1qg==/109951163187393370.jpg?param=130y130',
    title: '李白',
    artists: '李荣浩',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=27731176.mp3',
    albumArtUrl:
        'http://p2.music.126.net/0uZ_bKtm4E188Uk9LFN1qg==/109951163187393370.jpg?param=130y130',
    title: '模特',
    artists: '李荣浩',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=31654343.mp3',
    albumArtUrl:
        'http://p1.music.126.net/y9LLAuZ-CYMFPqDBq4SNYw==/7823025232375425.jpg?param=130y130',
    title: '不将就',
    artists: '李荣浩',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=569200213.mp3',
    albumArtUrl:
        'http://p1.music.126.net/vmCcDvD1H04e9gm97xsCqg==/109951163350929740.jpg?param=130y130',
    title: '消愁',
    artists: '毛不易',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1331819040.mp3',
    albumArtUrl:
        'http://p2.music.126.net/vdy1as4EPuoYSHlZ36M7sg==/109951163752938123.jpg?param=130y130',
    title: '狂浪',
    artists: '花姐',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1320649834.mp3',
    albumArtUrl:
        'http://p2.music.126.net/mOo5_Ok0uL3dx-MCll4Wcg==/109951163633343019.jpg?param=130y130',
    title: '夜之光',
    artists: '花姐',
  ),
  Music(
    audioPath: 'https://music.163.com/song/media/outer/url?id=1345848098.mp3',
    albumArtUrl:
        'http://p2.music.126.net/R4ZP3AJ9xV0vvw8LX7AbMA==/109951163860425334.jpg?param=130y130',
    title: '绿色',
    artists: '陈雪凝',
  ),
];
