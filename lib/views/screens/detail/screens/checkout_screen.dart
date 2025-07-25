import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/provider/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectPaymentMethod='stripe';
  @override
  Widget build(BuildContext context) {
    final cartData=ref.read(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){

              },
              child: SizedBox(
                width: 335,
                height: 80,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                        top: 0,
                        child: Container(
                          width: 335,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFEFF0F2,),
                            ),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          
                        ),
                    ),
                   Positioned(
                      left: 60,
                        top: 15,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -1,
                                  top: -1,
                                  child: SizedBox(
                                    width: 219,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            width: 114,
                                            child: Text('Add Address',
                                            style: TextStyle(
                                              fontSize: 14,
                                              height: 1.1,

                                            ),),
                                          ),
                                        ),
                                        const SizedBox(height: 4,),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('India',style:GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.3
                                          ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Enter city",
                                          style:
                                            GoogleFonts.lato(
                                              color:const Color(0xFF7F808C,),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                   ),
                    Positioned(
                        left: 16,
                        top: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 43,
                                    height: 43,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFB7F5,),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.hardEdge,
                                      children: [
                                        Positioned(
                                            left: 11,
                                            top: 11,
                                            child: Image.network(
                                                height: 26,
                                                width: 26,
                                              'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png')
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),

                    ),
                    Positioned(
                      left: 300,
                        top: 25,
                        child: Image.network(height: 20,width: 20,
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a'
                        ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('Your Item',style: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            Flexible(
                child: ListView.builder(
                  itemCount: cartData.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                    final cartItem=cartData.values.toList()[index];
                    return InkWell(
                      onTap: (){
                      },
                      child: Container(
                        width: 336,
                        height: 91,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFFEFF0F2,),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Positioned(
                              left: 6,
                                top: 6,
                                child: SizedBox(
                                  width: 311,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 78,
                                        height: 78,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFBCC5FF,),
                                        ),
                                        child: Image.network(cartItem.image[0]),
                                      ),
                                      const SizedBox(width: 11,),
                                      Expanded(
                                          child: Container(
                                            height: 78,
                                            alignment: Alignment(0, -0.51),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(cartItem.productName,
                                                    style: GoogleFonts.quicksand(
                                                      fontWeight: FontWeight.bold,
                                                      letterSpacing: 1.3,

                                                    ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(cartItem.category,style: GoogleFonts.lato(
                                                      color: Colors.blueGrey,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400
                                                    ),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(cartItem.productPrice.toStringAsFixed(2),
                                        style: GoogleFonts.robotoSerif(
                                          fontSize: 14,
                                          color: Colors.pink,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),

                      ),
                    );
                    }
                ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Choose Payment Method',style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            ),
            RadioListTile<String>(
              title: Text("Stripe",style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),),
                value: 'stripe',
                groupValue: selectPaymentMethod,
                onChanged: (String? value){
                setState(() {
                  selectPaymentMethod=value!;
                });
                }
            ),
            RadioListTile<String>(
              //subtitle: Icon(Icons.delivery_dining),
                title: Text("Cash on Delivery",style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),),
                value: 'cashOnDelivery',
                groupValue: selectPaymentMethod,
                onChanged: (String? value){
                  setState(() {
                    selectPaymentMethod=value!;
                  });
                }
            ),

          ],
        ),
      ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 338,
          height: 58,
          decoration: BoxDecoration(
            color: Color(0xFF3854EE,),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(selectPaymentMethod=='stripe'?'Pay Now':'Place Order',style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
          ),
        ),
      ),
    );
  }
}
