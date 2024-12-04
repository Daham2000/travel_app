/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/db/auth/authentication.dart';
import 'package:travel_app/db/model/user.dart';
import 'package:travel_app/ui/login_page/login_provider.dart';
import 'package:travel_app/ui/trip_view/all_trips_view/all_trip_provider.dart';
import 'package:travel_app/ui/trip_view/trip_provider.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:travel_app/utill/route_strings.dart';

import '../home_provider.dart';

class DrawerHome extends StatelessWidget {
  final String version;
  final String currentPage;
  final User user;
  final double gap = 20;

  const DrawerHome(
      {Key? key,
      required this.version,
      required this.user,
      required this.currentPage});

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
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                user.firstName + " " + user.lastName,
                                style: GoogleFonts.mulish(
                                    fontSize: 20, color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Text(
                                user.email,
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
                      if (currentPage != RouteStrings.home) {
                        Future.microtask(
                          () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeProvider())),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 16),
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
                      if (currentPage != RouteStrings.allTrip) {
                        Future.microtask(
                          () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllTripProvider())),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Trip Plan",
                            style: TextStyle(color: Colors.blueAccent),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                      padding: const EdgeInsets.only(left: 15, bottom: 16),
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
