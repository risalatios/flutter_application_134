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
import 'package:flutter_application_134/TabbarForApp/ProfileScreen.dart';
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

 late List<Datum> banners = [];
 late List<Datum> postProducts = [];
 late Post? currentPosts;

 String? state;
 String? city;
 String? homeAddress;
 Object? get boutiques => null;
bool _isLoading = false;
bool isCallApiFirstTime = false;

late List<Post> posts = [];

  @override
  void initState() {
    super.initState();
     //getHomeData();
     //  verifyOtp();
     //_fetchLocation();
    getHomeDataNew();
  }



  void getHomeDataNew()async{
     setState(() {
    _isLoading = true; // Show loader when API call starts
  });
    final response = await loginController.getHomeDataNEw();
     if (response["status"] == 200){
        final HomeDataApiResponse apiResponse = HomeDataApiResponse.fromJson(response);
       
           posts = apiResponse.data?.posts ?? [];
            if (apiResponse.data != null && apiResponse.data!.posts != null) {
                posts.forEach((post) {
             switch (post.datatype ?? "") {
               case "category":
               break;
               case "banner":
                 setState(() {
                 banners = post.data ?? [];
                  });
            case "boutique":
            break;
             case "post":
               setState(() {
             postProducts = post.data ?? [];
              });
            case "product":
            break;
            case "Live Stream":
            break;
            default:
           break;
  }
});
} 
     }

      setState(() {
    _isLoading = false; // Hide loader when API call finishes
  });
  
  }

  List<Widget> addWigit(){
  List<Widget> postWidgets = [];

for (var post in posts) {
  if (post.datatype! == "category") {
   
  } else if (post.datatype! == "banner") {
    postWidgets.add(
      Column(
        children: [
          const SizedBox(height: 8),
          BannerCell(banners),
          const SizedBox(height: 8),
        ],
      ),
    );
  } else if (post.datatype! == "boutique") {
  
  } else if (post.datatype! == "post") {
    postWidgets.add(
      Column(
        children: [
          const SizedBox(height: 8),
          postView(post.title!, post.data!),
          const SizedBox(height: 8),
        ],
      ),
    );
  } else if (post.datatype! == "product") {
   
  } else if (post.datatype! == "Live Stream") {
     
  }
}
return postWidgets;
}

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: NavDrawer(),
    drawerScrimColor: Colors.black.withOpacity(0.5),
    appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text(
        'Bringin-',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
       iconTheme: IconThemeData(color: Colors.white),
    ),
    backgroundColor: Colors.black,
    body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          if (posts != [])
         Column(
        children:
         addWigit(),
  ),
       ],
          ),
        ),
      ],
    ),
  );
}


Widget postView(String title, List<Datum> data) {
    return Container(
       height: 380,
     child: Column(
         children: [
           Row(
  children: [
    Expanded(
      child: Divider(
        height: 1,
        color: Colors.grey,
      ),
    ),
     SizedBox(width: 8.0),
      Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
          maxLines: 1,
        ),
      ),
    SizedBox(width: 8.0),
    Expanded(
      child: Divider(
        height: 1,
        color: Colors.grey,
      ),
    ),
  ],
),

          SizedBox(height: 12.0),
         postGridView(data),
            SizedBox(height: 8.0),
              Center(
  child: SizedBox(
    width: MediaQuery.of(context).size.width - 16, 
    child: TextButton(
      onPressed: () {
     
      },
      child: Text('VIEW ALL'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), 
          side: BorderSide(color: Colors.grey), 
        ),
      ),
    ),
  ),
),


         ],

     ),
    );
  }

Widget postGridView(List<Datum> data) {
   return SizedBox(
     height: 280,
     child: GridView.builder(
       shrinkWrap: true,
       scrollDirection: Axis.horizontal,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, crossAxisSpacing: 22, mainAxisSpacing: 22, mainAxisExtent: 140),
       itemCount: data.length, itemBuilder: (BuildContext context, int index) { 
        String boutiqueName = data[index].boutiqueName ?? "";
        String capitalizedText = boutiqueName.split('').map((char) => char.toUpperCase()).join('');
         return GestureDetector(
              onTap: () {
        //        Navigator.of(context).push(
        //      CupertinoPageRoute(
        //           fullscreenDialog: true,
        //           builder: (context) => DetailScreen(item: datat[index]),
                  
        //   ),
        // );
       },    
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.network(data[index].thumbnail!.isNotEmpty
                            ? data[index].thumbnail!
                            : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdh87wRxK1XDWDjCCHi1BHgjkM0wzDRC89bHdndVxgHouG0QGSK_VAKir9rdQNVNm0poA&usqp=CAU",
                          height: 180,
                          width: 140,
                          fit: BoxFit.cover,
                            ),       
                  ),
                  SizedBox(height: 4,),
                   Container(
                          width: 140,
                           child: Text(
                                  "7 days ago", // Product price
                                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                                  maxLines: 1,
                                ),
                         ),
                          SizedBox(height: 4,),
                    Container(
                      width: 150,
                      child: Text(data[index].title ?? "", // Product name
                                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                                  maxLines: 2,
                                ),
                    ),
                     SizedBox(height: 4,),
                     Container( height: 1, 
                                      width: 24,
                                     color: Colors.green,
                             ),
                                        SizedBox(height: 4,),
                           
                         Container(
                          width: 140,
                           child: Text(
                                  capitalizedText, // Product price
                                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                                  maxLines: 1,
                                ),
                         ),
                
                ],
                
              ),
            ),
          ],
           
        ),
        
         );
         
        },
        
     ),
     
   );
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
    state = placemarks.first.administrativeArea ?? 'Fetching...';
    city = placemarks.first.locality ?? '';
     var first = placemarks.first;
      var s =' ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea},${first.thoroughfare}, ${first.subThoroughfare}';
    homeAddress = s;
  
   } else {
  state = 'Fetching..';
  city = '';
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
        //banners = datat.sublist(3, 6); // Extract the first three models
         });
      } else {
           setState(() {
         // banners = datat; // If there are less than three models, use the entire list
            });
      }
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
       // banners = datat.sublist(0, 3); // Extract the first three models
         });
      } else {
           setState(() {
          //banners = datat; // If there are less than three models, use the entire list
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

  


Widget gridViewForNew() {
   return GridView.builder(
     physics: NeverScrollableScrollPhysics(),
     shrinkWrap: true,
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 22, mainAxisSpacing: 22, mainAxisExtent: 320,),
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
                          maxLines: 1,
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
  final List<Datum> bannerArrays;
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
      index * MediaQuery.of(context).size.width,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }


@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width - 16;
  return SizedBox(
    height: 190,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.bannerArrays.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        // Check if imageUrl is not empty
          return Row(
            children: [
              Container(
                height: 190, // Adjust height as needed
                width: screenWidth,
                child: Image.network(
                  widget.bannerArrays[index].bannerUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
            ],
          );
        
      },
    ),
  );
}


}


    // case category = "category"
    // case banner = "banner"
    // case boutique = "boutique"
    // case post = "post"
    // case product = "product"
    // case liveBoutique = "Live Stream"


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


class HomeDataApiResponse {
  final Data? data;
  final int? status;
  final String? msg;

  HomeDataApiResponse({
    this.data,
    this.status,
    this.msg,
  });

  factory HomeDataApiResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return HomeDataApiResponse(data: null, status: null, msg: null);
    }
    return HomeDataApiResponse(
      data: Data.fromJson(json['data']),
      status: json['status'],
      msg: json['msg'],
    );
  }
}

