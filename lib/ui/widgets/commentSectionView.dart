import 'package:flutter/material.dart';

class CommentSectionView extends StatelessWidget {
  const CommentSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/userIcon.png",
                width: 14,
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5.0),
                child: Text(
                  "John Cick",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5.0),
                child: Text(
                  "2 minutes ago",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.grey),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "Big Ben is the nickname for the Great Bell of the Great Clock of Westminster, and, by extension",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
            ),
          )
        ],
      ),
    );
  }
}
