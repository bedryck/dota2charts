import 'package:flutter/material.dart';
import '../../actions/getPlayersList.dart';
import './playerMain.dart';

class PlayerSearch extends StatefulWidget {
  @override
  _PlayerSearchState createState() => _PlayerSearchState();
}

class _PlayerSearchState extends State<PlayerSearch> {
  bool isFetching = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";
  bool isError = false;

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

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsList = data.map<ListTile>((item) {
      return ListTile(
        leading: Image.network(item['avatarfull'], height: 40),
        title: Text(item['personaname']),
        subtitle: Text('${item['account_id']}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerMain(item['account_id'])),
          );
        },
      );
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : Text('Find player'),
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
                              'Find player',
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
