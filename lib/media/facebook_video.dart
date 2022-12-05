import 'package:social_embed_inapp_webview/base/social_embed_data.dart';

class FaceBookVideo extends SocialEmbedData {
  FaceBookVideo({
    required String videoId,
    double? width,
    double? height,
  }) : super(
          targetUrl: videoId,
          width: width,
          height: height,
        );

  @override
  Uri? get baseUrl => Uri.parse('https://www.facebook.com/');

  @override
  String get htmlCode => '''
  <html>
  <body>
  
    <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v15.0&appId=528374865370048&autoLogAppEvents=1" nonce="mFgrZnZR"></script>
  
    <div class="fb-video" data-href="https://www.facebook.com/facebook/videos/$targetUrl/" data-width="500" data-show-text="false"><blockquote cite="https://www.facebook.com/facebook/videos/$targetUrl/" class="fb-xfbml-parse-ignore"></blockquote></div>
  </body>
  </html>
    ''';
}
