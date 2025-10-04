import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/model/youtube_response_model/youtube_response_model.dart';
import 'package:mpma_assignment/services/home_tips_services.dart';

class HomeTipsRepository {
  HomeTipsRepository({required this.homeTipsServices});

  final HomeTipsServices homeTipsServices;

  Future<MyResponse> getAllYoutubeVideos() async {
    final response = await homeTipsServices.getAllYoutubeVideos();

    if (response.data is Map<String, dynamic>) {
      final resultModel = YoutubeResponseModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
