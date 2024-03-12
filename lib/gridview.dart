import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  const Grid({super.key});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  List products = [
    {"Product_name":"AI Avatar Generator","price":"\$200" ,"image_path":'assets/images/ai1.png'},
    {"Product_name":"AI Scene Generator","price":"\$200" ,"image_path":'assets/images/ai2.png'},
    {"Product_name":"AI Anime Generator","price":"\$200" ,"image_path":'assets/images/ai3.png'},
    {"Product_name":"AI Cartoonizer","price":"\$200" ,"image_path":'assets/images/ai4.png'},
    {"Product_name":"AI Generator","price":"\$200" ,"image_path":'assets/images/ai5.png'},
    {"Product_name":"AI Generator","price":"\$200" ,"image_path":'assets/images/ai6.png'},
    // {"Product_name":"AI  Generator","price":"\$200" ,"image_path":'assets/images/1.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
         // mainAxisSpacing: 8,
          crossAxisSpacing: 10,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return
            Container(
          // padding: EdgeInsets.all(10),
            child: Stack(children: [
              Container(
                height: 144,
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    '${products[index]['image_path']}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 90,
                left: 14,
                child: Text(
                  '${products[index]['Product_name']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ]),
          );
        });
  }
}
