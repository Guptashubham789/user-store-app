import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/views/screens/detail/screens/product_detail_screen.dart';

import '../../../../models/product_model.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel productModel;
   ProductItemWidget({super.key,required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProductDetailScreen(productModel: productModel);
              }));
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.network(productModel.images[0],height: 150,width: 150,fit: BoxFit.cover,),
                  Positioned(
                    top: 10,
                      right: 4,
                      child: Image.asset('assets/icons/love.png',width: 22,height: 22,)
                  ),
                  Positioned(
                    bottom: 10,
                      right:4,
                      child: Image.asset('assets/icons/cart.png',height: 22,width: 22,)),
                ],
              ),
            ),
          ),
         const SizedBox(height: 5,),
          Text(productModel.productName,overflow:TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 13,color:const Color(0xFF212121),fontWeight: FontWeight.bold),),
         const SizedBox(height: 5,),
          Text(productModel.category,style: GoogleFonts.quicksand(
            fontSize: 11,
            color: const Color(0xff868D94,),
            fontWeight: FontWeight.bold,
          ),)
        ],
      ),
    );
  }
}
