import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/l10n.dart';

import '../../page_index.dart';
import '../index.dart';

class ContactListPage extends StatefulWidget {
  @override
  createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  int _itemHeight = 70;

  var data;

  @override
  void initState() {
    super.initState();

    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).contacts), elevation: 0.0),
        body: FutureBuilder<List<ContactBean>>(
            future: data,
            builder: (_, AsyncSnapshot<List<ContactBean>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  debugPrint('waiting');
                  return LoadingWidget();
                case ConnectionState.done:
                  debugPrint('done');
                  if (snapshot.hasError) {
                    debugPrint(snapshot.error.toString());
                    return ErrorPage(text: '网络请求错误');
                  } else {
                    ///debugPrint('${snapshot.data.length}');
                    if (snapshot.data.length > 0) {
                      return AzListView(
                          data: snapshot.data,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                  height: 220,
                                  child: Diagonal(
                                      axis: Axis.horizontal,
                                      position: DiagonalPosition.BOTTOM_LEFT,
                                      clipHeight: 50.0,
                                      child: ContactListHeader(
                                          name: "SCL", phone: "18601952581")));
                            }
                            return _buildListItem(snapshot.data[index]);
                          },
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
//                        indexBarData: ['↑', ...kIndexBarData],
                          indexBarData:
                              SuspensionUtil.getTagIndexList(snapshot.data),
                          indexBarOptions: IndexBarOptions(
                              needRebuild: true,
                              ignoreDragCancel: true,
                              downTextStyle:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              downItemDecoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              indexHintWidth: 120 / 2,
                              indexHintHeight: 100 / 2,
                              indexHintDecoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/ic_index_bar_bubble_gray.png'),
                                      fit: BoxFit.contain)),
                              indexHintAlignment: Alignment.centerRight,
                              indexHintChildAlignment: Alignment(-0.25, 0.0),
                              indexHintOffset: Offset(-20, 0)));
                    }
                    return EmptyPage(
                        text: '暂无数据', imageAsset: 'images/empty.jpeg');
                  }
                  break;
                default:
                  return null;
              }
            }));
  }

  Widget _buildListItem(ContactBean model) {
    return Container(
        padding: const EdgeInsets.only(left: 16.0, right: 34.0),
        height: _itemHeight.toDouble(),
        child: Container(
            decoration: BoxDecoration(
                border: (model.isShowSuspension)
                    ? Border(
                        top: Divider.createBorderSide(context,
                            color: Colors.grey, width: 0.6))
                    : null),
            child: Row(children: <Widget>[
              Opacity(
                  opacity: model.isShowSuspension ? 1 : 0,
                  child: SizedBox(
                      width: 28.0,
                      child: Text(model.firstLetter,
                          style: TextStyles.textDark14))),
              Expanded(
                  child: ListTile(
                      leading: Hero(
                          tag: '${model.fullName}',
                          child: model?.picture?.medium == ""
                              ? CircleAvatar(child: Text(model?.fullName[0]))
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(model?.picture?.medium))),
                      title: Text(model.fullName),
                      subtitle: Text(model.email),
                      onTap: () => pushNewPage(
                          context,
                          ContactPage(
                              name: model.fullName,
                              phone: model.phone,
                              avatar: model?.picture?.large,
                              email: model?.email,
                              cell: model?.cell,
                              address:
                                  "${model?.location?.street?.number} ${model?.location?.street?.name}",
                              area:
                                  "${model?.location?.city}, ${model?.location?.state}",
                              birthday: model?.dob?.date))))
            ])));
  }

  Future<List<ContactBean>> fetchData() async {
    List<ContactBean> _contacts = await OtherRepository.getRandomUser();

    /// 根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_contacts);

    SuspensionUtil.setShowSuspensionStatus(_contacts);

    _contacts.insert(0, ContactBean(fullName: "header", firstLetter: "↑"));
    return _contacts;
  }
}
