import 'package:flutter/material.dart';
import 'package:travel_app/db/model/comment.dart';

class CommentSectionView extends StatelessWidget {
  final Comment comment;

  const CommentSectionView({super.key, required this.comment});

  List<String> getTimeGap() {
    final now = DateTime.now();
    DateTime date;
    if (comment.commentTime is DateTime) {
      date = comment.commentTime;
    } else {
      date = DateTime.parse(comment.commentTime.toDate().toString());
    }
    print(("date" + date.toString()));
    final timeDifferance = now.difference(date);
    print("timeDifferance: " + timeDifferance.inHours.toString());
    if (timeDifferance.inHours > 24) {
      return [(timeDifferance.inDays).toString(), "Days"];
    } else if (timeDifferance.inDays > 60) {
      return [(timeDifferance.inDays / 7).toString(), "Weeks"];
    } else {
      return [timeDifferance.inHours.toString(), "Hours"];
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
                  getTimeGap()[0] + " ${getTimeGap()[1]} ago",
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
