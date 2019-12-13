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
  String lyric;

  Music({
    this.id,
    this.title,
    this.artists,
    this.audioPath,
    this.albumArtUrl,
    this.lyric,
  });

  static Music fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Music musicBean = Music();
    musicBean.id = map['id'];
    musicBean.title = map['title'];
    musicBean.artists = map['artists'];
    musicBean.audioPath = map['audioPath'];
    musicBean.albumArtUrl = map['albumArtUrl'];
    musicBean.lyric = map['lyric'];
    return musicBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "artists": artists,
        "audioPath": audioPath,
        "albumArtUrl": albumArtUrl,
        "lyric": lyric,
      };
}

List<Music> songsData = [
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
    title: 'Move Your Body',
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
