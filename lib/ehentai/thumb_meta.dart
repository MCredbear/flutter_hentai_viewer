class ThumbMeta {
  final String url;
  final double width;
  final double height;
  final double offsetX;
  final String href;

  ThumbMeta({
    required this.url,
    required this.width,
    required this.height,
    required this.offsetX,
    required this.href,
  });

  factory ThumbMeta.fromJson(Map<String, dynamic> json) {
    return ThumbMeta(
      url: json['url'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      offsetX: (json['offset_x'] as num).toDouble(),
      href: json['href'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'width': width,
      'height': height,
      'offset_x': offsetX,
      'href': href,
    };
  }
}
