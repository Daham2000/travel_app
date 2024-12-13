import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/db/model/hotel_search_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelCard extends StatelessWidget {
  final String imageUrl;
  final String hotelName;
  final String location;
  final double rating;
  final int price;
  final Hotel hotel;

  const HotelCard({
    Key? key,
    required this.imageUrl,
    required this.hotelName,
    required this.location,
    required this.rating,
    required this.price,
    required this.hotel,
  }) : super(key: key);

  static Future<void> openMap(String title) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$title';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> {
        openMap(hotel.name)
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: imageUrl == ""
                    ? "https://i.pinimg.com/474x/7d/65/4d/7d654d09f8ccc94ed4453db455cf66af.jpg"
                    : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${imageUrl}&key=AIzaSyC6q9DqNUesEqRvX04W60lrmTobM87GgVU",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          hotel.vicinity,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 5),
                          Text(
                            rating.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Opened Now - ${hotel.openingHours?.openNow ?? false ? "Yes" : "No"}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
