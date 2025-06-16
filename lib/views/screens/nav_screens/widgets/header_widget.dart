import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.15,
      child: Stack(
        children: [
          Image.asset('assets/icons/searchBanner.jpeg',width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
          Positioned(
            left: 20,
              top: 60,
              child: SizedBox(
                width: 250,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter text",
                      hintStyle: TextStyle(fontSize: 14,color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                      prefixIcon: Image.asset('assets/icons/searc1.png'),
                      suffixIcon: Image.asset('assets/icons/cam.png'),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      focusColor: Colors.black,
                    ),
                  ),
              ),
          ),

          Positioned(
            left: 280,
              top: 68,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: (){},
                  child: Ink(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/bell.png'),
                      ),
                    ),
                  ),
                ),
              ),
          ),

          Positioned(
            left: 315,
              top: 68,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: (){

                  },
                  child: Ink(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/message.png'),
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
