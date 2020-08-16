import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:farm_fresh/screens/category.dart';
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


List<String> images = ['asset/1.jpg', 'asset/2.jpg', 'asset/3.jpg', 'asset/4.jpg'];
List<String> category = ['FRESH FROM FARM', '100% ORGANIC FARMING', 'HEALTHY & NUTRITIOUS', 'CHEAPEST PRICES'];
List<String> myfoods = ['Rice','Fruits','Vegetables','Grains_Pulses','Pulses','Oil_seeds','Sweetners','Ghee','Salt','Spices','Dry_Fruits'];
List<String> imageList = ['https://www.pngarts.com/files/3/White-Rice-PNG-Image-with-Transparent-Background.png',
'https://www.freepngimg.com/thumb/fruit/4-2-fruit-png-image.png',
'https://www.freepngimg.com/thumb/vegetable/24552-2-vegetable-clipart.png',
'https://i.dlpng.com/static/png/329756_preview.png',
'https://img.pngio.com/peanut-vegetarian-cuisine-food-bean-sprouts-cannellini-beans-png-pulses-png-900_540.jpg',
'https://img.favpng.com/7/0/16/indian-cuisine-mustard-plant-mustard-seed-mustard-oil-seed-oil-png-favpng-KEvpXjm7K8Aivx6CT6YS9dqjn.jpg',
'https://img2.pngio.com/jaggery-png-1-png-image-jaggery-png-434_288.png',
'https://www.pngjoy.com/pngl/102/2127823_butter-cow-ghee-transparent-png.png',
'https://www.netclipart.com/pp/m/5-57558_salt-vector-free-png-download-image-transparent-background.png',
'https://pngimage.net/wp-content/uploads/2018/06/herbs-and-spices-png-1.png',
'https://www.pngitem.com/pimgs/m/121-1215585_dry-fruits-png-transparent-dry-fruits-png-png.png'];
String foodName = "";
class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
                          color: Colors.white,
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
              Container(
                      padding: EdgeInsets.symmetric(horizontal:16,vertical:16),
                      height: 240,
                      child: ListView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return CategoryTile(
                            imageUrl: images[index],
                            categoryName: category[index],
                          );
                        })
                    ),
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
                         foodName = myfoods[index];
                         Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Category()),
                              ); 
                        },
                          child: Container(
                                  width:150,
                                  height:100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                          child: Stack(
                                    children: <Widget>[
                                      SizedBox(height: 10,),
                                      Image.network(
                                        imageList[index],           
                          fit: BoxFit.cover,
                        ),
                        Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black38,
              ),
              child: Center(
                child: Text(myfoods[index], style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
              )
            )
                                    ],
                                  ), 
                    ),
                                ),
                  );
    },
    childCount: myfoods.length,
    
  ),
          ),
          ]
),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
        onPressed: (){
          
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
              );
        },
        label: Text('Cart'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.orangeAccent,

        ),
        SizedBox(height:10),
          
        ],
      ),
      bottomNavigationBar: BubbledNavigationBar(
  defaultBubbleColor: Colors.amberAccent,
  onTap: (index) {
    if (index == 1){
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Phone()),
    );
    }
    if(index == 2){
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => About()),
    );
    }
    if(index == 3){
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Profile()),
    );
    }
  },
  items: <BubbledNavigationBarItem>[
            BubbledNavigationBarItem(
              icon:       Icon(CupertinoIcons.home, size: 30, color: Colors.red),
              activeIcon: Icon(CupertinoIcons.home, size: 30, color: Colors.black),
              title: Text('Home', style: TextStyle(color: Colors.black, fontSize: 12),),
            ),
            BubbledNavigationBarItem(
              icon:       Icon(CupertinoIcons.phone, size: 30, color: Colors.pinkAccent),
              activeIcon: Icon(CupertinoIcons.phone, size: 30, color: Colors.black),
              title: Text('Phone', style: TextStyle(color: Colors.black, fontSize: 12),),
            ),
            BubbledNavigationBarItem(
              icon:       Icon(CupertinoIcons.info, size: 30, color: Colors.blue[50]),
              activeIcon: Icon(CupertinoIcons.info, size: 30, color: Colors.black),
              title: Text('Info', style: TextStyle(color: Colors.black, fontSize: 12),),
            ),
            BubbledNavigationBarItem(
              icon:       Icon(CupertinoIcons.profile_circled, size: 30, color: Colors.redAccent[400]),
              activeIcon: Icon(CupertinoIcons.profile_circled, size: 30, color: Colors.white),
              title: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 12),),
            ),
  ],
  backgroundColor: Colors.greenAccent[700],
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
