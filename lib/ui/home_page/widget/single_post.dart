/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Hero(
      tag: widget.travelCart.img + widget.travelCart.title,
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    StyledColor.BACKGROUND_COLOR_ONE,
                    StyledColor.BACKGROUND_COLOR_ONE
                  ],
                ),
              ),
            ),
            elevation: 0,
            title: Text(
              widget.travelCart.title,
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
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
                      padding: const EdgeInsets.all(12.0),
                      child: ListView(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 240,
                            child: CachedNetworkImage(
                              imageUrl: widget.travelCart.img,
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              widget.travelCart.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              "District: " + widget.travelCart.district,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
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
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          YoutubePlayerIFrame(
                            controller: _controller,
                            aspectRatio: 16 / 9,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationView(
                                            latLng: widget.travelCart.latLng,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Click to view location on map",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
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
