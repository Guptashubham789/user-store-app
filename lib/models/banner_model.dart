import 'dart:convert';
class BannerModel{
  final String id;
  final String image;

  BannerModel({
    required this.id,
    required this.image,
  });

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      'id':id,
      'image':image,
    };
  }


  // Factory constructor for creating a new BannerModel instance from a map.
  factory BannerModel.fromJson(Map<String, dynamic> Json) {
    return BannerModel(
      id: Json['_id'] as String,
      image: Json['image'] as String,
    );
  }

  String toJson()=>json.encode(toMap());
//factory BannerModel.fromJson(String source)=>BannerModel.fromMap(json.decode(source)as Map<String,dynamic>);


}