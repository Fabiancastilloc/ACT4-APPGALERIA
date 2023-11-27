class VideoModel {
  final int id;
  final String pageURL;
  final String type;
  final String tags;
  final int duration;
  final String pictureId;
  final Map<String, Map<String, dynamic>> videos;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageURL;

  VideoModel({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.duration,
    required this.pictureId,
    required this.videos,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      pageURL: json['pageURL'],
      type: json['type'],
      tags: json['tags'],
      duration: json['duration'],
      pictureId: json['picture_id'],
      videos: Map<String, Map<String, dynamic>>.from(json['videos']),
      views: json['views'],
      downloads: json['downloads'],
      likes: json['likes'],
      comments: json['comments'],
      userId: json['user_id'],
      user: json['user'],
      userImageURL: json['userImageURL'],
    );
  }
}
