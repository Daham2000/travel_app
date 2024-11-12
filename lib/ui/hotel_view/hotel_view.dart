import 'package:flutter/material.dart';
import 'package:travel_app/db/model/hotel_search_model.dart';
import 'package:travel_app/ui/widgets/hotel_view_widget.dart';

class HotelViewList extends StatelessWidget {
  final List<Hotel> list;

  const HotelViewList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Near by Hotels"),
      ),
      body: Container(
        child: ListView(
          children: [
            for (var hotel in list)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HotelCard(
                  imageUrl:
                       (hotel.photos!.length > 0) ? hotel.photos?.first.photoReference ?? "" : "",
                  hotelName: hotel.name,
                  location: "https://maps.googleapis.com/maps/api/place/details/json?placeid=${hotel.placeId}&key=AIzaSyC6q9DqNUesEqRvX04W60lrmTobM87GgVU",
                  rating: hotel.rating,
                  price: hotel.priceLevel,
                ),
              )
          ],
        ),
      ),
    );
  }
}
