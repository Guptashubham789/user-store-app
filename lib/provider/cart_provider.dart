
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/models/cart_model.dart';

//Define a StateNotifireProvider to expose an instane of the CartNotifire
//Makin it accssible within our app

final cartProvider=StateNotifierProvider<CartNotifire,Map<String,CartModel>>((ref){
  return CartNotifire();
});

//A notifire class to manage the cart state, extending stateNotifire
//with an initial state of an empty map

class CartNotifire extends StateNotifier<Map<String,CartModel>>{
  CartNotifire():super({});

  //Method to add product to the cart
  void addProductToCart({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName,
  }){
  //Check if the product is alredy in the cart
       if(state.containsKey(productId)){
         //if the product is already in the cart , update its quantity and maybe other detail
         state={
           ...state,
           productId:CartModel(
               productName: state[productId]!.productName,
               productPrice: state[productId]!.productPrice,
               category: state[productId]!.category,
               image: state[productId]!.image,
               vendorId: state[productId]!.vendorId,
               productQuantity: state[productId]!.productQuantity,
               quantity: state[productId]!.quantity+1,
               productId: state[productId]!.productId,
               description: state[productId]!.description,
               fullName: state[productId]!.fullName,
           )
         };
       }else{
         //if the product is not in the cart add it with the provide details
         state={
           ...state,
           productId:CartModel(
               productName: productName,
               productPrice: productPrice,
               category: category,
               image: image,
               vendorId: vendorId,
               productQuantity: productQuantity,
               quantity: quantity,
               productId: productId,
               description: description,
               fullName: fullName,
           )
         };
       }
  }
  //Method to increment the quantity of a product in the cart
  void incrementCartItem(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity++;

      //Notify listeners that state has changed
      state={...state};
    }
  }
  //Method to decrement the quantity of a product in the cart
  void decrementCartItem(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity--;

      //Notify listeners that the state has changed
      state={...state};
    }
  }

  //Method to remove item from the cart
  void removeCartItem(String productId){
    state.remove(productId);
    //Notify listernerd=s that the state has changed

    state={...state};
  }

  //Method to Calculate total ammount of item we have in cart
  double calculateTotalAmount(){
   double totalAmount=0.0;
   state.forEach((productId,cartItem){
     totalAmount+=cartItem.quantity*cartItem.productPrice;
   });
  return totalAmount;
  }
}