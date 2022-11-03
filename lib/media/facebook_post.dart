import 'package:social_embed_inapp_webview/base/social_embed_data.dart';

class FaceBookPost extends SocialEmbedData {
  FaceBookPost({
    required String targetUrl,
    double? width,
    double? height,
  }) : super(
          targetUrl: targetUrl,
          width: width,
          height: height,
        );

  @override
  Uri? get baseUrl => Uri.parse('https://www.facebook.com/');

  @override
  String get htmlCode => '''
  <html>
  <body>
    <script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>  
    <div class="fb-post" data-href="$targetUrl"></div>
  </body>
  </html>
    ''';
}
