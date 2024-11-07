/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/db/model/attraction.dart';
import 'package:travel_app/db/model/comment.dart';
import 'package:travel_app/utill/transitions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'single_post.dart';

class TravelCart extends StatelessWidget {
  final String img;
  final bool isAd;
  final int rate;
  final String title;
  final String shortDetails;
  final String description;
  final String youtubeID;
  final String district;
  final String url;
  final List<dynamic> latLng;
  final List hotelModel;
  final List<Comment> commnets;
  final Attraction attraction;

  const TravelCart(
      {required this.latLng,
      required this.img,
      required this.isAd,
      required this.url,
      required this.rate,
      required this.title,
      required this.shortDetails,
      required this.description,
      required this.youtubeID,
      required this.hotelModel,
      required this.district,
      required this.commnets,
      required this.attraction});

  void _launchURL() async {
    if (!await launchUrl(Uri(path: this.url)))
      throw 'Could not launch ${this.url}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isAd) {
          _launchURL();
        } else {
          Navigator.push(
              context,
              SlideBottomRoute(
                  page: SinglePost(
                travelCart: new TravelCart(
                  title: this.title,
                  description: this.description,
                  img: this.img,
                  youtubeID: this.youtubeID,
                  district: this.district,
                  latLng: this.latLng,
                  hotelModel: [],
                  isAd: false,
                  url: '',
                  rate: 0,
                  shortDetails: '',
                  commnets: this.commnets,
                  attraction: this.attraction,
                ),
                attraction: this.attraction,
              )));
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: isAd
                    ? MediaQuery.of(context).size.width * 0.81
                    : MediaQuery.of(context).size.width * 0.73,
                height: MediaQuery.of(context).size.width * 0.43,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    fit: isAd ? BoxFit.fill : BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              isAd
                  ? Positioned(
                      top: 10.0,
                      left: 50.0,
                      child: Container(
                          width: 20,
                          height: 15,
                          color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "AD",
                              style: GoogleFonts.mulish(
                                  fontSize: 7.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )))
                  : Container(),
              Positioned(
                bottom: -5.0,
                child: Container(
                    height: isAd ? 50.0 : 30,
                    width: isAd
                        ? MediaQuery.of(context).size.width * 0.65
                        : MediaQuery.of(context).size.width * 0.55,
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
                bottom: isAd ? 26.0 : 10.0,
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
              isAd
                  ? Positioned(
                      bottom: 10.0,
                      left: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          district,
                          style: GoogleFonts.mulish(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
