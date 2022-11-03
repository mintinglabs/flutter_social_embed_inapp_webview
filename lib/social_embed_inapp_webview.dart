import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:social_embed_inapp_webview/base/social_embed_data.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialEmbedInAppWebView extends StatefulWidget {
  const SocialEmbedInAppWebView({
    Key? key,
    required this.embedData,
  }) : super(key: key);

  final SocialEmbedData embedData;

  @override
  State<SocialEmbedInAppWebView> createState() =>
      _SocialEmbedInAppWebViewState();
}

class _SocialEmbedInAppWebViewState extends State<SocialEmbedInAppWebView> {
  bool _onLoadStopCalled = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.embedData.height ?? 400,
      width: widget.embedData.width ?? 400,
      child: InAppWebView(
        key: widget.key,
        initialData: InAppWebViewInitialData(
          data: widget.embedData.htmlCode,
          baseUrl: widget.embedData.baseUrl,
          encoding: 'utf-8',
          mimeType: 'text/html',
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
            transparentBackground: true,
            disableContextMenu: true,
            supportZoom: false,
            disableHorizontalScroll: false,
            disableVerticalScroll: false,
            useShouldOverrideUrlLoading: true,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
            allowsAirPlayForMediaPlayback: true,
            allowsPictureInPictureMediaPlayback: true,
          ),
          android: AndroidInAppWebViewOptions(
            useWideViewPort: false,
            // useHybridComposition: controller!.flags.useHybridComposition,
          ),
        ),
        onWebViewCreated: (webController) {},
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          final uri = navigationAction.request.url;

          if (_onLoadStopCalled &&
              navigationAction.isForMainFrame &&
              uri != null &&
              await canLaunchUrl(uri)) {
            // do whatever you want and cancel the request.
            launchUrl(uri, mode: LaunchMode.externalApplication);
            return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (_, __) {
          _onLoadStopCalled = true;
        },
      ),
    );
  }
}
