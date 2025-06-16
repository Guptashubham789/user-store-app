import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/controllers/product_controller.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:store_app/views/screens/detail/screens/widgets/subcategory_tile_widget.dart';
import 'package:store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';
import '../../../../../controllers/subcategory_controller.dart';
import '../../../../../models/product_model.dart';
import '../../../../../models/subcategory_model.dart';
import '../../../nav_screens/widgets/product_item_widget.dart';
import 'inner_banner_widget.dart';


class InnerCategoryContentWidget extends StatefulWidget {
  final CategoryModel category;
  const InnerCategoryContentWidget({super.key, required this.category});

  @override
  State<InnerCategoryContentWidget> createState() => _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState extends State<InnerCategoryContentWidget> {

  late Future<List<SubCategoryModel>> _subcategories;
  late Future<List<ProductModel>> futureProducts;
  final SubCategoryController _subCategoryController = SubCategoryController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subcategories = _subCategoryController
        .getSubCategoriesByCategoryName(widget.category.name);
    futureProducts=ProductController().loadProductByCategory(widget.category.name);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(
              child: Text(
                'Shop By Subcategories',
                style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7),
              ),
            ),
            FutureBuilder(
                future: _subcategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error : ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('!-No Subcategory'),
                    );
                  } else {
                    final subcategories = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate(
                          (subcategories.length / 3).ceil(),
                              (setIndex) {
                            //for each row , calculate the starting and ending
                            final start = setIndex * 3;
                            final end = (setIndex + 1) * 3;

                            ///
                            /// create a padding widget to add spacing arround to row
                            return Padding(
                              padding: EdgeInsets.all(8.9),
                              child: Row(
                                //verticalDirection: VerticalDirection.down,
                                //create a row of the subcategory tile
                                children: subcategories
                                    .sublist(start,
                                    end>subcategories.length
                                        ?subcategories.length
                                        :end)
                                    .map((subcategory)=>SubcategoryTileWidget(
                                  image: subcategory.image,
                                  title: subcategory.subCategoryName,
                                )).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
            const ReusableTextWidget(title: 'Popular Product', subtitle: 'View all'),
            FutureBuilder(
                future: futureProducts,
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(snapshot.hasError){
                    return Center(child: Text('Error ${snapshot.error}'),);
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
                }),
          ],
        ),
      ),
    );
  }
}
