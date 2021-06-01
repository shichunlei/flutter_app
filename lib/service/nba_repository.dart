import 'dart:convert';

import '../page_index.dart';

class NBARepository {
  /// NBA赛季赛程
  ///
  /// [startTime] 开始日期
  /// [endTime] 结束日期
  ///
  static Future<List<Schedule>> getNBASchedule(
      {String startTime, String endTime}) async {
    Response response = await HttpUtils().request(ApiUrl.NBA_SCHEDULE,
        data: {'startTime': startTime, 'endTime': endTime});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Schedule.fromMap(o)));
    } else {
      return [];
    }
  }

  /// NBA球队赛季赛程
  ///
  /// [id] 球队ID
  ///
  static Future<List<Schedule>> getTeamSchedule({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_SCHEDULE, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Schedule.fromMap(o)));
    } else {
      return [];
    }
  }

  /// NBA球队赛季阵容
  ///
  /// [id] 球队ID
  ///
  static Future<List<Player>> getTeamRoster({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_ROSTER, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Player.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球队赛季排名
  ///
  static Future<List<RankBase>> getTeamRank() async {
    Response response = await HttpUtils().request(ApiUrl.TEAM_RANK, data: null);
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => RankBase.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员赛季数据排行前N（）
  ///
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  /// [limit] 返回前多少名
  ///
  static Future<PlayerSeasonRank> getPlayerRankTopN(
      {int year: 2019, int type: 1, int limit: 10}) async {
    Response response = await HttpUtils().request(ApiUrl.PLAYER_RANNGE,
        data: {'year': year, 'type': type, 'limit': limit});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return PlayerSeasonRank.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球员赛季数据排行(全)
  ///
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  /// [page] 页码
  /// [limit] 每页条数
  /// [sort] 排序方式 得分 t70；出手数 t83；命中率 t79；三分出手 t85；三分命中率 t80；罚球次数 t87；发球命中率 t81；篮板 t71；前场篮板 t77；后场篮板 t76；助攻 t68；抢断 t72；盖帽 t69；失误 t74；犯规 t73；场次 t5；上场时间 t78
  ///
  static Future<List<SeasonDataStat>> getPlayerRankAll(
      {int year: 2019,
      int type: 1,
      int page: 1,
      int limit: 50,
      String sort: 't70'}) async {
    Response response = await HttpUtils().request(ApiUrl.PLAYER_RANNGE_ALL,
        data: {
          'year': year,
          'type': type,
          'page': page,
          'limit': limit,
          'sort': sort
        });
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll(
            (result.data as List ?? []).map((o) => SeasonDataStat.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员详情
  ///
  /// [id] 球员ID
  ///
  static Future<StatsBase> getPlayerDetails({String id}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.PLAYER_DETAIL, data: {'id': id, 'year': 2019});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return StatsBase.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球员详情
  ///
  /// [id] 球员ID
  ///
  static Future<StatsBase> getPlayerInfo({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.PLAYER_INFO, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return StatsBase.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球队赛季数据排行(全)
  ///
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  ///
  static Future<List<SeasonDataStat>> getTeamRankAll(
      {int year: 2019, int type: 1}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.TEAM_RANNGE_ALL, data: {'year': year, 'type': type});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll(
            (result.data as List ?? []).map((o) => SeasonDataStat.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员职业生涯赛季数据统计（包括季前赛、常规赛、季后赛）
  ///
  /// [id] 球员ID
  ///
  static Future<List<SeasonDataStat>> getPlayerCareer(String id) async {
    Response response =
        await HttpUtils().request(ApiUrl.PLAYER_CAREER, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll(
            (result.data as List ?? []).map((o) => SeasonDataStat.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员赛季每场比赛数据统计（包括季前赛、常规赛、季后赛）
  ///
  /// [id] 球员ID
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  ///
  static Future<List<PlayerMatch>> getPlayerMatch(String id,
      {int year: 2019, int type: 1}) async {
    Response response = await HttpUtils().request(ApiUrl.PLAYER_MATCH,
        data: {'year': year, 'type': type, 'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll(
            (result.data as List ?? []).map((o) => PlayerMatch.fromMap(o)));
    } else {
      return [];
    }
  }

  /// NBA最新动态
  ///
  /// [name] 球员名字or球队名称
  ///
  static Future<List<NBANews>> getNBANews(String name) async {
    Response response =
        await HttpUtils().request(ApiUrl.NBA_NEWS, data: {'name': name});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => NBANews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球队详情
  ///
  /// [id] 球队ID
  ///
  static Future<Team> getTeamInfo(String id) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_INFO, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return Team.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 比赛数据统计详情
  ///
  /// [mid] 球队ID
  ///
  static Future<MatchBaseBean> getMatchStats(String mid) async {
    Response response =
        await HttpUtils().request(ApiUrl.MATCH_STATS, data: {'mid': mid});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return MatchBaseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球队数据概况
  ///
  /// [id] 球队ID
  ///
  static Future<StatsBase> getTeamStats({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_STATS, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return StatsBase.fromMap(result.data);
    } else {
      return null;
    }
  }
}
