import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/provider/cart_provider.dart';
import 'package:store_app/services/manage_http_response.dart';

import '../../../../models/product_model.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductModel productModel;
   ProductDetailScreen({super.key,required this.productModel});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider=ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Product Detail',
            style:GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){},
              icon:const Icon(Icons.favorite),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 260,
                height: 270,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
        
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top:60,
                        left:0,
                        child: Container(
                          width: 260,
                          height: 250,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0XFFD8DDFF),
                            borderRadius:BorderRadius.circular(130),
                          ),
                        ),
                    ),
                    Positioned(
                        left: 15,
                        top:0,
                        child: Container(
                          height: 280,
                          width: 230,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFF9CA8FF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: SizedBox(
                            height: 300,
                            child: PageView.builder(
                              itemCount: widget.productModel.images.length,
                              scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                return Image.network(widget.productModel.images[index],
                                width: 198,
                                  height: 200,
                                  fit: BoxFit.cover,
                                );
                                }),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.productModel.productName,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color(0xFF3C55Ef),
                    ),
                  ),
                  Text("Rs-${widget.productModel.productPrice.toString()+"/-"}",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Color(0xFF3C55Ef),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.productModel.category,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About",style: GoogleFonts.lato(
                    fontSize: 16,
                    letterSpacing: 1.7,
                    color: const Color(0xFF363330),
                  ),
                  ),
                  Text(widget.productModel.description,
                  style: GoogleFonts.lato(
                    letterSpacing: 1.7,
                    fontSize: 14,
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: (){
          _cartProvider.addProductToCart(
              productName: widget.productModel.productName,
              productPrice: widget.productModel.productPrice,
              category: widget.productModel.category,
              image: widget.productModel.images,
              vendorId: widget.productModel.vendorId,
              productQuantity: widget.productModel.quantity,
              quantity: 1,
              productId: widget.productModel.id,
              description: widget.productModel.description,
              fullName: widget.productModel.fullName,
          );
          showSnackBar(context, widget.productModel.productName);
        },
        child: Container(
          width: 386,
          height: 46,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Color(0xFF3B54EE,),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text("ADD TO CART",style: GoogleFonts.mochiyPopPOne(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
      ),
    );
  }
}
