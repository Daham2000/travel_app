/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/utill/image_assets.dart';

import 'home_bloc.dart';
import 'home_state.dart';
import 'widget/drawer.dart';
import 'widget/travel_cart.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: close_sinks
  final searchController = TextEditingController();
  ScrollController listController = ScrollController();

  @override
  void initState() {
    super.initState();
    listController.addListener(_scrollListener);
    context.read<HomeBloc>().getAllAttractions();
    context.read<HomeBloc>().getAppVersion();
  }

  void _scrollListener() {
    if (listController.offset >= listController.position.maxScrollExtent &&
        (!listController.position.outOfRange)) {
      print("load documents with pagination flutter...");
      context.read<HomeBloc>().getAttractionsWithPagination();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(buildWhen: (previous, current) {
      return previous.isSearching != current.isSearching ||
          previous.attractionList?.length != current.attractionList?.length;
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            elevation: 0,
            flexibleSpace: Image(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.cover,
            ),
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SvgPicture.asset(
                      ImageAssets.travelIcon,
                      color: Colors.white,
                      width: 24.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Discover",
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 80.0,
                            child: RichText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: TextSpan(
                                text: "Sri Lanka's top travel places",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.0),
              // here the desired height
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Avenir LT Std",
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                    prefixIcon: state.searchList?.isNotEmpty == true
                        ? Padding(
                            padding: const EdgeInsets.only(
                                right: 2.0, top: 5, bottom: 5, left: 2),
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                searchController.clear();
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                right: 2.0, top: 5, bottom: 5, left: 2),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                    hintText: "Search",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: new OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: new BorderSide(color: Colors.grey)),
                  ),
                  onChanged: (query) {
                    context.read<HomeBloc>().getAllAttractionsByName(query);
                  },
                ),
              ),
            ),
          ),
        ),
        drawer: DrawerHome(
          version: state.version ?? "",
        ),
        body: Stack(
          children: [
            if (state.attractionList != null)
              ListView(
                controller: listController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 19, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Popular places",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  state.isSearching ?? false
                      ? Center(child: CupertinoActivityIndicator())
                      : Container(),
                  for (final e in state.searchList!.length > 0
                      ? state.searchList!
                      : state.attractionList!)
                    TravelCart(
                      title: e.title,
                      img: e.images[0],
                      isAd: false,
                      description: e.description,
                      shortDetails: e.shortDetail,
                      youtubeID: e.youtubeId,
                      district: e.district,
                      latLng: e.latLng,
                      hotelModel: [],
                      url: '',
                      rate: 0,
                      commnets: e.comments,
                      attraction: e,
                    ),
                ],
              )
            else
              Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
          ],
        ),
      );
    });
  }
}
