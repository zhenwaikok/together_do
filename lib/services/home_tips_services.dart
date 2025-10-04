import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/services/api_base_services.dart';

class HomeTipsServices extends BaseServices {
  Future<MyResponse> getAllYoutubeVideos() async {
    String path =
        '${apiUrl()}/search?part=snippet&q=cleaning+hacks|organizing+house+tips|laundry+tutorial&type=video&videoDuration=medium&maxResults=20&key=${apiKey()}';

    return await callAPI(httpMethod: HttpMethod.get, path: path);
  }
}
