import 'package:anime_downloader/model/description_model.dart';
import 'package:anime_downloader/services/api_service.dart';

class DescriptionRepository {
  ApiService _service = ApiService();

  Future<DescriptionModel> desc({String link}) async {
    final response = await _service.get('/desc?link=$link');
    return DescriptionModel.fromJson(response);
  }
}
