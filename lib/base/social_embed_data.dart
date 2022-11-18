abstract class SocialEmbedData {
  const SocialEmbedData({
    this.baseUrl,
    this.aspectRatio,
    this.width,
    this.height,
    this.supportMediaControl = false,
    required this.targetUrl,
  });
  final bool supportMediaControl;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final Uri? baseUrl;
  final String targetUrl;
  String get htmlCode => '';
  String get javaScript => '';
  String get pauseVideoScript => '';
  String get startVideoScript => '';
  String get stopVideoScript => '';
}
