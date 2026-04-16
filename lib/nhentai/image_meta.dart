class ImageMeta {
  final String path;
  final num width;
  final num height;

  ImageMeta({
    required this.path,
    required this.width,
    required this.height,
  });

  factory ImageMeta.fromJson(Map<String, dynamic> json) {
    return ImageMeta(
      path: json['path'] as String,
      width: json['width'] as num,
      height: json['height'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'width': width,
      'height': height,
    };
  }
}
