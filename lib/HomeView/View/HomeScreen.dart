import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_134/HomeView/Model/HomeApiResponse.dart';
import 'package:flutter_application_134/HomeView/View/HomeScreenCells/BannerCell.dart';
import 'package:flutter_application_134/TabbarForApp/AboutUsScreen.dart';
import 'package:flutter_application_134/TabbarForApp/DetailScreen.dart';
import 'package:flutter_application_134/TabbarForApp/LoginController.dart';
import 'package:flutter_application_134/TabbarForApp/PrivacyPolicyScreen.dart';
import 'package:flutter_application_134/TabbarForApp/ProfileScreen.dart';
import 'package:flutter_application_134/TabbarForApp/SessionManager.dart';
import 'package:flutter_application_134/TabbarForApp/TermsAndConditionScreen.dart';
import 'package:flutter_application_134/HomeView/View/HomeScreenCells/boutiqueGridView.dart';
import 'package:flutter_application_134/HomeView/View/HomeScreenCells/categoryGridView.dart';
import 'package:flutter_application_134/HomeView/View/HomeScreenCells/postGridView.dart';
import 'package:flutter_application_134/HomeView/View/HomeScreenCells/productGridView.dart';
import 'package:flutter_application_134/HomeView/ViewModel/ViewModel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../TabbarForApp/LoginScreen.dart'; 
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';



class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

var viewModel = ViewModel();

  @override
  void initState() {
    super.initState();
     //getHomeData();
     //  verifyOtp();
     //_fetchLocation();
  // viewModel.getHomeData();
   getHomeDataNew();
  }



  void getHomeDataNew()async{
    final response = await loginController.getHomeDataNEw();
     if (response["status"] == 200){
        final HomeDataApiResponse apiResponse = HomeDataApiResponse.fromJson(response);
        setState(() {
          viewModel.posts = apiResponse.data?.posts ?? [];

        });
          
           
} 
  }


  List<Widget> addWigit(){
  List<Widget> postWidgets = [];

for (var post in viewModel.posts) {
  if (post.datatype! == "category") {
   postWidgets.add(
      Column(
        children: [
          const SizedBox(height: 8),
          catView(post.title!, post.data ?? []),
          const SizedBox(height: 8),
        ],
      ),
    );
  } else if (post.datatype! == "banner") {
    postWidgets.add(
      Column(
        children: [
          const SizedBox(height: 8),
          BannerCell(post.data ?? []),
          const SizedBox(height: 8),
        ],
      ),
    );
  } else if (post.datatype! == "boutique") {
    postWidgets.add(
      Column(
        children: [
          const SizedBox(height: 8),
          boutiqueView(post.title!, post.data ?? []),
          const SizedBox(height: 8),
        ],
      ),
    );
  } else if (post.datatype! == "post") {
    postWidgets.add(
      Column(
        children: [
          const SizedBox(height: 8),
          postView(post.title!, post.data ?? []),
          const SizedBox(height: 8),
        ],
      ),
    );
  } else if (post.datatype! == "product") {
     postWidgets.add(
      Column(
        children: [
          const SizedBox(height: 8),
          productView(post.title!, post.data ?? []),
          const SizedBox(height: 8),
        ],
      ),
    );
   
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
          if (viewModel.posts != [])
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

Widget productView(String title, List<Datum> data) {
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
          style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
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
         productGridView(data),
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
          style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
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



Widget catView(String title, List<Datum> data) {
    return Container(
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
          style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
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
         categoryGridView(data),
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



Widget boutiqueView(String title, List<Datum> data) {
    return Container(
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
          style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
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
         boutiqueGridView(data),
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
    viewModel.state = placemarks.first.administrativeArea ?? 'Fetching...';
    viewModel.city = placemarks.first.locality ?? '';
     var first = placemarks.first;
     //var s =' ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea},${first.thoroughfare}, ${first.subThoroughfare}';

  
   } else {
  viewModel.state = 'Fetching..';
  viewModel.city = '';
  }

      });
    } catch (e) {
      print('Error fetching location: $e');
      setState(() {
      viewModel.state = 'Fetching..';
      viewModel.city = 'Fetching';
      });
    }
  }

  
Widget _buildLoader() {
  return viewModel.isLoading
      ? Center(
          child: CircularProgressIndicator(),
        )
      : SizedBox.shrink();
}

  

}


