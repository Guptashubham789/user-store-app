import 'dart:convert';

import 'package:store_app/models/subcategory_model.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';


class SubCategoryController{

  Future<List<SubCategoryModel>> getSubCategoriesByCategoryName(String categoryName) async{
    try{
     http.Response response= await http.get(Uri.parse("$uri/api/categories/$categoryName/subcategories"), //api/subcategories
        headers: <String,String>{
          "Content-Type":'application/json; charset=UTF-8'
        },
      );
     print('--------------------------------------------------');
     print(response.body);
     print('-----------------------------------------------------');
     if(response.statusCode==200){

       final Map<String, dynamic> json = jsonDecode(response.body);
       final List<dynamic> data = json['subcategories'];
       if(data.isNotEmpty){
         return data.map((subcategory)=>SubCategoryModel.fromJson(subcategory)).toList();
       }else{
         print('subCategories  not found');
         return [];
       }
     }else if(response.statusCode==400){
       print('subCategories not found');
       return [];
     }else{
       print('failed to fetch subcategories');
       return [];
     }
    }catch(e){
        print("Error fetching categories: $e");
        return [];
    }
  }
}