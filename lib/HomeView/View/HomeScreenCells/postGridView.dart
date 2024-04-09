import 'package:flutter/material.dart';
import 'package:flutter_application_134/HomeView/Model/HomeApiResponse.dart';


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
                    child: Image.network(data[index].thumbnail ?? "https://st2.depositphotos.com/1006899/8089/i/450/depositphotos_80897014-stock-photo-page-not-found.jpg",
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
