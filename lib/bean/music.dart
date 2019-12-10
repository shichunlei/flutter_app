/// title : "Past The Stargazing Season"
/// artists : "Mili"
/// audioPath : "https://music.163.com/song/media/outer/url?id=29401202.mp3"
/// albumArtUrl : "https://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"

class Music {
  String id;
  String title;
  String artists;
  String audioPath;
  String albumArtUrl;

  Music({this.id, this.title, this.artists, this.audioPath, this.albumArtUrl});

  static Music fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Music musicBean = Music();
    musicBean.id = map['id'];
    musicBean.title = map['title'];
    musicBean.artists = map['artists'];
    musicBean.audioPath = map['audioPath'];
    musicBean.albumArtUrl = map['albumArtUrl'];
    return musicBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "artists": artists,
        "audioPath": audioPath,
        "albumArtUrl": albumArtUrl,
      };
}

List<Music> songsData = [
  Music(
    id: "0014uyEJ3MUN4Q",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400004U394g3ZqSXz.m4a?guid=2796982635&vkey=AB3CFFB572A2F155C002130D192D3C7251AC9870A8597367A3997E143DFFFBEBA8483303AD37ECD495FFD1DB3AB858C673FCC2301E026E53&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000eR8wf1H9AIh.jpg?max_age=2592000',
    title: '又见送情郎',
    artists: '王琪',
  ),
  Music(
    id: "0002fr701wX6uz",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C4000002fr701wX6uz.m4a?guid=2796982635&vkey=3B819CF1D8D892DF1FC160CEE7DA2C5391917B1DDDD4B6C340038A1B1420D2D74E8D7DB919339C1A6E108E438639BBC16362696CBD42550E&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M0000038bG9I3ytxyX.jpg?max_age=2592000',
    title: '万爱千恩',
    artists: '王琪',
  ),
  Music(
    id: "002ZKWJ21Iqzpe",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400002ZKWJ21Iqzpe.m4a?guid=2796982635&vkey=1E85267F3D2072FBFBC896F7FBF6BEB7893F6A8814941776975DC104CE40308502261B37C8104EB44DF6AB7F1A2CA485AE4FFAE9D0FE1F15&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000003u7YSp2jv8zL.jpg?max_age=2592000',
    title: '送亲',
    artists: '王琪',
  ),
  Music(
    id: "001lZWGy3wSExc",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400001lZWGy3wSExc.m4a?guid=2796982635&vkey=DBCE8E56A890AAF7BF665430E3EF3F6390CA60042CD9709BAC5748089DDD0EB6C65461A1399A3F828912B7F9A7872296B3116E2B9C979D67&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M0000035jVc236fOjM.jpg?max_age=2592000',
    title: '红尘情痴',
    artists: '王琪',
  ),
  Music(
    id: "002zLKsf1qrKaq",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400002zLKsf1qrKaq.m4a?guid=2796982635&vkey=A3365A79C3C566EBD8BEB33AA0D18BE6605164B1A7035BB049B5E2DDBB650228DAA7321D089FB21BC0E37686F18B441A3AD52BBACBBDE9A3&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000004CqsM73IMs7y.jpg?max_age=2592000',
    title: '站着等你三千年',
    artists: '王琪',
  ),
  Music(
    id: "003XarhT35CoEA",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400003qf2r33lue13.m4a?guid=2796982635&vkey=1E9314118B60F4D8ECF676F0938C1E29BCF6EF860584D0294CD04E211C37C9C9D8866ADFDC9506BAAF09EBC0FECA688DAB198E21ED008B55&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000002AsAzl0fHsXP.jpg?max_age=2592000',
    title: '赢在江湖',
    artists: '姜鹏',
  ),
  Music(
    id: "0046q4LY0QeWW0",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400001eaMqi4Rfv95.m4a?guid=2796982635&vkey=A37A014EF8F6F84E7726A8F52F730EF7C5F66053099162B3BFB889C0B70AAF689727988DC815C5D58F8ED93D3F2631C4255FB08435AFBBC1&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000vk5dU1O8lQs.jpg?max_age=2592000',
    title: '万物生（梵语）',
    artists: '萨顶顶',
  ),
  Music(
    id: "003SB18t2s79Ws",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400003i9Ifn0SDlkd.m4a?guid=2796982635&vkey=64649D2A0F520F5E6BE1C10B57374B214E2455EA90E99BE4F2F3B77462F97542AEABD1C5FAAB161E1C2462240FBBDB0CE0686B3FB8773F32&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000HqrR73Ovy3F.jpg?max_age=2592000',
    title: '万物生（国语）',
    artists: '萨顶顶',
  ),
  Music(
    id: "003KkIvL0jGxl7",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400000NHaW52MQIeE.m4a?guid=2796982635&vkey=3F46329AB291A84E576513F70B40371F03A0C7572080A7964A5FD3D99F51D1477517133327A9FD572603C12A882A65C4D00BD6FB8A83C18A&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000003wZs1S3qoU9J.jpg?max_age=2592000',
    title: '全世界宣布爱你',
    artists: '孙子涵、李潇潇',
  ),
  Music(
    id: "002vbWwe3ZmffT",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400000Qq37c4bV6Tm.m4a?guid=2796982635&vkey=AD94E5522704D8EE78E6A73DE9115081F0284107735491F1AE1ACA9323466DEA747B45587BA0B007A7F54258EC697509974882E8E0D71FB6&uin=1899&fromtag=6',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000002xsHEV0y3vLe.jpg?max_age=2592000',
    title: 'Ignite',
    artists: 'K-391、Alan Walker、Julie Bergan、胜利 (승리)',
  ),
  Music(
    id: "004NXwuk36ixAW",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400000xhio724WRmK.m4a?guid=2796982635&vkey=372D3057880ECCAB522340B7B6873873ED248DCDE663131379AAAE78E9B3B937E57020A5B9BD876DCBA3471B8E6B7DCE76189B4DDB28F555&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000001z1OuX41cBAx.jpg?max_age=2592000',
    title: '缘分一道桥',
    artists: '王力宏、谭维维',
  ),
  Music(
    id: "0019hpEw1QzwRq",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400001WI9Aa0T7Yni.m4a?guid=2796982635&vkey=0BD5B2FBC72002628747097063C3C5619B8AD599B2FE55511D30F76EF618F3E4A8406CA17BE009BAB4A7B19DE39C77F8D4EF3D8A17C72B64&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000004S9OCr1uiKcv.jpg?max_age=2592000',
    title: '渡我不渡她',
    artists: '孤独诗人',
  ),
  Music(
    id: "001FS7ce41y4dZ",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400001FS7ce41y4dZ.m4a?guid=2796982635&vkey=3A812C679F1DD3A0D34D8B0A8FA14D8AC372AD4F1586D98D3ACE4327C1CB56AAC5A1F7C6B81B2DA90F688D95A793BC081F748D3615874404&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000004NiE4r2IRs6I.jpg?max_age=2592000',
    title: '多年以后',
    artists: '大欢',
  ),
  Music(
    id: "0049yy4N3SQcyk",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C4000049yy4N3SQcyk.m4a?guid=2796982635&vkey=2735135ED5D7602445A7B164F104E49A062182D398D0608F35371BA0F0168C76A60F6A08D67AA6ED222195F5744677E9AE290A278805D5AE&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000003shwy324oZyo.jpg?max_age=2592000',
    title: '被遗忘的回忆',
    artists: '二小姐',
  ),
  Music(
    id: "003ZFC693GZKCq",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400001MmaJX3tzmUW.m4a?guid=2796982635&vkey=44028ACCA4BD2CE7C2F460AD11B2C268BB06E28923F9BBE6503F5DCF622400EC97DFCAC924AA7AC47048FC30E1F23EF1286BE27582FDF410&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000HYV6S2UjqUh.jpg?max_age=2592000',
    title: '隔壁泰山',
    artists: '阿里郎',
  ),
  Music(
    id: "003lGAdJ1x3akh",
    audioPath:
        'http://ws.stream.qqmusic.qq.com/C400003lGAdJ1x3akh.m4a?guid=2796982635&vkey=540124DC2537F5B7CFB6A3B995BCBD6877928F11110A5299DFC134269F469E178A72A54203E2A5BF492A771038EFF33CE1AF1B87CB50C55F&uin=1899&fromtag=66',
    albumArtUrl:
        'http://y.gtimg.cn/music/photo_new/T002R300x300M000000f6Ing0O09Et.jpg?max_age=2592000',
    title: '干就完了',
    artists: '金久哲',
  ),
  Music(
    id: "1398633928",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1398633928.mp3',
    albumArtUrl:
        'http://p1.music.126.net/qz6xHSzC4gERYzfEVx6F-Q==/109951164443883328.jpg?param=130y130',
    title: 'Lose You To Love Me',
    artists: 'Selena Gomez',
  ),
  Music(
    id: "1301027901",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1301027901.mp3',
    albumArtUrl:
        'http://p2.music.126.net/lIH4I7d7879op3sOfSUMrw==/109951163854904814.jpg?param=130y130',
    title: 'Just Like This',
    artists: 'Deepmaniak',
  ),
  Music(
    id: "1300528275",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1300528275.mp3',
    albumArtUrl:
        'http://p1.music.126.net/gee-5oSaBNjcg3fhcBJdBQ==/109951163781396587.jpg?param=130y130',
    title: 'Sweet but Psycho',
    artists: 'Ava Max',
  ),
  Music(
    id: "436487129",
    audioPath: 'https://music.163.com/song/media/outer/url?id=436487129.mp3',
    albumArtUrl:
        'http://p1.music.126.net/9h_TA43qbHLTKwQrQzhLgQ==/18162832579997237.jpg?param=130y130',
    title: 'Move Your Body (Alan Walker Remix)',
    artists: 'Sia / Alan Walker',
  ),
  Music(
    id: "545947179",
    audioPath: 'https://music.163.com/song/media/outer/url?id=545947179.mp3',
    albumArtUrl:
        'http://p2.music.126.net/jzZQFQdFrb89H22tUA1Qlg==/109951163369745204.jpg?param=130y130',
    title: 'Flames',
    artists: 'David Guetta、Sia',
  ),
  Music(
    id: "81787305",
    audioPath: 'https://music.163.com/song/media/outer/url?id=81787305.mp3',
    albumArtUrl:
        'http://p2.music.126.net/ff8QRXiKefz7qUj6VeFHHg==/109951164375334868.jpg?param=177y177',
    title: 'Memories',
    artists: 'Maroon 5',
  ),
  Music(
    id: "1698391",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1698391.mp3',
    albumArtUrl:
        'http://p2.music.126.net/mUbPStazv0oF9yrkOiwQ6Q==/1699844976542424.jpg?param=130y130',
    title: 'Beat It',
    artists: 'Michael Jackson',
  ),
  Music(
    id: "1357785909",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1357785909.mp3',
    albumArtUrl:
        'http://p1.music.126.net/USRrIEfSNxJ4JnfKp4f6pA==/109951164470147956.jpg?param=130y130',
    title: '野狼disco',
    artists: '宝石gem',
  ),
  Music(
    id: "4132379",
    audioPath: 'https://music.163.com/song/media/outer/url?id=4132379.mp3',
    albumArtUrl:
        'http://p2.music.126.net/rde3fYhAf7xUId0TDFSyBA==/2593747929926872.jpg?param=130y130',
    title: 'I Hate Myself For Loving You',
    artists: 'Joan Jett、the Blackhearts',
  ),
  Music(
    id: "1334270932",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1334270932.mp3',
    albumArtUrl:
        'http://p2.music.126.net/J5vqHK0Hby0nUGe3a7bPXQ==/109951164088095370.jpg?param=130y130',
    title: '逃爱',
    artists: '于嘉乐',
  ),
  Music(
    id: "555984413",
    audioPath: 'https://music.163.com/song/media/outer/url?id=555984413.mp3',
    albumArtUrl:
        'http://p1.music.126.net/Y1IIadn7rjGrZA5IAKLtBA==/109951163270175127.jpg?param=130y130',
    title: '神话情话',
    artists: '齐豫、周华健',
  ),
  Music(
    id: "1349292048",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1349292048.mp3',
    albumArtUrl:
        'http://p2.music.126.net/MLQl_7poLz2PTON6_JZZRQ==/109951163938219545.jpg?param=130y130',
    title: '心如止水',
    artists: 'Ice Paper',
  ),
  Music(
    id: "542152120",
    audioPath: 'https://music.163.com/song/media/outer/url?id=542152120.mp3',
    albumArtUrl:
        'http://p1.music.126.net/6w7oGzKqJAnEA6MJFSwT9A==/109951163167867712.jpg?param=130y130',
    title: 'Everything You Need',
    artists: 'Michael Learns To Rock',
  ),
  Music(
    id: "454261189",
    audioPath: 'https://music.163.com/song/media/outer/url?id=454261189.mp3',
    albumArtUrl:
        'http://p1.music.126.net/3-1bjRrwNuP3vwCY2gBWdA==/18714787418092660.jpg?param=130y130',
    title: '男人',
    artists: '葛林',
  ),
  Music(
    id: "26199445",
    audioPath: 'https://music.163.com/song/media/outer/url?id=26199445.mp3',
    albumArtUrl:
        'http://p1.music.126.net/N07DLBEqprGMTZH21VC0vw==/19129303300296000.jpg?param=130y130',
    title: 'The Phoenix',
    artists: 'Fall Out Boy',
  ),
  Music(
    id: "86360",
    audioPath: 'https://music.163.com/song/media/outer/url?id=86360.mp3',
    albumArtUrl:
        'http://p2.music.126.net/2-_sPmCBnN6VfwFmONRy2Q==/46179488378975.jpg?param=130y130',
    title: '忘记时间',
    artists: '胡歌',
  ),
  Music(
    id: "26584442",
    audioPath: 'https://music.163.com/song/media/outer/url?id=26584442.mp3',
    albumArtUrl:
        'http://p1.music.126.net/KWonqfsj39pd5_Yyf2bE6g==/109951163856433553.jpg?param=130y130',
    title: '风的季节',
    artists: 'Soler',
  ),
  Music(
    id: "93588",
    audioPath: 'https://music.163.com/song/media/outer/url?id=93588.mp3',
    albumArtUrl:
        'http://p1.music.126.net/R5mODGRm_AE-gTO860nUig==/31885837218014.jpg?param=130y130',
    title: '回到那一天',
    artists: '郝云',
  ),
  Music(
    id: "469699266",
    audioPath: 'https://music.163.com/song/media/outer/url?id=469699266.mp3',
    albumArtUrl:
        'http://p1.music.126.net/E1OLdBDVpfd70Z1mI-1odg==/18940187300130282.jpg?param=130y130',
    title: '最美情侣',
    artists: '白小白',
  ),
  Music(
    id: "28923579",
    audioPath: 'https://music.163.com/song/media/outer/url?id=28923579.mp3',
    albumArtUrl:
        'http://p2.music.126.net/eLu-ldZYiOYTmNHNvvAVZw==/18851126858251972.jpg?param=130y130',
    title: 'Fire',
    artists: 'Gavin Degraw',
  ),
  Music(
    id: "863489830",
    audioPath: 'https://music.163.com/song/media/outer/url?id=863489830.mp3',
    albumArtUrl:
        'http://p2.music.126.net/TVcuH5xcu23hc4-GBTp5Iw==/109951163560980668.jpg?param=130y130',
    title: '流浪',
    artists: '半阳',
  ),
  Music(
    id: "1294910382",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1294910382.mp3',
    albumArtUrl:
        'http://p1.music.126.net/-9RTS6UaU55vo1t80Nz77w==/109951163421373581.jpg?param=130y130',
    title: '我的将军啊',
    artists: '半阳',
  ),
  Music(
    id: "1313558186",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1313558186.mp3',
    albumArtUrl:
        'http://p1.music.126.net/yHRY23bKbLJjjbSnE-T8gA==/109951163575213436.jpg?param=130y130',
    title: '一曲相思',
    artists: '半阳',
  ),
  Music(
    id: "1369798757",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1369798757.mp3',
    albumArtUrl:
        'http://p2.music.126.net/7ZKMPIvPcwaK08ffDBTjJw==/109951164124664532.jpg?param=130y130',
    title: '芒种',
    artists: '音阙诗听、赵方婧',
  ),
  Music(
    id: "1297743701",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1297743701.mp3',
    albumArtUrl:
        'http://p2.music.126.net/h2OXvbTm9K2rTTZUtq-sag==/109951163549473808.jpg?param=130y130',
    title: '醉千年',
    artists: '李袁杰',
  ),
  Music(
    id: "29722582",
    audioPath: 'https://music.163.com/song/media/outer/url?id=29722582.mp3',
    albumArtUrl:
        'http://p1.music.126.net/SSGt30LAVJwW31-qreZDFA==/2532175280446455.jpg?param=130y130',
    title: '一百万个可能',
    artists: 'Christine Welch',
  ),
  Music(
    id: "404465743",
    audioPath: 'https://music.163.com/song/media/outer/url?id=404465743.mp3',
    albumArtUrl:
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
    title: '无归',
    artists: '叶里',
  ),
  Music(
    id: "29401202",
    audioPath: 'https://music.163.com/song/media/outer/url?id=29401202.mp3',
    albumArtUrl:
        'https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg',
    title: 'Past The Stargazing Season',
    artists: 'Mili',
  ),
  Music(
    id: "1343027531",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1343027531.mp3',
    albumArtUrl:
        'http://p2.music.126.net/mIbYsH3iFs-_2TivUFRHqg==/109951163858948073.jpg?param=130y130',
    title: '邦心',
    artists: '高进',
  ),
  Music(
    id: "1346101474",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1346101474.mp3',
    albumArtUrl:
        'http://p2.music.126.net/qiJFfLYgdCHfDidTzEvf7g==/109951163879405661.jpg?param=130y130',
    title: '失控',
    artists: '高进',
  ),
  Music(
    id: "21312101",
    audioPath: 'https://music.163.com/song/media/outer/url?id=21312101.mp3',
    albumArtUrl:
        'http://p1.music.126.net/DSCFmn6dvu2MuQ9i_R6pww==/2534374302055079.jpg?param=130y130',
    title: 'Last Of The Wilds',
    artists: 'Nightwish',
  ),
  Music(
    id: "114369",
    audioPath: 'https://music.163.com/song/media/outer/url?id=114369.mp3',
    albumArtUrl:
        'http://p1.music.126.net/a6dvfPjXRT2TNk0cBZHR7g==/60473139533392.jpg?param=130y130',
    title: '最近',
    artists: '李圣杰',
  ),
  Music(
    id: "436514312",
    audioPath: 'https://music.163.com/song/media/outer/url?id=436514312.mp3',
    albumArtUrl:
        'http://p2.music.126.net/34YW1QtKxJ_3YnX9ZzKhzw==/2946691234868155.jpg?param=130y130',
    title: '成都',
    artists: '赵雷',
  ),
  Music(
    id: "202373",
    audioPath: 'https://music.163.com/song/media/outer/url?id=202373.mp3',
    albumArtUrl:
        'http://p2.music.126.net/wldFtES1Cjnbqr5bjlqQbg==/18876415625841069.jpg?param=130y130',
    title: '南方姑娘',
    artists: '赵雷',
  ),
  Music(
    id: "27678655",
    audioPath: 'https://music.163.com/song/media/outer/url?id=27678655.mp3',
    albumArtUrl:
        'http://p2.music.126.net/0uZ_bKtm4E188Uk9LFN1qg==/109951163187393370.jpg?param=130y130',
    title: '李白',
    artists: '李荣浩',
  ),
  Music(
    id: "27731176",
    audioPath: 'https://music.163.com/song/media/outer/url?id=27731176.mp3',
    albumArtUrl:
        'http://p2.music.126.net/0uZ_bKtm4E188Uk9LFN1qg==/109951163187393370.jpg?param=130y130',
    title: '模特',
    artists: '李荣浩',
  ),
  Music(
    id: "31654343",
    audioPath: 'https://music.163.com/song/media/outer/url?id=31654343.mp3',
    albumArtUrl:
        'http://p1.music.126.net/y9LLAuZ-CYMFPqDBq4SNYw==/7823025232375425.jpg?param=130y130',
    title: '不将就',
    artists: '李荣浩',
  ),
  Music(
    id: "569200213",
    audioPath: 'https://music.163.com/song/media/outer/url?id=569200213.mp3',
    albumArtUrl:
        'http://p1.music.126.net/vmCcDvD1H04e9gm97xsCqg==/109951163350929740.jpg?param=130y130',
    title: '消愁',
    artists: '毛不易',
  ),
  Music(
    id: "1331819040",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1331819040.mp3',
    albumArtUrl:
        'http://p2.music.126.net/vdy1as4EPuoYSHlZ36M7sg==/109951163752938123.jpg?param=130y130',
    title: '狂浪',
    artists: '花姐',
  ),
  Music(
    id: "1320649834",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1320649834.mp3',
    albumArtUrl:
        'http://p2.music.126.net/mOo5_Ok0uL3dx-MCll4Wcg==/109951163633343019.jpg?param=130y130',
    title: '夜之光',
    artists: '花姐',
  ),
  Music(
    id: "1345848098",
    audioPath: 'https://music.163.com/song/media/outer/url?id=1345848098.mp3',
    albumArtUrl:
        'http://p2.music.126.net/R4ZP3AJ9xV0vvw8LX7AbMA==/109951163860425334.jpg?param=130y130',
    title: '绿色',
    artists: '陈雪凝',
  ),
];
