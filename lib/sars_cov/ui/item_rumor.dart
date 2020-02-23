import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

class ItemRumor extends StatelessWidget {
  final int index;
  final RumourBean rumour;

  ItemRumor({Key key, this.index, this.rumour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              AspectRatio(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: Image.asset(
                          'images/lable.png',
                          height: 50,
                          width: 50,
                        ),
                        left: 0,
                        top: 0,
                      ),
                      Positioned(
                        child: Text(
                          '$index',
                          style: TextStyle(color: Colors.white),
                        ),
                        left: 10,
                        top: 10,
                      ),
                      Positioned(
                        child: Image.asset(
                          '${rumour?.rumorText}',
                          height: 50,
                        ),
                        top: 40,
                        left: 20,
                      ),
                      Positioned(
                        child: Image.asset(
                          '${rumour?.rumorIcon}',
                          height: 120,
                        ),
                        top: 20,
                        right: 20,
                      ),
                      Positioned(
                        child: Text(
                          '${rumour?.title}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        left: 20,
                        top: 100,
                        right: 20,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://assets.dxycdn.com/gitrepo/ncov-mobile/dist/static/share-bg1@2x.7a8e864c.png')),
                  ),
                ),
                aspectRatio: 3 / 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${rumour?.mainSummary}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    '${rumour?.body}',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
      ),
    );
  }
}
