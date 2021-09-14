// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reddit_clone_getx/controllers/mainController.dart';

class PostCard extends StatelessWidget {
  MainController mainController = Get.find();
  Map json;
  PostCard(this.json);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        mainController.launchURL(json['url']);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          json['thumbnail'],
        ),
      ),
      title: Text(
        json['author'],
        style: GoogleFonts.poppins(),
      ),
      subtitle: Text(
        json['title'],
        style: GoogleFonts.poppins(),
      ),
      trailing: SizedBox(
        width: 50,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                json['hit'].toString(),
                style: GoogleFonts.poppins(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      mainController.postUp(json);
                    },
                    child: Icon(
                      Icons.arrow_drop_up,
                      color: json['userUpped'] ? Colors.red : Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      mainController.postDown(json);
                    },
                    child: Icon(Icons.arrow_drop_down_sharp,
                        color: json['userDowned'] ? Colors.red : Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
