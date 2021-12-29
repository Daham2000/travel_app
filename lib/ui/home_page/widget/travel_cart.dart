/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'single_post.dart';

class TravelCart extends StatelessWidget {
  final String img;
  final String title;
  final String shortDetails;
  final String description;
  final String youtubeID;
  final String district;
  final List<dynamic> latLng;

  const TravelCart(
      {this.latLng,
      this.img,
      this.title,
      this.shortDetails,
      this.description,
      this.youtubeID,
      this.district});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SinglePost(
                        travelCart: new TravelCart(
                      title: this.title,
                      description: this.description,
                      img: this.img,
                      youtubeID: this.youtubeID,
                      district: this.district,
                      latLng: this.latLng,
                    ))));
      },
      child: Hero(
        tag: img + title,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.73,
                  height: MediaQuery.of(context).size.width * 0.43,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: CachedNetworkImage(
                      imageUrl: img,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5.0,
                  child: Container(
                      height: 30.0,
                      width: MediaQuery.of(context).size.width * 0.55,
                      margin: const EdgeInsets.only(bottom: 6.0),
                      //Same as `blurRadius` i guess
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 5.0), //(x,y)
                            blurRadius: 40.0,
                          ),
                        ],
                      )),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: GoogleFonts.mulish(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
