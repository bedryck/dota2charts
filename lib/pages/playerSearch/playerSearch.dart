import 'package:flutter/material.dart';
import '../../actions/getPlayersList.dart';
import 'package:provider/provider.dart';
import '../../localData/localData.dart';
import '../../store/store.dart';

class PlayerSearch extends StatefulWidget {
  @override
  _PlayerSearchState createState() => _PlayerSearchState();
}

class _PlayerSearchState extends State<PlayerSearch> {
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

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsList = data.map<ListTile>((item) {
      return ListTile(
        leading: Image.network(item['avatarfull'], height: 40),
        title: Text(item['personaname']),
        subtitle: Text('${item['account_id']}'),
        onTap: () {},
      );
    }).toList();

    return Scaffold(
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
