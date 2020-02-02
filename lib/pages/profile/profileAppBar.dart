import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/player.dart';
import '../../ui/rank.dart';
import '../../helpers/helpers.dart';

class ProfileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Profile'),
      // centerTitle: true,
      actions: <Widget>[
        Center(
          child: Consumer<PlayerModel>(
            builder: (context, player, child) {
              return player.value != null &&
                      player.totalsValue != null &&
                      player.countsValue != null
                  ? Container(
                      width: 35.0,
                      height: 35.0,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        image: DecorationImage(
                          image: NetworkImage(player.profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 35.0,
                      height: 35.0,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: Colors.grey));
            },
          ),
        )
      ],
      expandedHeight: 170.0,
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: Consumer<PlayerModel>(builder: (context, player, child) {
        return FlexibleSpaceBar(
          centerTitle: true,
          title: Text(player.profileName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          background: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: Row(
                      children: <Widget>[
                        Image(
                            height: 20, image: AssetImage('images/steam.png')),
                        Text(
                          '  ID: ${player.profileId}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      'Last match: ${player.lastGame == 0 ? "unknown" : when(player.lastGame)} ago',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 32),
                    child: Text(
                      'WIn ratee: ${player.winRate}%',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, top: 14),
                      child: Text(
                        "In game: ${duration(player.totalDuration)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      )),
                ],
              ),
              Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(top: 40, left: 40),
                  child: Rank(
                      rank: player.profileRank,
                      stars: player.profileStars,
                      position: '')),
            ],
          ),
        );
      }),
    );
  }
}
