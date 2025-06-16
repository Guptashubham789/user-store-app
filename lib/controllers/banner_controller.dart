import 'dart:convert';

import 'package:http/http.dart' as http;

import '../global_variables.dart';
import '../models/banner_model.dart';
import '../services/manage_http_response.dart';

class BannerController{



//fetch banners

  Future<List<BannerModel>> loadBanners() async{
    try{
      //send an http get req to fetch banner
      http.Response res=  await http.get(Uri.parse("$uri/api/banner"),
        headers: <String,String>{
          "Content-Type":'application/json; charset=UTF-8'
        },
      );
      print(res.body);

      //json convert to
      if(res.statusCode==200){//okk
        List<dynamic> data=jsonDecode(res.body);
        List<BannerModel> banners=data.map((banner)=>BannerModel.fromJson(banner)).toList();
        return banners;
      }else{
        //throw an execption if the server res with an error status code
        throw Exception('Failed to load Banners');

      }
    }catch(e){
      throw Exception('Error loading Banners $e');
    }
  }
}