/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:themed/themed.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:travel_app/utill/styled_colors.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'location_view.dart';
import 'travel_cart.dart';

class SinglePost extends StatefulWidget {
  final TravelCart travelCart;

  SinglePost({this.travelCart});

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  // YoutubePlayerController _controller;

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.travelCart.youtubeID,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Hero(
      tag: widget.travelCart.title,
      child: Material(
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
                fit: BoxFit.fill,),
            ),
              elevation: 10,
              centerTitle: true,
              title: Text(
                "Trip information",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 20),
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
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: StyledColor.ADD_ICON_COLOR,
                                elevation: 1.0,
                              ),
                              onPressed: (){
                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("This page is under developing"),
                                  );
                                });
                              },
                              child: Text(
                                "Add to a trip plan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: StyledColor.GREEN_BTN,
                                elevation: 1.0,
                              ),
                              onPressed: (){
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LocationView(
                                //           latLng: widget.travelCart.latLng,
                                //         )));
                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("This page is under developing"),
                                  );
                                });
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
                          YoutubePlayerIFrame(
                            controller: _controller,
                            aspectRatio: 16 / 9,
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
      ),
    );
  }
}
