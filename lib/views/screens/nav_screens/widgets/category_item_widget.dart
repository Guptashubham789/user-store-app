import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

import '../../../../controllers/category_controller.dart';
import '../../../../models/category_model.dart';



class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  //A- future that will hold the list of categories once loaded from the API
  late Future<List<CategoryModel>> _futureCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureCategory=CategoryController().loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableTextWidget(title: 'Categories', subtitle: 'View all'),
        FutureBuilder(
            future: _futureCategory,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Center(
                  child: Text('Error : ${snapshot.error}'),
                );
              }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                return Center(
                  child: Text('No Category'),
                );
              }else{
                final categories=snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                      ),
                      itemBuilder: (context,index){
                        final category=categories[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return InnerCategoryScreen(category: category,);
                            }));
                          },
                          child: Column(
                            children: [
                              Image.network(category.image,height: 47,width: 47,),
                              Text(category.name,style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 12),),
                            ],
                          ),
                        );
                      }),
                );
              }
              return Container();
            }
        ),
      ],
    );
  }
}
