import 'package:flutter/material.dart';

class TripCardView extends StatelessWidget {
  final trip;
  const TripCardView({super.key, this.trip});

  String getDateString(DateTime timeDate) {
    return timeDate.year.toString() +
        "/" +
        timeDate.month.toString() +
        "/" +
        timeDate.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.name[0].toUpperCase() +
                        trip.name
                            .toString()
                            .substring(1, trip.name.toString().length), style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500
                    ),),
                    const SizedBox(height: 5,),
                    Text(getDateString(trip.startDate))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.shopping_bag_rounded),
                    const SizedBox(height: 5,),
                    Text("Num of Friend Joined: " + trip.users.length.toString())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
