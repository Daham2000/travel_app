import 'package:flutter/material.dart';
import 'package:travel_app/db/model/comment.dart';

class CommentSectionView extends StatelessWidget {
  final Comment comment;

  const CommentSectionView({super.key, required this.comment});

  String getTimeGap() {
    final now = DateTime.now();
    DateTime date = DateTime.parse(comment.commentTime.toDate().toString());
    final timeDifferance = now.difference(date);
    print("timeDifferance: " + timeDifferance.inDays.toString());
    if (timeDifferance.inDays > 60) {
      return (timeDifferance.inDays / 7).toString();
    } else {
      return timeDifferance.inDays.toString();
    }
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  comment.userName,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  getTimeGap() + " minutes ago",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              comment.commentDescription,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
            ),
          )
        ],
      ),
    );
  }
}
