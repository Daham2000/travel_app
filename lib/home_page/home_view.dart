/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travel_app/utill/image_assets.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'widget/app_bar_widget.dart';
import 'widget/drawer.dart';
import 'widget/travel_cart.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: close_sinks
  HomeBloc homeBloc;
  final searchController = TextEditingController();
  ScrollController listController = ScrollController();
  String version;

  @override
  void initState() {
    super.initState();
    getAppVersion();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    listController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (listController.offset >= listController.position.maxScrollExtent &&
        !listController.position.outOfRange) {
      homeBloc.add(GetDataAttractionEvent());
    }
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (pre, current) =>
            pre.error != current.error ||
            pre.isSearching != current.isSearching ||
            pre.attractionList != current.attractionList ||
            pre.documentSnapshot != current.documentSnapshot ||
            pre.searchList != current.searchList,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              flexibleSpace: AppBarWidget(),
              title: Container(
                width: 50,
                child: Image.asset(ImageAssets.logoPath),
              ),
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            drawer: DrawerHome(version: version,),
            body: Stack(
              children: [
                if (state.attractionList != null)
                  ListView(
                    controller: listController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Avenir LT Std",
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                            suffixIcon: state.searchList.isNotEmpty == true
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 2.0, top: 5, bottom: 5, left: 2),
                                    child: InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        searchController.clear();
                                        homeBloc.add(ClearSearchResult());
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
                            hintText: "Search for attractions",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: new BorderSide(color: Colors.grey)),
                          ),
                          onChanged: (query) {
                            homeBloc.searchAttraction(query);
                          },
                        ),
                      ),
                      state.isSearching
                          ? Center(child: CupertinoActivityIndicator())
                          : Container(),
                      for (final e in state.searchList.length > 0
                          ? state.searchList
                          : state.attractionList)
                        TravelCart(
                          title: e.title,
                          img: e.image,
                          description: e.description,
                          shortDetails: e.shortDetail,
                          youtubeID: e.youtubeID,
                          district: e.district,
                          latLng: e.latLng,
                        )
                    ],
                  )
                else
                  Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
              ],
            ),
          );
        });
  }
}
