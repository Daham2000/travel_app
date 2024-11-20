import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:themed/themed.dart';
import 'package:travel_app/db/model/hotel_search_model.dart';
import 'package:travel_app/ui/widgets/hotel_view_widget.dart';

class HotelViewList extends StatelessWidget {
  final List<Hotel> list;
  final String mainImg;

  const HotelViewList({super.key, required this.list, required this.mainImg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "Near by Hotels",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.white,
          flexibleSpace: ChangeColors(
            hue: 0.0001,
            brightness: -0.2,
            saturation: 0.0001,
            child: CachedNetworkImage(
              imageUrl: mainImg,
              fit: BoxFit.fill,
            ),
          ),
          leading: GestureDetector(
            onTap: ()=> {
              Navigator.pop(context)
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            for (var hotel in list)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HotelCard(
                      hotel: hotel,
                      imageUrl: (hotel.photos!.length > 0)
                          ? hotel.photos?.first.photoReference ?? ""
                          : "",
                      hotelName: hotel.name,
                      location:
                          "https://maps.googleapis.com/maps/api/place/details/json?placeid=${hotel.placeId}&key=AIzaSyC6q9DqNUesEqRvX04W60lrmTobM87GgVU",
                      rating: hotel.rating,
                      price: hotel.priceLevel,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
