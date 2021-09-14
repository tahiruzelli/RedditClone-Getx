// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reddit_clone_getx/Globals/widgets/postCard.dart';
import 'package:reddit_clone_getx/controllers/mainController.dart';

class HomePage extends StatelessWidget {
  MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            backgroundColor: Colors.grey[300],
            elevation: 5,
            title: Text(
              'Reddit Clone',
              style: GoogleFonts.poppins(
                color: Colors.black,
              ),
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return PostCard(mainController.posts[index]['data']);
                },
                childCount: mainController.posts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