class Data {
  final bool? success;
  final String? summary;
  final List<Post>? posts;

  Data({
    this.success,
    this.summary,
    this.posts,
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Data(success: null, summary: null, posts: null);
    }
    return Data(
      success: json['success'],
      summary: json['summary'],
      posts: (json['data'] as List<dynamic>?)
          ?.map((postJson) => Post.fromJson(postJson))
          .toList(),
    );
  }
}

class Post {
  final String? title;
  final String? datatype;
  final List<Datum>? data;

  Post({
    this.title,
    this.datatype,
    this.data,
  });

  factory Post.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Post(title: null, datatype: null, data: null);
    }
    return Post(
      title: json['title'],
      datatype: json['datatype'],
      data: (json['data'] as List<dynamic>?)
          ?.map((datumJson) => Datum.fromJson(datumJson))
          .toList(),
    );
  }
}

class Datum {
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? boutiqueName;
  final String? email;
  final String? profilePic;
  final String? coverPic;
  final Address? address;
  final List<Products>? products;

  //banner
  final int? id;
  final String? category;
  final int? categoryId;
  final DateTime? validFrom;
  final DateTime? validTo;
  final DateTime? createdAt;
  final String? bannerUrl;
  final String? bannerType;
  //

  Datum({
    this.title,
    this.description,
    this.thumbnail,
    this.boutiqueName,
    this.email,
    this.profilePic,
    this.coverPic,
    this.address,
    this.products,

    //banner
    this.id,
    this.category,
    this.categoryId,
    this.validFrom,
    this.validTo,
    this.createdAt,
    this.bannerUrl,
    this.bannerType,
    //
  });

  factory Datum.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Datum(
        title: null,
        description: null,
        thumbnail: null,
        boutiqueName: null,
        email: null,
        profilePic: null,
        coverPic: null,
        address: null,
        products: null,

        //banner
        id: null,
        category: null,
        categoryId: null,
        validFrom: null,
        validTo: null,
        createdAt: null,
        bannerUrl: null,
        bannerType: null,
      );
    }
    return Datum(
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      boutiqueName: json['boutique_name'],
      email: json['email'],
      profilePic: json['profile_pic'],
      coverPic: json['cover_pic'],
      address: Address.fromJson(json['address']),
      products: (json['products'] as List<dynamic>?)
          ?.map((productJson) => Products.fromJson(productJson))
          .toList(),

      //banner
      id: json['id'],
      category: json['category'],
      categoryId: json['category_id'],
      validFrom: json['valid_from'] != null ? DateTime.parse(json['valid_from']) : null,
      validTo: json['valid_to'] != null ? DateTime.parse(json['valid_to']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      bannerUrl: json['banner_url'],
      bannerType: json['banner_type'],
      //
    );
  }
}

class Address {
  final String? city;
  final String? state;
  final String? line1;
  final String? line2;
  final String? pincode;
  final String? landmark;

  Address({
    this.city,
    this.state,
    this.line1,
    this.line2,
    this.pincode,
    this.landmark,
  });

  factory Address.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Address(city: null, state: null, line1: null, line2: null, pincode: null, landmark: null);
    }
    return Address(
      city: json['city'],
      state: json['state'],
      line1: json['line_1'],
      line2: json['line_2'],
      pincode: json['pincode'],
      landmark: json['landmark'],
    );
  }
}

class Products {
  final String itemName;
  final String? description;
  final String itemMainPic;
  final double itemPrice;
  final String imageUrl;

  Products({
    required this.itemName,
    this.description,
    required this.itemMainPic,
    required this.itemPrice,
    required this.imageUrl,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      itemName: json['item_name'] ?? '',
      description: json['description'],
      itemMainPic: json['item_main_pic'] ?? '',
      itemPrice: (json['item_price'] ?? 0.0).toDouble(),
      imageUrl: json['image_url'] ?? '',
    );
  }
}