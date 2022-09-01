import 'dart:async';

import 'package:anime_downloader/model/description.dart';
import 'package:anime_downloader/repository/description_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class DescriptionBloc {
  late DescriptionRepository _descriptionRepository;
  late StreamController<ApiResponse<DescriptionModel>> _descriptionController;

  StreamSink<ApiResponse<DescriptionModel>> get descriptionSink =>
      _descriptionController.sink;

  Stream<ApiResponse<DescriptionModel>> get descriptionStream =>
      _descriptionController.stream;

  DescriptionBloc({required String link}) {
    _descriptionController = StreamController<ApiResponse<DescriptionModel>>();
    _descriptionRepository = DescriptionRepository();
    fetchDescription(link: link);
  }

  fetchDescription({required String link}) async {
    descriptionSink.add(ApiResponse.loading('Fetching Description'));
    try {
      DescriptionModel desc =
          await _descriptionRepository.fetchDesc(link: link);
      descriptionSink.add(ApiResponse.completed(desc));
    } catch (e) {
      descriptionSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _descriptionController.close();
  }
}
