/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/db/model/user.dart';
import 'package:travel_app/ui/root_page/root_bloc.dart';
import 'package:travel_app/utill/image_assets.dart';
import 'package:travel_app/utill/route_strings.dart';

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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    listController.addListener(_scrollListener);
    context.read<HomeBloc>().setUserDetails();
    context.read<HomeBloc>().getAllAttractions();
    context.read<HomeBloc>().getAppVersion();
    context.read<RootBloc>().loadAllTripPlans();
    context.read<RootBloc>().setUserDetails();
  }

  void _scrollListener() {
    if (listController.offset >= listController.position.maxScrollExtent &&
        (!listController.position.outOfRange)) {
      context.read<HomeBloc>().getAttractionsWithPagination();
    }
  }

  List<String> items = List.generate(20, (index) => "Item ${index + 1}");

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
            currentPage: RouteStrings.home,
            user: state.user ?? User(email: "", firstName: "", lastName: "", id: '', invitations: []),
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            onRefresh: () {
              context.read<HomeBloc>().getAllAttractions();
              searchController.clear();
              return Future<void>.delayed(const Duration(seconds: 2));
            },
            child: state.isSearching ?? false
                ? Center(child: CupertinoActivityIndicator())
                : ListView.builder(
                    itemCount: state.searchList!.length > 0
                        ? state.searchList!.length
                        : state.attractionList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TravelCart(
                        title: state.searchList!.length > 0
                            ? state.searchList[index].title
                            : state.attractionList?[index].title,
                        img: state.searchList!.length > 0
                            ? state.searchList[index].images[0]
                            : state.attractionList?[index].images[0],
                        isAd: false,
                        description: state.searchList!.length > 0
                            ? state.searchList[index].description
                            : state.attractionList?[index].description,
                        shortDetails: state.searchList!.length > 0
                            ? state.searchList[index].shortDetail
                            : state.attractionList?[index].shortDetail,
                        youtubeID: state.searchList!.length > 0
                            ? state.searchList[index].youtubeId
                            : state.attractionList?[index].youtubeId,
                        district: state.searchList!.length > 0
                            ? state.searchList[index].district
                            : state.attractionList?[index].district,
                        latLng: state.searchList!.length > 0
                            ? state.searchList[index].latLng
                            : state.attractionList?[index].latLng,
                        hotelModel: [],
                        url: '',
                        rate: 0,
                        commnets: state.searchList!.length > 0
                            ? state.searchList[index].comments
                            : state.attractionList?[index].comments,
                        attraction: state.searchList!.length > 0
                            ? state.searchList[index]
                            : state.attractionList?[index],
                      );
                    },
                  ),
          ));
    });
  }
}
