/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'single_post.dart';

class TravelCart extends StatelessWidget {
  final String img;
  final String title;
  final String shortDetails;
  final String description;
  final String youtubeID;
  final String district;
  final List<dynamic> latLng;

  const TravelCart({this.latLng,this.img, this.title, this.shortDetails, this.description, this.youtubeID, this.district});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
        tag: img+title,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 240,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    shortDetails,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
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
