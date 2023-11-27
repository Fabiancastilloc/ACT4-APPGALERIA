import 'package:galeria_reales/models/image_model.dart';

class SavedImages {
  List<ImageModel> _savedImages = [];

  List<ImageModel> get savedImages => _savedImages;

  void addImage(ImageModel image) {
    _savedImages.add(image);
  }

  void removeImage(ImageModel image) {
    _savedImages.remove(image);
  }
}
