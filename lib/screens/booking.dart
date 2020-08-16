import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:farm_fresh/api/food_api.dart';
import 'package:farm_fresh/model/food.dart';
import 'package:farm_fresh/notifier/auth_notifier.dart';
import 'package:farm_fresh/notifier/food_notifier.dart';
import 'package:farm_fresh/screens/about.dart';
import 'package:farm_fresh/screens/detail.dart';
import 'package:farm_fresh/screens/food_form.dart';
import 'package:flutter/material.dart';
import 'package:farm_fresh/screens/phone.dart';
import 'package:farm_fresh/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}
List<int> amount = [];
List<String> products = [];
List<String> finalList = [];
int totalAmount = 0;
var map = Map();

class _BookingState extends State<Booking> {
  @override
  void initState() {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    List<String> items = new List<String>.generate(cartFood.length, (index) => "Items ${index + 1}");
    Future<void> _refreshList() async {
      getFoods(foodNotifier);
    }

    amount.clear();
    for (Food item in cartFood)
    {
       amount.add(int.parse(item.price));
      print(item.price);
    }
    products.clear();
    for (Food item in cartFood)
    {
       products.add("${item.name} x (${item.subIngredients[0]})");
      print(item.subIngredients[0]);
      print(item.name);
    }

    map.clear();
    products.forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));
    print(map);

    totalAmount = 0;
    for (int e in amount){
      totalAmount += e;
    }
    print(amount.toString());

    finalList.clear();
    map.forEach((K,V) => {
    finalList.add("$K - $V"),
    });

    print("building Feed");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
           "Confirm Booking",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
                      child: Center(
                        child: ListView.builder(
              itemCount: cartFood.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                        title: Text(cartFood[index].name,style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic
                        )),
                        subtitle: Text('${cartFood[index].price} x ${cartFood[index].quantity}',style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic
                        )),
                        onTap: () {},
                    );
              },
            ),
                      ),
          ),
          Text("Total :- $totalAmount",style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontStyle: FontStyle.italic
                      )),
          SizedBox(height:20),
          // Text("To Confirm Booking Take Screenshot and send to 8208191420",style: TextStyle(
          //               fontSize: 20,
          //               color: Colors.grey,
          //               fontStyle: FontStyle.italic
          //             )),
          ButtonTheme(
            minWidth: 200.0,
            height: 50.0,
                      child: RaisedButton(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      customLaunch(
                          'mailto:kewaldmeghale@gmail.com?subject=Farm%20Fresh%20Delivery%20(${authNotifier.user.displayName})&body=Your%20Item%20list:-\n\n\n${finalList.join('\n')}%20\n\n\nTotal:-%20$totalAmount\n\n\n Address:-\n\n${authNotifier.user.photoUrl}\n\n\nThank%20You%20For%20Shopping%20with%20us\nYour%20Order%20will%20be%20delivered%20within%2024%20hours...!!!\n\nCASH%20ON%20DELIVERY');
                    },
                    child: Text('Confirm'),
                    color: Colors.red,
                    textColor: Colors.white,
                    
                  ),
          ),
          SizedBox(height:20),
        ],
      ),
      
      
      );
  }
}



class CategoryTile extends StatelessWidget {
  
  final String imageUrl;
  CategoryTile({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       
      },
          child: Container(
        margin: EdgeInsets.only(right:16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imageUrl,width:300,height:240, fit: BoxFit.cover)
              ),
          ],
          )
      ),
    );
  }
}
