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
import 'package:farm_fresh/screens/booking.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    List<String> items = new List<String>.generate(cartFood.length, (index) => "Items ${index + 1}");
    Future<void> _refreshList() async {
      getFoods(foodNotifier);
    }

    print("building Feed");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          authNotifier.user != null ? authNotifier.user.displayName : "Feed",
        ),
        centerTitle: true,
        actions: <Widget>[
          // action button
          IconButton(
            onPressed: () => signout(authNotifier),
            icon:Icon(CupertinoIcons.person),
            iconSize: 30,
            color: Colors.amberAccent
          ),
        ],
      ),
      body: new RefreshIndicator(
        child: ListView.builder(
          itemCount: cartFood.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                          child: Dismissible(
                key: Key(items[index]),
                onDismissed: (direction){
                  cartFood.removeAt(index);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Item Removed"),
                  ));
                },
                background: Container(color: Colors.red,),
                            child: ListTile(
                  leading: Image.network(
                    cartFood[index].image != null
                        ? cartFood[index].image
                        : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                    width: 120,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(cartFood[index].name,style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic
                  )),
                  subtitle: Text('${cartFood[index].price} x ${cartFood[index].quantity}',style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic
                  )),
                  onTap: () {
                    foodNotifier.currentFood = cartFood[index];
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return FoodDetail();
                    }));
                  },
                ),
              ),
            );
          },
          
          // separatorBuilder: (BuildContext context, int index) {
          //   return Divider(
          //     color: Colors.white,
          //   );
          // },
        ),
        onRefresh: _refreshList,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Booking()),
              );
        },
        label: Text('Confirm Booking'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.orangeAccent,

        ),
        SizedBox(height:10),
          
          
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


class ListTileItem extends StatefulWidget {
  // String title;
  // ListTileItem({this.title});
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      // title: new Text(widget.title),
      trailing: new Row(
        children: <Widget>[
           _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
            new Text(_itemCount.toString()),
            new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
        ],
      ),
    );
  }
}