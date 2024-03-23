import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_134/TabbarForApp/LoginController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart'; 
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
 List<String> dataList = [
    'https://graphicsfamily.com/wp-content/uploads/edd/2023/05/Website-Food-Banner-Design-scaled.jpg', // Replace with your image paths
    'https://graphicsfamily.com/wp-content/uploads/edd/2022/02/Free-Food-Advertising-Banner-Template.jpg',
    'https://graphicsfamily.com/wp-content/uploads/edd/2023/05/Website-Food-Banner-Design-scaled.jpg',
    
  ];

  final List<String> urlsForImages = [
    'https://66b4fb5b0eb079420f42-f8d2ee6acac1b4bd28ecd85cc6789b99.ssl.cf1.rackcdn.com/_Mexican-Taco-Donner-and-Beer.jpg',
    'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/08/1-7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe5W6ynE_fByk_nF0ijV9pog8F170LFojTJH0dh6d3agrNeSlmYIl89qMA0I6BVjjENEM&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQdSjvxbDEZe84MfWZeOXf06tgdmInOoBga3FMwFGrfdzG2EhgWqOSGN9u48JXwBezRgY&usqp=CAU',
    'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/08/1-7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe5W6ynE_fByk_nF0ijV9pog8F170LFojTJH0dh6d3agrNeSlmYIl89qMA0I6BVjjENEM&usqp=CAU',
    'https://media.istockphoto.com/id/459396345/photo/taco.jpg?s=612x612&w=0&k=20&c=_yCtd6OEb2L8xNal4kC1xvm8HoBp8sry6tcBwmxmPHw=',
    'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/08/1-7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe5W6ynE_fByk_nF0ijV9pog8F170LFojTJH0dh6d3agrNeSlmYIl89qMA0I6BVjjENEM&usqp=CAU',
    'https://media.istockphoto.com/id/459396345/photo/taco.jpg?s=612x612&w=0&k=20&c=_yCtd6OEb2L8xNal4kC1xvm8HoBp8sry6tcBwmxmPHw=',
    'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/08/1-7.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe5W6ynE_fByk_nF0ijV9pog8F170LFojTJH0dh6d3agrNeSlmYIl89qMA0I6BVjjENEM&usqp=CAU',
  ];

  @override
  void initState() {
    super.initState();
     //getHomeData();
     postWithToken();
  }
   void getHomeData()async{
    final response = await loginController.getHomeData();
     if (response["status"] == 200){
       
     }else{
      String message = "verify otp failed used valid otp";
      MyDialogUtils.showDialogBox(context, message);
     }
     print(response);
     
  }



Future<void> postWithToken() async {
  // Get token from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //var token = prefs.getString('token');
  var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcGFyYXMtbGFicy5seXhlbGFuZGZsYW1pbmdvdGVjaC5pbi9hcGkvdmVyaWZ5b3RwIiwiaWF0IjoxNzExMTI3NTM3LCJleHAiOjE3MTExMzExMzcsIm5iZiI6MTcxMTEyNzUzNywianRpIjoiNHNaVnJFODdpQVdZdjY1ViIsInN1YiI6IjI1NCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.I4C7jdyZfen_SSwm4p2kVEblDyz5zb5_qKJPmwcMwbc";
  print('Token: $token');

  if (token == null) {
    // Handle case where token is not available
    print('Token not available');
    return;
  }

  // API endpoint URL
  String apiUrl = 'http://paras-labs.lyxelandflamingotech.in/api/enableBiometric';

  // Request headers with token
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

// Request body parameters
  Map<String, dynamic> body = {
  'mobile': '2222222222',
  'otp': '111111',
  // 'products': [
  //   {
  //     'productId': 1,
  //     'productName': 'Product 1',
  //     'quantity': 2,
  //   },
  //   {
  //     'productId': 2,
  //     'productName': 'Product 2',
  //     'quantity': 1,
  //   },
    // Add more products as needed
 // ],
};


  // Encode the request body as JSON
  String requestBody = json.encode(body);


  // Make the POST request
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: requestBody,
    );

    if (response.statusCode == 201) {
      // Request successful, new resource created
      print('Request successful: ${response.body}');
    } else {
      // Request failed, handle error
      print('Request failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    // Error making request
    print('Error making POST request: $e');
  }
}


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
                    'Taco Banners',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                ),
                  SizedBox(height: 8),
                BannerCell(dataList),
                 SizedBox(height: 8),
                Text(
                    'Taco Products',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                ),
                  SizedBox(height: 8),
                SizedBox(
                  height: urlsForImages.length * 100, // Set the desired height of the grid
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: VerticalGridScreen(urlsForImages),
                  ),
                ),
              ],
          ),
        ),
      ],
    ),
  );
}

}

//
class BannerCell extends StatefulWidget {
  final List<String> bannerArrays;
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
        _currentIndex = (_currentIndex + 1) % widget.bannerArrays.length;
        _scrollToIndex(_currentIndex);
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
          return Row(
            children: [
              Container(
                width: screenWidth - 16,
                child: Image.network(
                  widget.bannerArrays[index],
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
            ],
          );
        },
      ),
    );
  }
}


class VerticalGridScreen extends StatelessWidget {

   final List<String> imageUrls;
  VerticalGridScreen(this.imageUrls);

  @override
 Widget build(BuildContext context) {
  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Two items per row
      mainAxisSpacing: 16.0, // Spacing between rows
      crossAxisSpacing: 16.0, // Spacing between columns
    ),
    scrollDirection: Axis.vertical,
    itemCount: imageUrls.length,
    itemBuilder: (BuildContext context, int index) {
      return GridTile(
        child: Container(
           child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
         
        ),
      );
    },
  );
}

}
