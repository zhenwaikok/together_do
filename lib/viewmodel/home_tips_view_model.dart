import 'package:mpma_assignment/model/youtube_response_model/youtube_response_model.dart';
import 'package:mpma_assignment/repository/home_tips_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class HomeTipsViewModel extends BaseViewModel {
  HomeTipsViewModel({required this.homeTipsRepository});

  final HomeTipsRepository homeTipsRepository;

  YoutubeResponseModel? _youtubeResponse;
  YoutubeResponseModel? get youtubeResponse => _youtubeResponse;

  Future<void> fetchAllHomeTipsVideos() async {
    final response = await homeTipsRepository.getAllYoutubeVideos();

    if (response.data is YoutubeResponseModel) {
      _youtubeResponse = response.data;
      notifyListeners();
    }

    checkError(response);
  }
}
