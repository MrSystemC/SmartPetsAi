class FeedPost {
  const FeedPost({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.petName,
    required this.text,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  final String id;
  final String authorName;
  final String authorAvatar;
  final String petName;
  final String text;
  final String imageUrl;
  final int likes;
  final int comments;
  final DateTime createdAt;

  factory FeedPost.fromJson(Map<String, dynamic> json) {
    return FeedPost(
      id: json['id'] as String? ?? '',
      authorName: json['authorName'] as String? ?? '',
      authorAvatar: json['authorAvatar'] as String? ?? '',
      petName: json['petName'] as String? ?? '',
      text: json['text'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
