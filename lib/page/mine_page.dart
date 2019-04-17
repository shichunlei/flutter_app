import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/bloc/setting_bloc.dart';
import 'package:flutter_app/utils/sp_util.dart';

class MinePage extends StatelessWidget {
  MinePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<SettingBloc>(context);
    return StreamBuilder(
      stream: _bloc.colorStream,
      initialData: _bloc.color,
      builder: (_, AsyncSnapshot<Color> snapshot) => Theme(
            data: ThemeData(
                primarySwatch: snapshot.data,
                iconTheme: IconThemeData(color: snapshot.data)),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('我的'),
              ),
              body: Container(
                color: Colors.black12,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.only(right: 12.0),
                      sliver: SliverToBoxAdapter(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('当前主题色：',
                              style: TextStyle(
                                  fontSize: 16.0, color: snapshot.data)),
                          Container(
                              width: 20.0, height: 20.0, color: snapshot.data)
                        ],
                      )),
                    ),
                    SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0)),
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                          (_, index) => InkWell(
                                child: Container(
                                  color: SettingBloc.themeColors[index],
                                ),
                                onTap: () {
                                  _bloc.switchTheme(index);
                                  SPUtil.putInt('themeIndex', index);
                                },
                              ),
                          childCount: SettingBloc.themeColors.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
