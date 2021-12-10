/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/db/auth/authentication.dart';
import 'package:travel_app/home_page/home_provider.dart';
import 'package:travel_app/root_page/sub_page/login_provider.dart';
import 'package:travel_app/utill/image_assets.dart';

class DrawerHome extends StatelessWidget {
  final String version;

  const DrawerHome({Key key, this.version});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.center,
              colors: [
                Color(0xFFC0ECFF),
                Colors.white,
                Colors.white,
                Colors.white,
              ],
              stops: [
                0.3,
                0.6,
                0.7,
                0.9,
              ],
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Future.microtask(
                            () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeProvider())),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Home",style: TextStyle(
                              color: Colors.blueAccent
                          ),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.travelIcon,width: 20,),
                          SizedBox(
                            width: 15,
                          ),
                          Text("My plans",style: TextStyle(
                              color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.settingsIcon,width: 20,),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Settings",style: TextStyle(
                              color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.aboutIcon,width: 20,),
                          SizedBox(
                            width: 15,
                          ),
                          Text("About",style: TextStyle(
                              color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print("Navigating to Login page...");
                      await Authentication().signOut();
                      Future.microtask(
                        () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginProvider())),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageAssets.logoutIcon,width: 20,),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Logout",style: TextStyle(
                            color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    ImageAssets.logoPath,
                    width: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      "Version ${version.toString()}",
                      style: TextStyle(fontSize: 11.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
