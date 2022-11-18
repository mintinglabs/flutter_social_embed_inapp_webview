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
  <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
  <body>
  <div style="width:${width}px">
  <div class="fb-post" data-href="$targetUrl"  style="width:100%"></div>
  </div>
  <script async defer src="https://connect.facebook.net/en_US/sdk.js"></script>
  <script>
  window.fbAsyncInit = function() {
    FB.init({
      xfbml      : true,
      version    : 'v15.0'
    });
  };
  </script>
  </body>
  </html>
    ''';
}
