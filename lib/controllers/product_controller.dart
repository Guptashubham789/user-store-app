import '../models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global_variables.dart';
class ProductController{
  //Define a function that return a future containing list of the product model object

  Future<List<ProductModel>> loadPopularProduct()async{
    try{

      http.Response response=  await http.get(Uri.parse('$uri/api/popular-products'),
        headers: <String,String>{
          "Content-Type":'application/json; charset=UTF-8'
        },
      );
      print(response.body);
      //check if the http res status code is 200,which means the req was successful

      if(response.statusCode==200){
        //Decode the json response body into a list of dynamic object
        final List<dynamic> data=  jsonDecode(response.body) as List<dynamic>;
        //map each item in the list to product model object which we can use
        List<ProductModel> popularProducts=
        data.map((product)=>ProductModel.fromMap(product as Map<String,dynamic>)).toList();

        return popularProducts;
      }else{
        throw Exception('failed to load popularProduct');
      }
    }catch(e){
      throw Exception('Error loading popularProduct : $e');
    }
  }

  //load product by category function
  Future<List<ProductModel>> loadProductByCategory(String category)async{
    try{
     http.Response response= await http.get(Uri.parse('$uri/api/products-by-category/$category'),
      headers: <String,String>{
        "Content-Type":'application/json; charset=UTF-8',
      },
      );
      if(response.statusCode==200){
        //Decode the json response body into a list of dynamic object
        final List<dynamic> data=  jsonDecode(response.body) as List<dynamic>;
        //map each item in the list to product model object which we can use
        List<ProductModel> popularProducts=
        data.map((product)=>ProductModel.fromMap(product as Map<String,dynamic>)).toList();

        return popularProducts;
      }else{
        throw Exception('failed to load popularProduct');
      }
    }catch(e){
      throw Exception('Error loading popularProduct : $e');
    }
  }
}