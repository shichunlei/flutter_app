import 'package:flutter/material.dart';

import 'card_bottom.dart';
import 'card_top.dart';

class CardGridView extends StatelessWidget {
  final VoidCallback onTap;

  CardGridView({Key key, this.onTap}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardTop(radius: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    'These photos are awesome!',
                    style: TextStyle(color: Color(0xFF434242)),
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (_, index) {
                    return Image.network(
                      "${bannerImages[index].toString()}",
                      fit: BoxFit.cover,
                    );
                  },
                  shrinkWrap: true,
                  primary: false,
                  itemCount: bannerImages.length,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                  child: Text(
                    '1.2km 55 mins ago',
                    style: TextStyle(color: Color(0xFF8B8889)),
                  ),
                ),
                CardBottom()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> bannerImages = [
  "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2918882617,1624283714&fm=26&gp=0.jpg",
  'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1694196096,1956817301&fm=26&gp=0.jpg',
  'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=422401622,3669771322&fm=26&gp=0.jpg',
  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2662785624,2609285852&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2925061987,411404233&fm=26&gp=0.jpg",
  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4176017085,1014898947&fm=26&gp=0.jpg",
];
