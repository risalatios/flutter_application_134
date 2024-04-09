import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_134/HomeView/Model/HomeApiResponse.dart';
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
