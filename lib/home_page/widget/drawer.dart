/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/material.dart';
import 'package:travel_app/db/auth/authentication.dart';
import 'package:travel_app/root_page/sub_page/login_provider.dart';
import 'package:travel_app/utill/image_assets.dart';

class DrawerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white, //This will change the drawer background to blue.
      ),
      child: Drawer(
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
                    onTap: () async {
                      print("Navigating to Login page...");
                      await Authentication().signOut();
                      Future.microtask(
                            () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginProvider())),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Logout")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(ImageAssets.logoPath,width: 60,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("version 1.0.0",style: TextStyle(
                      fontSize: 11.0
                    ),),
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
