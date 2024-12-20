import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/ui/home_page/home_provider.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:travel_app/utill/transitions.dart';

class IntroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color(0xff636363),
                BlendMode.darken,
              ),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(ImageAssets.french),
                  fit: BoxFit.cover,
                )),
              ),
            ),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220.0,
                child: Text(
                  "Find popular attractions in Sri Lanka!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                width: 250.0,
                child: Text(
                  "Embark on your journey to discover the breathtaking beauty of Sri Lanka. "
                      "From serene beaches to lush tea plantations, ancient ruins to vibrant cityscapes, "
                      "MAYTH is your ultimate travel companion.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
                onPressed: () {
                  Future.microtask(
                        () => Navigator.pushReplacement(context,
                        SlideBottomRoute(page: HomeProvider())),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text("Okey",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
