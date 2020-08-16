import 'package:flutter/material.dart';




class About extends StatelessWidget {
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
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Text(
                'Fresh From Farm :',
                style: TextStyle(
                  color:Colors.deepOrangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 10.0),
          Text(
            'Complete Organic Farming',
            style: TextStyle(
              color:Colors.amberAccent,
              letterSpacing: 1.0,
              fontSize: 20.0,
              
              fontStyle: FontStyle.italic
            ),
          ),
             SizedBox(height: 10.0),
          Text(
            'Home Delivery Free of Cost',
            style: TextStyle(
              color:Colors.amberAccent,
              letterSpacing: 1.0,
              fontSize: 20.0,
              
              fontStyle: FontStyle.italic
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'For Grocery over 100 Kg call on Personal No.',
            style: TextStyle(
              color:Colors.amberAccent,
              letterSpacing: 1.0,
              fontSize: 20.0,
              
              fontStyle: FontStyle.italic
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Delivery Available all over Aurangabad',
            style: TextStyle(
              color:Colors.amberAccent,
              letterSpacing: 1.0,
              fontSize: 20.0,
              
              fontStyle: FontStyle.italic
            ),
          ), 
  
              ],
              ),
        ),
      ),

    );
  }
}

