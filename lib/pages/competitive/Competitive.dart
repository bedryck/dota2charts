import 'package:flutter/material.dart';

class Competitive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Competitive dota'),
      ),
      body: ListView(
        children: <Widget>[
          _card(context, 'Last matches',
              'https://gamepedia.cursecdn.com/dota2_gamepedia/thumb/e/e6/TI4_KeyArena_1.jpg/400px-TI4_KeyArena_1.jpg?version=e0a219c1bbe9b52eb63f81da731d1e26'),
          _card(context, 'Pro teams',
              'http://cdn.dota2.com/apps/dota2/images/blogfiles/ti9_dpc_invites_orq_im.png'),
          _card(context, 'Pro players',
              'https://statics.sportskeeda.com/editor/2019/07/103b0-15623172658140-500.jpg'),
        ],
      ),
    );
  }
}

Widget _card(BuildContext context, text, img) {
  return SizedBox(
    height: 200,
    child: Card(
      // This ensures that the Card's children are clipped correctly.
      clipBehavior: Clip.antiAlias,
      // shape: shape,
      child: InkWell(
        onTap: () {},
        child: Stack(children: <Widget>[
          Container(
            // color: Colors.red,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: 50,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              color: Colors.black45,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
