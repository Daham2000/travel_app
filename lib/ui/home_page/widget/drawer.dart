/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/db/auth/authentication.dart';
import 'package:travel_app/ui/root_page/sub_page/login_provider.dart';
import 'package:travel_app/utill/image_assets.dart';

import '../home_provider.dart';

class DrawerHome extends StatelessWidget {
  final String version;
  final double gap = 20;

  const DrawerHome({Key? key, required this.version});

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
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            ImageAssets.demoProPic,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "John Clark",
                              style: GoogleFonts.mulish(
                                  fontSize: 20, color: Colors.blue),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Text(
                                "dahamakalanka200@gmail.com",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                  fontSize: 9,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
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
                      padding: const EdgeInsets.only(left: 15,bottom: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(color: Colors.blueAccent),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("This page is under developing"),
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,bottom: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.travelIcon,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "My plans",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("This page is under developing"),
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,bottom: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.settingsIcon,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("This page is under developing"),
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,bottom: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.aboutIcon,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "About",
                            style: TextStyle(color: Colors.black),
                          )
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
                      padding: const EdgeInsets.only(left: 15,bottom: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.logoutIcon,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(color: Colors.black),
                          )
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
