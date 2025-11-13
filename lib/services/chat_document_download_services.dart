import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/services/api_base_services.dart';

class ChatDocumentDownloadServices extends BaseServices {
  Future<MyResponse> downloadDocument() async {
    String path = 'https://www.orimi.com/pdf-test.pdf';
    String directory = '/storage/emulated/0/Download/';
    final savePath = '$directory/pdf-test.pdf';

    print('Saving document to: $savePath');

    return await callAPI(
      httpMethod: HttpMethod.download,
      path: path,
      savePath: savePath,
    );
  }
}
