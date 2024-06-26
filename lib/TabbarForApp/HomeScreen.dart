import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_134/TabbarForApp/AboutUsScreen.dart';
import 'package:flutter_application_134/TabbarForApp/DetailScreen.dart';
import 'package:flutter_application_134/TabbarForApp/LoginController.dart';
import 'package:flutter_application_134/TabbarForApp/PrivacyPolicyScreen.dart';
import 'package:flutter_application_134/TabbarForApp/SessionManager.dart';
import 'package:flutter_application_134/TabbarForApp/TermsAndConditionScreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart'; 
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';



class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

 late List<Products> datat = [];
 late List<Products> banners = [];
 String? state;
 String? city;
 String? homeAddress;
 Object? get boutiques => null;
bool _isLoading = false;
  @override
  void initState() {
    super.initState();
     //getHomeData();
       verifyOtp();
     _fetchLocation();
     print("calledd,");
  }
  

 Future<void> _fetchLocation() async {
    try {
      // Get the current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high,
        );

       
      // Reverse geocoding to get address information
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      // Extract state and city from the address
      setState(() {
     
    if (placemarks.isNotEmpty) {
    state = placemarks.first.administrativeArea ?? 'Unknown';
    city = placemarks.first.locality ?? 'Unknown';
     var first = placemarks.first;
      var s =' ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea},${first.thoroughfare}, ${first.subThoroughfare}';
    homeAddress = s;
  
   } else {
  state = 'Unknown';
  city = 'Unknown';
  }

      });
    } catch (e) {
      print('Error fetching location: $e');
      setState(() {
        state = 'Unknown';
        city = 'Unknown';
      });
    }
  }



List<Products> getLastNItemsFromModelList(List<Products> list, int n) {
  if (list.length <= n) {
    return List<Products>.from(list);
  }
  return list.sublist(list.length - n);
}

  
   void verifyOtp()async{
     setState(() {
    _isLoading = true; // Show loader when API call starts
  });
    final response = await loginController.getHomeData();
     if (response["status"] == 200){
        //final Map<String, dynamic> responseData = jsonDecode(response);
        final ApiResponse apiResponse = ApiResponse.fromJson(response);
          print("hello");
        print(apiResponse.dataList[2].imageUrl);
        setState(() {
           List<Products> last10Items = getLastNItemsFromModelList(apiResponse.dataList, 50);
         datat = last10Items;
        });

       if (datat.length >= 3) {
           setState(() {
        banners = datat.sublist(3, 6); // Extract the first three models
         });
      } else {
           setState(() {
          banners = datat; // If there are less than three models, use the entire list
            });
      }
     }else{
      String message = "verify otp failed used valid otp";
      MyDialogUtils.showDialogBox(context, message);
     }
      setState(() {
    _isLoading = false; // Hide loader when API call finishes
  });
     print(response);

     
  }

Future<ApiResponse?> getHomeData() async {
  final String apiUrl = 'http://165.232.191.15/api/v1/bazaar/homepage/dynamic/';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
       'TOKEN': '$token', // Add the token to the headers
      'Content-Type': 'application/json', // Example content type, adjust as needed
      },
      body: jsonEncode({
        'limit': 15,
       'offset': 0,
       'title': "Latest Products",
       'filter_ids': {}, 
      }),
    );

    if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final ApiResponse apiResponse = ApiResponse.fromJson(responseData);
          print("hello");
        print(apiResponse.dataList[2].imageUrl);
        setState(() {
         datat = apiResponse.dataList;
        });

       if (datat.length >= 3) {
           setState(() {
        banners = datat.sublist(0, 3); // Extract the first three models
         });
      } else {
           setState(() {
          banners = datat; // If there are less than three models, use the entire list
            });
      }
    } else {
      // Handle error response
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Widget _buildLoader() {
  return _isLoading
      ? Center(
          child: CircularProgressIndicator(),
        )
      : SizedBox.shrink();
}

  @override
  Widget build(BuildContext context) {
  return Scaffold(
     drawer: NavDrawer(),
     drawerScrimColor: Colors.black.withOpacity(0.5),
      appBar: AppBar(
        title:  Text(
                    'Bringin-',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
                ),
      ),
    backgroundColor: Colors.black,
    body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Row(
                  children: [
                   Text(
                    'Location-',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: Colors.white)
                ),
                  SizedBox(width: 8),
                    Text(
                    '$state, ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue)
                ),
          
              Text(
                    '$city',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: Colors.blue)
                ),
              SizedBox(width: 8),
                  ],
            ),
          
             Text(
                    'Bringin Banners',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white)
                ),
                  SizedBox(height: 8),
                  BannerCell(banners),
                 SizedBox(height: 8),
                Text(
                    'Bringin Products',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white)
                ),
                  SizedBox(height: 8),
             Padding(
               padding: const EdgeInsets.all(6.0),
               child: gridViewForNew(),
             ),
               _buildLoader(),
              ],
          ),
        ),
      ],
    ),
  );
}

