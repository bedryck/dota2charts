import 'package:flutter/material.dart';

class Rank extends StatelessWidget {
  final String rank;
  final String stars;
  final String position;
  Rank({this.rank = "0", this.stars = "0", this.position = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Image(image: AssetImage('images/renkshort/rank/rank_icon_$rank.png')),
          stars == "0"
              ? Container()
              : Image(
                  image: AssetImage(
                      'images/renkshort/stars/rank_star_$stars.png')),
          Align(
             alignment: Alignment(0, 0.85),
            child: Text(position, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
            
             ),
          )
        ],
      ),
    );
  }
}
