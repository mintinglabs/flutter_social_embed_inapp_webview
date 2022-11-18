import 'package:social_embed_inapp_webview/base/social_embed_data.dart';

class YoutubeVideo extends SocialEmbedData {
  YoutubeVideo({
    required String targetUrl,
    double? width,
    double? height,
  }) : super(
          targetUrl: targetUrl,
          width: width,
          height: height,
          supportMediaControl: true,
        );

  @override
  Uri? get baseUrl => Uri.parse('https://www.youtube.com/');

  @override
  String get htmlCode => '''
<!DOCTYPE html>
<html>
  <body>
    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player"></div>

    <script>
      // 2. This code loads the IFrame Player API code asynchronously.
      var tag = document.createElement('script');

      tag.src = "https://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      // 3. This function creates an <iframe> (and YouTube player)
      //    after the API code downloads.
      var player;
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
          height: '100%',
          width: '100%',
          videoId: '${targetUrl.split('/').last}',
          events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange,
             'onError': onPlayerError
          },


        });
      }

      // 4. The API will call this function when the video player is ready.
      function onPlayerReady(event) {
        event.target.playVideo();
      }

        function onPlayerError(error) {
        console.log(error);
      }

      function stopVideo() {
        player.stopVideo();
      }

      function pauseVideo() {
        player.pauseVideo();
      }

    </script>
  </body>
</html>
    ''';

// @override
//   String get htmlCode => '''
//    <!DOCTYPE html>
//     <html>
//     <head>
//         <style>
//             html,
//             body {
//                 margin: 0;
//                 padding: 0;
//                 background-color: #000000;
//                 overflow: hidden;
//                 position: fixed;
//                 height: 100%;
//                 width: 100%;
//                 pointer-events: none;
//             }
//         </style>
//         <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
//     </head>
//     <body>
//         <div id="player"></div>
//         <script>
//             var tag = document.createElement('script');
//             tag.src = "https://www.youtube.com/iframe_api";
//             var firstScriptTag = document.getElementsByTagName('script')[0];
//             firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
//             var player;
//             var timerId;
//             function onYouTubeIframeAPIReady() {
//                 player = new YT.Player('player', {
//                     height: '100%',
//                     width: '100%',
//                     videoId: '${controller!.initialVideoId}',
//                     playerVars: {
//                         'controls': 0,
//                         'playsinline': 1,
//                         'enablejsapi': 1,
//                         'fs': 0,
//                         'rel': 0,
//                         'showinfo': 0,
//                         'iv_load_policy': 3,
//                         'modestbranding': 1,
//                         'cc_load_policy': ${boolean(value: controller!.flags.enableCaption)},
//                         'cc_lang_pref': '${controller!.flags.captionLanguage}',
//                         'autoplay': ${boolean(value: controller!.flags.autoPlay)},
//                         'start': ${controller!.flags.startAt},
//                         'end': ${controller!.flags.endAt}
//                     },
//                     events: {
//                         onReady: function(event) { window.flutter_inappwebview.callHandler('Ready'); },
//                         onStateChange: function(event) { sendPlayerStateChange(event.data); },
//                         onPlaybackQualityChange: function(event) { window.flutter_inappwebview.callHandler('PlaybackQualityChange', event.data); },
//                         onPlaybackRateChange: function(event) { window.flutter_inappwebview.callHandler('PlaybackRateChange', event.data); },
//                         onError: function(error) { window.flutter_inappwebview.callHandler('Errors', error.data); }
//                     },
//                 });
//             }
//
//             function sendPlayerStateChange(playerState) {
//                 clearTimeout(timerId);
//                 window.flutter_inappwebview.callHandler('StateChange', playerState);
//                 if (playerState == 1) {
//                     startSendCurrentTimeInterval();
//                     sendVideoData(player);
//                 }
//             }
//
//             function sendVideoData(player) {
//                 var videoData = {
//                     'duration': player.getDuration(),
//                     'title': player.getVideoData().title,
//                     'author': player.getVideoData().author,
//                     'videoId': player.getVideoData().video_id
//                 };
//                 window.flutter_inappwebview.callHandler('VideoData', videoData);
//             }
//
//             function startSendCurrentTimeInterval() {
//                 timerId = setInterval(function () {
//                     window.flutter_inappwebview.callHandler('VideoTime', player.getCurrentTime(), player.getVideoLoadedFraction());
//                 }, 100);
//             }
//
//             function play() {
//                 player.playVideo();
//                 return '';
//             }
//
//             function pause() {
//                 player.pauseVideo();
//                 return '';
//             }
//
//             function loadById(loadSettings) {
//                 player.loadVideoById(loadSettings);
//                 return '';
//             }
//
//             function cueById(cueSettings) {
//                 player.cueVideoById(cueSettings);
//                 return '';
//             }
//
//             function loadPlaylist(playlist, index, startAt) {
//                 player.loadPlaylist(playlist, 'playlist', index, startAt);
//                 return '';
//             }
//
//             function cuePlaylist(playlist, index, startAt) {
//                 player.cuePlaylist(playlist, 'playlist', index, startAt);
//                 return '';
//             }
//
//             function mute() {
//                 player.mute();
//                 return '';
//             }
//
//             function unMute() {
//                 player.unMute();
//                 return '';
//             }
//
//             function setVolume(volume) {
//                 player.setVolume(volume);
//                 return '';
//             }
//
//             function seekTo(position, seekAhead) {
//                 player.seekTo(position, seekAhead);
//                 return '';
//             }
//
//             function setSize(width, height) {
//                 player.setSize(width, height);
//                 return '';
//             }
//
//             function setPlaybackRate(rate) {
//                 player.setPlaybackRate(rate);
//                 return '';
//             }
//
//             function setTopMargin(margin) {
//                 document.getElementById("player").style.marginTop = margin;
//                 return '';
//             }
//         </script>
//     </body>
//     </html>
//   ''';

}
