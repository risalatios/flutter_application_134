import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  // bool _isLoading = true;
  // final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView(
          children: [
             Text(
                  'Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                ),
               SizedBox(height: 12),
                Text(
                  'Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.Taco Bell, fast-food restaurant chain headquartered in Irvine, California, U.S., that offers Mexican-inspired foods, most obviously the taco. Founded in 1962 by American entrepreneur Glen Bell, the chain has more than 7,000 locations and over 350 franchisees worldwide.',
                  style: TextStyle(
                    fontFamily: 'josefinsans_regular',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  maxLines: 1200,
                ),
          ],
        ),
      ),
    );
  }
}
