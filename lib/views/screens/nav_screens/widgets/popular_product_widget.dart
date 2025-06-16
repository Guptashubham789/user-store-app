import 'package:flutter/material.dart';
import 'package:store_app/controllers/product_controller.dart';

import '../../../../models/product_model.dart';
import 'product_item_widget.dart';

class PopularProductWidget extends StatefulWidget {
  const PopularProductWidget({super.key});

  @override
  State<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends State<PopularProductWidget> {
  //A Future that hold the list of popular products
  late Future<List<ProductModel>> futurePopularProduct;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePopularProduct=ProductController().loadPopularProduct();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futurePopularProduct,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child: Text('Error SS ${snapshot.error}'),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text('No Popular Products'),);
          }else{
            final popularProduct=snapshot.data;
            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularProduct!.length,
                  itemBuilder: (context,index){
                  final product=popularProduct[index];
                  return ProductItemWidget(productModel: product,);
                  }),
            );
          }
        });
  }
}
