import 'package:flutter/material.dart';




class Phone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Farm'),
            Text('Fresh', style: TextStyle(
              color: Colors.amberAccent,
            ))
          ]
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1505489435671-80a165c60816?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1431&q=80'),
                radius: 60.0,
              ),
            ),
            Divider(
              height: 90,
              color: Colors.blueGrey[500],
            ),
            Text(
              'NAME',
              style: TextStyle(
                color:Colors.blueGrey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
        Text(
          'Kewal Meghale',
          style: TextStyle(
            color:Colors.amberAccent,
            letterSpacing: 1.0,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.amberAccent,
            ),
                SizedBox(width: 10.0),
              Text(
                'kewaldmeghale@gmail.com',
                style: TextStyle(
                color:Colors.blueGrey,
                letterSpacing: 1.0,
                fontSize: 20.0,
              ),
              )
              
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
              Icon(
                  Icons.call,
                  color: Colors.amberAccent,
            ),
                SizedBox(width: 10.0),
              Text(
                '9527175022',
                style: TextStyle(
                color:Colors.blueGrey,
                letterSpacing: 1.0,
                fontSize: 20.0,
              ),
              )
              
              ],
            ),
            ],
            ),
      ),

    );
  }
}

