// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:reddit_clone_getx/Globals/constans.dart';
import 'package:reddit_clone_getx/services/fetch.dart';
import 'package:url_launcher/url_launcher.dart';

class MainController extends GetxController {
  var posts = [].obs;
  var shouldReload = true.obs;
  FetchData f = FetchData();
  getPosts() async {
    posts.value = await f.getTopPosts();
    changePostThumbnail();
    getPostHit();
  }

  postUp(Map json) {
    if (json['userUpped'] == false || json['userUpped'] == null) {
      //kullanici daha once upladi ise hiti 2 azaltiyorum
      if (json['userDowned'] == true) {
        json['hit']++;
        json['hit']++;
      } else {
        json['hit']++;
      }
      shouldReload.value = true;
      //iconlarin rengini belirlemek adina degiskenleri degistiriyorum
      json['userUpped'] = true;
      json['userDowned'] = false;
    }
  }

  postDown(Map json) {
    if (json['userDowned'] == false || json['userDowned'] == null) {
      //kullanici daha once upladi ise hiti 2 azaltiyorum
      if (json['userUpped'] == true) {
        json['hit']--;
        json['hit']--;
      } else {
        json['hit']--;
      }
      shouldReload.value = false;
      //iconlarin rengini belirlemek adina degiskenleri degistiriyorum
      json['userDowned'] = true;
      json['userUpped'] = false;
    }
  }

  changePostThumbnail() {
    for (int i = 0; i < posts.length; i++) {
      posts[i]['data']['userUpped'] = false;
      posts[i]['data']['userDowned'] = false;
      if (posts[i]['data']['thumbnail'] == 'self') {
        posts[i]['data']['thumbnail'] = urlSelfThumbnail;
      } else if (posts[i]['data']['thumbnail'] == 'default') {
        posts[i]['data']['thumbnail'] = urlDefaultThumbnail;
      }
    }
  }

  getPostHit() {
    for (int i = 0; i < posts.length; i++) {
      posts[i]['data']['hit'] =
          posts[i]['data']['ups'] - posts[i]['data']['downs'];
    }
  }

  void launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPosts();
  }
}
