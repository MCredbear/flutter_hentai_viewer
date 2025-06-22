class ImageMeta {
  final String url;
  final double width;
  final double height;

  ImageMeta({
    required this.url,
    required this.width,
    required this.height,
  });

  factory ImageMeta.fromJson(Map<String, dynamic> json) {
    return ImageMeta(
      url: json['url'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }
}
