import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global_variables.dart';
import '../models/category_model.dart';

class CategoryController{


  //load the uploaded category
  Future<List<CategoryModel>> loadCategories()async{
    try{
      //send the http get req to load the category
      http.Response response=  await http.get(Uri.parse('$uri/api/categories'),
        headers: <String,String>{
          "Content-Type":'application/json; charset=UTF-8'
        },
      );
      //print(response.body);
      if(response.statusCode==200){
        final List<dynamic> data=  jsonDecode(response.body);
        List<CategoryModel> categories=
        data.map((category)=>CategoryModel.fromJson(category)).toList();
        return categories;
      }else{
        throw Exception('failed to load categories');
      }
    }catch(e){
      throw Exception('Error loading Categories : $e');
    }
  }

}