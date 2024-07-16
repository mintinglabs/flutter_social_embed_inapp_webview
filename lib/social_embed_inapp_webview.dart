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

class _SocialEmbedInAppWebViewState extends State<SocialEmbedInAppWebView>
    with WidgetsBindingObserver {
  bool _onLoadStopCalled = false;

  late final InAppWebViewController wbController;
  late String htmlBody;

  @override
  void initState() {
    super.initState();
    if (widget.embedData.supportMediaControl) {
      WidgetsBinding.instance!.addObserver(this);
    }
  }

  @override
  void dispose() {
    if (widget.embedData.supportMediaControl) {
      WidgetsBinding.instance!.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        wbController.evaluateJavascript(source: 'stopVideo()');
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        wbController.evaluateJavascript(source: 'pauseVideo()');
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.embedData.height ?? 400,
      width: widget.embedData.width ?? 400,
      child: InAppWebView(
        key: widget.key,
        initialData: InAppWebViewInitialData(
          data: widget.embedData.htmlCode,
          baseUrl: WebUri.uri(widget.embedData.baseUrl!),
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
            preferredContentMode: UserPreferredContentMode.MOBILE,
            userAgent:
                'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36',
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
            allowsAirPlayForMediaPlayback: true,
            allowsPictureInPictureMediaPlayback: true,
            enableViewportScale: true,
            // contentInsetAdjustmentBehavior:
            //     IOSUIScrollViewContentInsetAdjustmentBehavior.ALWAYS,
          ),
          android: AndroidInAppWebViewOptions(
            useWideViewPort: false,
            // useHybridComposition: controller!.flags.useHybridComposition,
          ),
        ),
        onWebViewCreated: (webController) {
          wbController = webController;
        },
        onLoadError: (InAppWebViewController controller, Uri? url, int code,
            String message) {
          print('load error msg:$message  code:$code ');
        },
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
