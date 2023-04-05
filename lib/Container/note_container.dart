// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../global.dart';
//
// Widget noteCard(Function()? onTap, DocumentSnapshot doc) {
//   return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(8),
//         margin: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Global.cardsColor[doc['color_id']],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               doc["note_title"],
//               style: Global.main,
//             ),
//             SizedBox(
//               height: 4,
//             ),
//             Text(
//               doc['creation_date'],
//               style: Global.ddtaTitle,
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               doc['note_content'],
//               style: Global.maincontent,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ));
// }
