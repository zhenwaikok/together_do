import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/services/chat_document_download_services.dart';

class ChatDocumentDownloadRepository {
  ChatDocumentDownloadRepository({required this.chatDocumentDownloadServices});

  final ChatDocumentDownloadServices chatDocumentDownloadServices;

  Future<MyResponse> downloadDocument() async {
    final response = await chatDocumentDownloadServices.downloadDocument();
    print('Document download response: $response');
    return response;
  }
}
