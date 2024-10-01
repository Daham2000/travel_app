/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:maps_launcher/maps_launcher.dart';
import 'package:themed/themed.dart';
import 'package:travel_app/utill/manage_hotel_number.dart';
import 'package:travel_app/utill/styled_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'travel_cart.dart';

class SinglePost extends StatefulWidget {
  final TravelCart travelCart;

  SinglePost({required this.travelCart});

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  // YoutubePlayerController _controller;

  late YoutubePlayerController _controller;
  int hotelNumber = 0;

  @override
  void initState() {
    super.initState();
    getNumber();
    saveNumber();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.travelCart.youtubeID,
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  void getNumber() async {
    final int num = await ManageHotelNumber().getNumber();
    setState(() {
      this.hotelNumber = num;
    });
    print("hotelNumber: " + hotelNumber.toString());
  }

  void saveNumber() async {
    ManageHotelNumber().saveNumber();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(190.0),
          child: AppBar(
            backgroundColor: Colors.white,
            flexibleSpace: ChangeColors(
              hue: 0.0001,
              brightness: -0.2,
              saturation: 0.0001,
              child: CachedNetworkImage(
                imageUrl: widget.travelCart.img,
                fit: BoxFit.fill,
              ),
            ),
            elevation: 10,
            centerTitle: true,
            title: Text(
              "Trip information",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(25.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: [
                    Text(
                      widget.travelCart.title,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 19.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 4.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            "District: " + widget.travelCart.district,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.rubik(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            widget.travelCart.description,
                            maxLines: 100,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.rubik(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: StyledColor.GREEN_BTN,
                              elevation: 1.0,
                            ),
                            onPressed: () {
                              // MapsLauncher.launchQuery('1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA');
                              // MapsLauncher.launchCoordinates(37.4220041, -122.0862462);
                              openMap(double.parse(widget.travelCart.latLng[0]), double.parse(widget.travelCart.latLng[1]));
                            },
                            child: Text(
                              "Click to view location on map",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        YoutubePlayer(
                          controller: _controller,
                          aspectRatio: 16 / 9,
                          enableFullScreenOnVerticalDrag: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
