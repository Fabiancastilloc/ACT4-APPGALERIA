class ImageModel {
  final int id;
  final String pageURL;
  final String type;
  final String tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageURL;
  final String fullHDURL; 

 
  ImageModel({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatURL,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageURL,
    this.fullHDURL = '', 
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] ?? 0, 
      pageURL: json['pageURL'] ?? '',
      type: json['type'] ?? '',
      tags: json['tags'] ?? '',
      previewURL: json['previewURL'] ?? '',
      previewWidth: json['previewWidth'] ?? 0,
      previewHeight: json['previewHeight'] ?? 0,
      webformatURL: json['webformatURL'] ?? '',
      webformatWidth: json['webformatWidth'] ?? 0,
      webformatHeight: json['webformatHeight'] ?? 0,
      largeImageURL: json['largeImageURL'] ?? '',
      fullHDURL: json['videos']?['fullHDURL'] ?? '',
    );
  }
}
