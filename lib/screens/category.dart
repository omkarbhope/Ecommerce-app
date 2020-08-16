import 'package:flutter/cupertino.dart';
import 'package:farm_fresh/api/food_api.dart';
import 'package:farm_fresh/notifier/auth_notifier.dart';
import 'package:farm_fresh/notifier/food_notifier.dart';
import 'package:farm_fresh/screens/about.dart';
import 'package:farm_fresh/screens/cart.dart';
import 'package:farm_fresh/screens/detail.dart';
import 'package:farm_fresh/screens/food_form.dart';
import 'package:flutter/material.dart';
import 'package:farm_fresh/screens/phone.dart';
import 'package:farm_fresh/screens/profile.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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

    Future<void> _refreshList() async {
      getFoods(foodNotifier);
    }

    print("building Feed");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          authNotifier.user != null ? authNotifier.user.displayName.toUpperCase() : "Feed",
          style:TextStyle(
                          fontSize:25,
                          color: Colors.black,
                          fontStyle:FontStyle.italic
                        )
        ),
        centerTitle: true,
        actions: <Widget>[
          // action button
          IconButton(
            onPressed: () => signout(authNotifier),
            icon:Icon(CupertinoIcons.person),
            iconSize: 40,
            color: Colors.black,
            
          ),
        ],
      ),
      body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
          delegate: SliverChildListDelegate(
            [
                    SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Fresh",style:TextStyle(
                          fontSize:40,
                          color: Colors.red,
                          fontStyle:FontStyle.italic
                        )),
                      Text(" Farm",style:TextStyle(
                      fontSize:40,
                      color: Colors.black,
                      fontStyle:FontStyle.italic
                    )),
                      
                      ],
                    ),
                 SizedBox(height:30)   
            ],
          ),
        ),
            SliverGrid(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 300.0,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 1.0,
  ),
  delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {
      return GestureDetector(
                    onTap: () {
                          foodNotifier.currentFood = foodNotifier.foodList[index];
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return FoodDetail();
                          }));
                        },
                          child: Container(
                                  width:200,
                                  height:280,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                          child: Column(
                                    children: <Widget>[
                                      Image.network(
                          foodNotifier.foodList[index].image != null
                              ? foodNotifier.foodList[index].image
                              : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                          width: 180,
                          height:115,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('${foodNotifier.foodList[index].name}',style: 
                            TextStyle(
                              color: Colors.black, fontSize: 15
                              ),),
                            Text('Rs. ${foodNotifier.foodList[index].price}',style: 
                            TextStyle(
                              color: Colors.green[700], fontSize: 20
                              ),),
                              
                          ],
                        ),
                        
                        
                                    ],
                                  ), 
                    ),
                                ),
                  );
    },
    childCount: foodNotifier.foodList.length,
  ),
          ),
          ]
),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        
          FloatingActionButton(
            heroTag: 'button 1',
            onPressed: () {
              foodNotifier.currentFood = null;
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return FoodForm(
                    isUpdating: false,
                  );
                }),
              );
            },
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepOrangeAccent,
            
          ),
          SizedBox(height:20),
        ],
      ),
      );
  }
}



class CategoryTile extends StatelessWidget {
  
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
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
              Container(
              alignment: Alignment.center,
              width:300,height:240,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black38,
              ),
              child: Center(
                child: Text(categoryName, style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
              )
            )
          ],
          )
      ),
    );
  }
}
