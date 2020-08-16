import 'package:farm_fresh/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:farm_fresh/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

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
          child: SingleChildScrollView(
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
      Center(
        child: CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1521249714975-0dc51f3c5952?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80'),
            radius: 60.0,
        ),
      ),
      Divider(
        height: 90,
        color: Colors.blueGrey[500],
      ),
      Text(
        'NAME :- ${authNotifier.user.displayName}',
        style: TextStyle(
            color:Colors.black,
            letterSpacing: 2.0,
            fontSize: 20.0,
            fontStyle: FontStyle.italic
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
            '${authNotifier.user.email}',
            style: TextStyle(
            color:Colors.black,
            letterSpacing: 1.0,
            fontSize: 18.0,
            fontStyle: FontStyle.italic
        ),
        )
        
        ],
      ),
      SizedBox(height: 30.0),
        Text(
            'Address:-',
            style: TextStyle(
            color:Colors.black,
            letterSpacing: 1.0,
            fontSize: 18.0,
            fontStyle: FontStyle.italic
        ),
        ),

        Text(
            '${authNotifier.user.photoUrl}',
            style: TextStyle(
            color:Colors.black,
            letterSpacing: 1.0,
            fontSize: 18.0,
            fontStyle: FontStyle.italic
        ),
        ),
      SizedBox(height: 60.0),
      Center(
        child: ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
                        child: RaisedButton(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart()),
                        );
                      },
                      child: Text('Go To Cart'),
                      color: Colors.red,
                      textColor: Colors.white,
                      
                    ),
            ),
      ),
      ],
      ),
          ),
        ),

    );
  }
}

