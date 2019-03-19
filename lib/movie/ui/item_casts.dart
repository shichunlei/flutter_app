import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/casts.dart';
import 'package:flutter_app/movie/bean/directors.dart';
import 'package:flutter_app/movie/page/movie_celebrity.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemCasts extends StatelessWidget {
  final String title;
  final List<Casts> casts;
  final List<Directors> directors;

  ItemCasts({Key key, this.title, this.casts, this.directors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int len = casts == null
        ? (directors == null ? 0 : directors.length)
        : casts.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            '$title',
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          GridView.builder(
              itemCount: len,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 3 / 5),
              itemBuilder: (context, index) =>
                  _builderItem(context, index, casts, directors)),
        ],
      ),
    );
  }

  Widget _builderItem(
      context, int index, List<Casts> casts, List<Directors> directors) {
    if (casts != null && casts.isNotEmpty) {
      return Column(
        children: <Widget>[
          GestureDetector(
            //点击事件
            onTap: () => pushNewPage(
                context,
                MovieCelebrityPage(
                    id: casts[index].id, name: casts[index].name)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: casts[index].avatars.small.toString(),
              fit: BoxFit.fill,
            ),
          ),
          Center(
              child: Text(casts[index].name,
                  maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      );
    }

    if (directors != null && directors.isNotEmpty) {
      return Column(
        children: <Widget>[
          GestureDetector(
            //点击事件
            onTap: () => pushNewPage(
                context,
                MovieCelebrityPage(
                    id: directors[index].id, name: directors[index].name)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: directors[index].avatars.small.toString(),
              fit: BoxFit.fill,
            ),
          ),
          Center(
              child: Text(directors[index].name,
                  maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      );
    }

    return Center();
  }
}
