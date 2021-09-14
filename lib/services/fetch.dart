import 'package:get/get.dart';
import 'package:reddit_clone_getx/services/urls.dart';

import 'rest_connector.dart';

class FetchData extends GetxController {
  getTopPosts() async {
    var response = await RestConnector(
      domain + urlGetTopPosts,
      requestType: "GET",
      data: '',
    ).getData();
    return response['data']['children'];
  }
}
