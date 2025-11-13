import 'package:mpma_assignment/repository/chat_document_download_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class ChatViewModel extends BaseViewModel {
  ChatViewModel({required this.chatDocumentDownloadRepository});

  final ChatDocumentDownloadRepository chatDocumentDownloadRepository;

  Future<void> downloadDocument() async {
    final response = await chatDocumentDownloadRepository.downloadDocument();

    checkError(response);
  }
}
