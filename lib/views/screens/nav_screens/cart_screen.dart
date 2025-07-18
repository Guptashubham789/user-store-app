import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/provider/cart_provider.dart';
import 'package:store_app/views/screens/detail/screens/checkout_screen.dart';
import 'package:store_app/views/screens/main_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {

    final _cartData=ref.watch(cartProvider);//watch : to desplay item
    final _cartProvider=ref.read(cartProvider.notifier);
    final totalAmount=ref.read(cartProvider.notifier).calculateTotalAmount();
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 118,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/icons/cartb.png',),fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned(
                    left: 322,
                    top: 52,
                    child: Stack(
                      children: [
                        Image.asset('assets/icons/not.png',width: 25,height: 25,),
                        Positioned(
                          top: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              padding:const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade500,
                                borderRadius: BorderRadius.circular(12,),
                              ),
                              child: Center(
                                child: Text(
                                  _cartData.length.toString(),
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                              ),
                            ))
                      ],
                    ),
                ),
                Positioned(
                  left: 61,
                    top: 51,
                    child: Text('My Cart',style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),))
              ],
            ),
          ),
      ),
      body: _cartData.isEmpty?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textAlign: TextAlign.center,'your shopping cart is empty\n you can add product to your cart from the button bellow',
            style: GoogleFonts.roboto(
              fontSize: 14,
              letterSpacing: 1.7,
            ),
            ),
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return MainScreen();
                  }));
                },
                child: Text('Shop Now'),
            ),
          ],
        ),
      ):SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 49,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(

              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                      top: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 49,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Color(0xFFD7DDFF),
                        ),
                      ),
                  ),
                  Positioned(
                    left: 44,
                      top: 19,
                      child: Container(
                        width: 10,
                        height: 10,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                  ),
                  Positioned(
                    left: 69,
                      top: 14,
                      child: Text("You Have ${_cartData.length} items",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.7,
                      ),),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: _cartData.length,
                itemBuilder: (context,index){
                  final cartItem=_cartData.values.toList()[index];
                  return Card(
                    child: SizedBox(
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(cartItem.image[0],fit: BoxFit.cover,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartItem.productName,
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                              Text(cartItem.category,
                              style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 14,
                                ),
                              ),
                              Text("\$${cartItem.productPrice.toStringAsFixed(2)}",
                              style: GoogleFonts.lato(
                                color: Colors.pink,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF102DE1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: (){
                                              _cartProvider.decrementCartItem(cartItem.productId);
                                            },
                                            icon: Icon(CupertinoIcons.minus,color: Colors.white,),
                                        ),
                                        Text(cartItem.quantity.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            _cartProvider.incrementCartItem(cartItem.productId);
                                          },
                                          icon: Icon(CupertinoIcons.plus,color: Colors.white,),
                                        ),
                                      ],
                                    ),

                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  _cartProvider.removeCartItem(cartItem.productId);
                                },
                                icon: Icon(CupertinoIcons.delete,),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration:const BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 416,
                height: 89,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFC4C4C4,),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.93, -0.26),
              child: Text('Subtotal ',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA1A1A1,),
              ),
              ),
            ),
            Align(
              alignment: Alignment(-0.39, -0.31),
              child: Text("\$ ${totalAmount.toString()}",
              style: GoogleFonts.roboto(
                color: Color(0xFFFF6464,),
              ),),
            ),
            Align(
              alignment: Alignment(0.83, -1),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CheckoutScreen();
                  }));
                },
                child: Container(
                  width: 166,
                  height: 71,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color:totalAmount==0.0?Colors.grey: const Color(0xFF1532E7,),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Checkout",style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_forward,color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
