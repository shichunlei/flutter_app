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

  Map toJson() =>
      {
        "title": title,
        "artists": artists,
        "audioPath": audioPath,
        "albumArtUrl": albumArtUrl,
      };
}

List<Music> songsData = [
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
