import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/controllers/subcategory_controller.dart';
import 'package:store_app/models/subcategory_model.dart';
import 'package:store_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';
import 'package:store_app/views/screens/nav_screens/widgets/header_widget.dart';

import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  //A- future that will hold the list of categories once loaded from the API
  late Future<List<CategoryModel>> futureCategory;
  CategoryModel? selectedCategory;
  List<SubCategoryModel> _subCategories=[];
  final SubCategoryController _subCategoryController=SubCategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategory=CategoryController().loadCategories();

    //default selected category and sub
    //once the categories are loaded process then
    futureCategory.then((categories){
      //iterate through the categories to find the "Fashion" category
      for(var category in categories){
        if(category.name=='Fashion'){
          //if "Fashion" categories is found set it as the selected category
          setState(() {
            selectedCategory=category;
          });
          //load subcategories for the "Fashion" category
          _loadSubCategories(category.name);
        }
      }
    });
  }

  //this will load subcategories base on the categories
  Future<void> _loadSubCategories(String categoryName) async{
  final subCategories= await _subCategoryController.getSubCategoriesByCategoryName(categoryName);
  setState(() {
    _subCategories=subCategories;
  });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*20),
          child: HeaderWidget(),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //left side display categories
          Expanded(
            flex: 2,
              child: Container(
                color: Colors.grey.shade200,
                child: FutureBuilder(
                    future: futureCategory,
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }else if(snapshot.hasError){
                        return Center(child: Text("Error : ${snapshot.error}"),);
                      }else{
                        final categories=snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: categories.length,
                            itemBuilder: (context,index){
                              final category=categories[index];
                              return ListTile(
                                onTap: (){
                                  setState(() {
                                    selectedCategory=category;
                                  });
                                  _loadSubCategories(category.name);
                                },
                                title: Text(category.name,
                                  style: GoogleFonts.quicksand(fontSize: 11,fontWeight: FontWeight.bold,color: selectedCategory==category?Colors.blue:Colors.black),),
                              );
                            });
                      }
                    }),
              ),
          ),
          Expanded(
            flex: 5,
              child: selectedCategory!=null?SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(selectedCategory!.name,style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(selectedCategory!.banner),
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                   _subCategories.isNotEmpty? GridView.builder(
                     physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _subCategories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 4,
                        childAspectRatio: 2/3),
                        itemBuilder: (context,index){
                          final subcategory=_subCategories[index];
                          return SubcategoryTileWidget(image: subcategory.image, title: subcategory.subCategoryName);
                        }):Center(child: Text('No Subcategories',style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.bold),)),
                    
                  ],
                ),
              ):Container()),

        ],
      ),
    );
  }
}
