import 'package:flutter/material.dart';

import 'card_bottom.dart';
import 'card_top.dart';

class CardOne extends StatelessWidget {
  final VoidCallback onTap;

  CardOne({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                CardTop(radius: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    'Looking forward to Golang 2? We`re starting our journey towards a major release! Make your voiceheard on three upcoming proposals...',
                    style: TextStyle(color: Color(0xFF434242)),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF7F7F7)),
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582638914994&di=49118d934cacb0633b70953aef4db5b5&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F8%2F58707e31ed648.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 5, bottom: 5),
                          child: Column(
                            children: [
                              Text(
                                'Yesterday,at our annual Go contributor summit,attendees got a sneak',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              Text(
                                'https://www.iconfont.cn/search/hdshs',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Color(0xFFB2B2B2)),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  height: 86,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                  child: Text(
                    '1.2km 55 mins ago',
                    style: TextStyle(color: Color(0xFF8B8889)),
                  ),
                ),
                CardBottom(),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