Widget gridViewForNew() {
   return GridView.builder(
     physics: NeverScrollableScrollPhysics(),
     shrinkWrap: true,
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 22, mainAxisSpacing: 22, mainAxisExtent: 310,),
     itemCount: datat.length, itemBuilder: (BuildContext context, int index) { 
       return GestureDetector(
            onTap: () {
             Navigator.of(context).push(
           CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => DetailScreen(item: datat[index]),
                
        ),
      );
  },    
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                 topRight: Radius.circular(12),
                 ),
              child: Image.network(datat[index].imageUrl?.isNotEmpty ?? false
                      ? datat[index].imageUrl!
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdh87wRxK1XDWDjCCHi1BHgjkM0wzDRC89bHdndVxgHouG0QGSK_VAKir9rdQNVNm0poA&usqp=CAU",
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                      ),       
            ),
               Padding(
                 padding: const EdgeInsets.only(left: 8),
                 child: Text(
                          datat[index].itemName, // Product name
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                             color: Colors.white,
                          
                             
                          ),
                          maxLines: 2,
                        ),
               ),
                Padding(
                padding: const EdgeInsets.only(left: 8),
                  child: Container(
                                height: 2, 
                                width: 44,
                               color: Colors.green,
                                 ),
                ),
                     
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Price: ${datat[index].itemPrice}", // Product price
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),

                       Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Description: ${datat[index].description}", // Product price
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                        ),
                      ),
                 
          ],
          
        ),
      ),
       );
      },
    
   );
  }

}



//
class BannerCell extends StatefulWidget {
  final List<Products> bannerArrays;
  BannerCell(this.bannerArrays);
  
  @override
  _BannerCellState createState() => _BannerCellState();
}

class _BannerCellState extends State<BannerCell> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

 void _startAutoScroll() {
  _timer = Timer.periodic(Duration(seconds: 3), (timer) {
    setState(() {
      if (widget.bannerArrays.length > 0) { // Check if bannerArrays is not empty
        _currentIndex = (_currentIndex + 1) % widget.bannerArrays.length;
        _scrollToIndex(_currentIndex);
      }
    });
  });
}


  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * MediaQuery.of(context).size.width - 16,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return SizedBox(
    height: 180,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.bannerArrays.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        // Check if imageUrl is not empty
        if (widget.bannerArrays[index].imageUrl.isNotEmpty) {
          return Row(
            children: [
              Container(
                height: 180, // Adjust height as needed
                width: screenWidth - 16,
                child: Image.network(
                  widget.bannerArrays[index].imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 12),
            ],
          );
        } else {
          // If imageUrl is empty, return an empty SizedBox
          return SizedBox();
        }
      },
    ),
  );
}


}




class ApiResponse {
  final bool success;
  final String summary;
  final List<Products> dataList;

  ApiResponse({
    required this.success,
    required this.summary,
    required this.dataList,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['data']['success'] ?? false,
      summary: json['data']['summary'] ?? '',
      dataList: (json['data']['data'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class Products {
  final String itemName;
  final String description;
  final String itemMainPic;
  final double itemPrice;
  final String imageUrl;

  Products({
    required this.itemName,
    required this.description,
    required this.itemMainPic,
    required this.itemPrice,
    required this.imageUrl,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      itemName: json['item_name'] ?? '',
      description: json['description'] ?? '',
      itemMainPic: json['item_main_pic'] ?? '',
      itemPrice: (json['item_price'] ?? 0.0).toDouble(),
      imageUrl: json['image_url'] ?? '',
    );
  }
}




class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Bringin',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/loginback.png'),
                  
                    )),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {
             Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            
            title: Text('Privacy Policy'),
            onTap: () => {  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Terms & Conditions'),
            onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TermsAndConditionScreen()),
            )
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('About Us'),
            onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsScreen()),
            )
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
               showMyAlertDialog(
              context,
              "Alert",
              "Are you sure you want to logout",
            ),
              },
          ),
        ],
      ),
    );
  }
}

void showMyAlertDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
            SessionManager.isLoginSave("false");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
            },
            child: Text("YES"),
          ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("NO"),
          ),
        ],
      );
    },
  );
}