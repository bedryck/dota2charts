import 'package:flutter/material.dart';
import '../../actions/getPlayersList.dart';
import 'package:provider/provider.dart';
import '../../localData/localData.dart';
import '../../store/store.dart';

class SearchAuth extends StatefulWidget {
  @override
  _SearchAuthState createState() => _SearchAuthState();
}

class _SearchAuthState extends State<SearchAuth> {
  bool isFetching = false;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  List data = [];

  void getUsers() async {
    setState(() {
      isFetching = true;
    });
    var response = await getPlayerList(searchQuery);
    setState(() {
      isFetching = false;
      data = response;
    });
  }

  void _showDialog(id, avatar, name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select this account as your profile"),
          content: ListTile(
            leading: Image.network(avatar, height: 40),
            title: Text(name),
            subtitle: Text('$id'),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Select"),
              onPressed: () {
                Navigator.of(context).pop();

                setUserId("$id");
                Provider.of<UserModel>(context, listen: false).setId("$id");

                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsList = data.map<ListTile>((item) {
      return ListTile(
        leading: Image.network(item['avatarfull'], height: 40),
        title: Text(item['personaname']),
        subtitle: Text('${item['account_id']}'),
        onTap: () {
          _showDialog(
              item['account_id'], item['avatarfull'], item['personaname']);
        },
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : Text('Find your profile'),
        actions: <Widget>[
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    getUsers();
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: isFetching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(shrinkWrap: true, children: itemsList),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Name or id",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) {
        setState(() {
          searchQuery = query;
        });
      },
      onSubmitted: (query) {
        getUsers();
      },
    );
  }
}
