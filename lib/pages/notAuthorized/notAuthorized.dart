import 'package:flutter/material.dart';

class NotAuthorized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not authorized'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'It looks like you are not authorized. Login using your Steam account. It will take several minutes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            ),
            FlatButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              child: Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(height: 30, image: AssetImage('images/steam.png')),
                    Text('Steam Authorization')
                  ],
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/steamAuth');
              },
            ),
            Text(
              '- or -',
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              child: Container(
                height: 30,
                padding: EdgeInsets.only(left: 20),
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.search),
                      padding: EdgeInsets.only(right: 15),
                    ),
                    Text('From search')
                  ],
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/searchAuth');
              },
            )
          ],
        ),
      ),
    );
  }
}
