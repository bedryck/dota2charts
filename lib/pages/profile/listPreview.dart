import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import './listInformContainer.dart';
import '../../store/appSettings.dart';
import 'package:provider/provider.dart';


class ListPreview extends StatelessWidget {
  final String title;
  final List data;
  final InfoType type;
  final String rout;

  ListPreview(this.title, this.data, this.type, this.rout);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

   final heroImgById = Provider.of<AppSettingsModel>(context, listen: false).heroImgById;
   final heroNameById = Provider.of<AppSettingsModel>(context, listen: false).heroNameById;


  List<Widget> itemsList;
  if (type == InfoType.games) {
    itemsList = data.length != 0
        ? data.map<ListTile>((item) {
            String isWin;
            if (item.slot > 127 && !item.radiantWin) {
              isWin = "WIN";
            } else if (item.slot < 128 && item.radiantWin) {
              isWin = "WIN";
            } else {
              isWin = "LOSE";
            }
            return ListTile(
              leading: Image.network(heroImgById('${item.heroId}'), height: 40),
              title: Center(
                  child: Text('${item.kills}/${item.deaths}/${item.assists}')),
              trailing: Text(isWin, style: TextStyle(color: isWin == "WIN" ?  Color(0xff63A375) : Color(0xffD57A66), fontWeight: FontWeight.bold),),
            );
          }).toList()
        : [];
  } else if (type == InfoType.heroes) {
    itemsList = data.length != 0
        ? data.map<ListTile>((item) {
            return ListTile(
              leading: Image.network(heroImgById(item.heroId), height: 40),
              title: Text(heroNameById(item.heroId)),
              subtitle: Row(
                children: <Widget>[Text('${item.games} games'), Text('${proz(item.games, item.win)}% winrate')],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              trailing: Text(''),
            );
          }).toList()
        : [];
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    height: type == InfoType.games ? 220 : 250,
    width: screenSize.width,
    child: Card(
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, rout);
        },
        child: Column(children: <Widget>[
        Container(
          child: Text(title),
          margin: EdgeInsets.only(top: 10),
        ),
        Expanded(
          child: Column(
            
            children: itemsList,
          ),
        )
      ])),
    ),
  );
  }
}