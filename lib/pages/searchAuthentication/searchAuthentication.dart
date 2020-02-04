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
  bool isError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List data = [];

  void getUsers() async {
    try {
      setState(() {
        isFetching = true;
        isError = false;
      });
      var response = await getPlayerList(searchQuery);
      setState(() {
        isFetching = false;
        data = response;
      });
    } catch (e) {
      setState(() {
        isError = true;
        isFetching = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
        duration: Duration(seconds: 5),
      ));
    }
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
      key: _scaffoldKey,
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
      body: isError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Color(0xffD57A66),
                    size: 30.0,
                    semanticLabel: 'Error',
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        ' Oops something went wrong... try later',
                        style: TextStyle(color: Color(0xffD57A66)),
                      )),
                ],
              ),
            )
          : isFetching
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : itemsList.length != 0
                  ? ListView(shrinkWrap: true, children: itemsList)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Find yourself',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          FlatButton(
                            textColor: Theme.of(context).accentColor,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(9.0),
                            child: Container(
                              height: 30,
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Search',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _isSearching = true;
                              });
                            },
                          )
                        ],
                      ),
                    ),
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
