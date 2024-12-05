import 'package:flutter/material.dart';

class TripInvitationCard extends StatelessWidget {
  final String tripName;
  final int numberOfUsers;
  final int numberOfPlaces;
  final bool isAccepted;

  const TripInvitationCard({
    Key? key,
    required this.tripName,
    required this.numberOfUsers,
    required this.numberOfPlaces, required this.isAccepted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.card_travel, size: 28, color: Colors.blueAccent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tripName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.people, size: 20, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Text(
                    '$numberOfUsers Users',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.place, size: 20, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Text(
                    '$numberOfPlaces Places',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Is Invitation Accepted: ' + (isAccepted ? "Yes" : "No"),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
