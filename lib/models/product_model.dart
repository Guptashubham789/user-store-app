import 'dart:convert';

class ProductModel{
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final String subCategory;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.vendorId,
    required this.fullName,
    required this.subCategory,
    required this.images,
  });
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      'id':id,
      'productName':productName,
      'productPrice':productPrice,
      'quantity':quantity,
      'description':description,
      'category':category,
      'vendorId':vendorId,
      'fullName':fullName,
      'subCategory':subCategory,
      'images':images,
    };
  }
  String toJsom()=> json.encode(toMap());

  factory ProductModel.fromMap(Map<String,dynamic> map){
    return ProductModel(
        id: map['_id'] as String,
        productName: map['productName'] as String,
        productPrice: map['productPrice'] as int,
        quantity: map['quantity'] as int,
        description: map['description'] as String,
        category: map['category'] as String,
        vendorId: map['vendorId'] as String,
        fullName: map['fullName'] as String,
        subCategory: map['subCategory'] as String,
        images: List<String>.from((map['images'] as List<dynamic>),
        )
    );
  }
  factory ProductModel.fromJson(String source)=>ProductModel.fromMap(jsonDecode(source) as Map<String,dynamic>);
}