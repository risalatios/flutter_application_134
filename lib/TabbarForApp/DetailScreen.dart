import 'package:flutter/material.dart';
import 'package:flutter_application_134/HomeView/Model/HomeApiResponse.dart';

class DetailScreen extends StatelessWidget {
  final Products item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child:Column(
             mainAxisAlignment: MainAxisAlignment.start,
            children: [
           Image.network(item.imageUrl.isNotEmpty ?? false
                        ? item.imageUrl!
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdh87wRxK1XDWDjCCHi1BHgjkM0wzDRC89bHdndVxgHouG0QGSK_VAKir9rdQNVNm0poA&usqp=CAU",
                      fit: BoxFit.cover,
                        ),       
               SizedBox(height: 12),
             
               new Container(
       child: Row(
         children: <Widget>[
            Flexible(
               child: new  Text(item.itemName,style: TextStyle(fontSize: 24),
               textAlign: TextAlign.left,
               ),),
              
                ],
        )),
               SizedBox(height: 6),
               Row(
                 children: [
                   Text("Price: ${item.itemPrice}", style: TextStyle(fontSize: 24)),
                 ],
               ),
               SizedBox(height: 6),
               Text("Description:: ${item.description}", style: TextStyle(fontSize: 18)),
                 SizedBox(height: 44),
            ]
        )
        ),
      ),
    );
  }
}