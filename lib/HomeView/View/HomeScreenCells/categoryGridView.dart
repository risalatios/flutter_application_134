import 'package:flutter/material.dart';
import 'package:flutter_application_134/HomeView/Model/HomeApiResponse.dart';



Widget categoryGridView(List<Datum> data) {
   return SizedBox(
     height: 120,
     child: GridView.builder(
       shrinkWrap: true,
       scrollDirection: Axis.horizontal,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, crossAxisSpacing: 0, mainAxisSpacing: 24, mainAxisExtent: 80),
       itemCount: data.length, itemBuilder: (BuildContext context, int index) { 
        String boutiqueName = data[index].category ?? "";
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(
              height: 80, 
               width: 80,
             child: Image.network(
                     data[index].imageUrl ?? "https://st2.depositphotos.com/1006899/8089/i/450/depositphotos_80897014-stock-photo-page-not-found.jpg",
                     height: 80, 
                     width: 80,
                     fit: BoxFit.cover,
                   ),
           ),
             SizedBox(height: 4,),
                 Text(
                                    capitalizedText, 
                                    style: TextStyle(fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
               
          ],
           
        ),
        
         );
         
        },
        
     ),
     
   );
  }
