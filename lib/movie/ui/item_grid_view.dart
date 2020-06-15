import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemGridView extends StatelessWidget {
  final List<Movie> movies;

  ItemGridView({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(6.0),

      /// 网格代理对象，一般使用SliverGridDelegateWithFixedCrossAxisCount对象创建，可指定crossAxisCount、mainAxisSpacing、crossAxisSpacing和childAspectRatio等值。
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        /// 表示垂直于主轴方向上的单元格Widget数量。如果scrollDirection为Axis.vertical，则表示水平单元格的数量；如果scrollDirection为Axis.horizontal，则表示垂直单元格的数量。
        crossAxisCount: 3,

        /// 表示主轴方向单元格的间距。
        mainAxisSpacing: 5.0,

        /// 表示垂直于主轴方向的单元格间距。
        crossAxisSpacing: 5.0,

        /// 表示单元格的宽高比。
        childAspectRatio: 270 / 383,
      ),
      shrinkWrap: true,
      primary: false,

      /// 其值为一个函数：Widget Function(BuildContext context, int index)，实现该函数用于创建每个网格对应的Widget。
      itemBuilder: (context, index) {
        return BouncingView(
          //点击事件
          onPressed: () => pushNewPage(context, MovieDetail(movies[index].id)),
          child: ImageLoadView(movies[index].images.medium.toString()),
        );
      },

      /// 表示网格的单元格总数。
      itemCount: movies.length,
    );
  }
}
