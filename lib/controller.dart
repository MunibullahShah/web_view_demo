import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  // late WebViewController webViewController;

  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  final GlobalKey webViewKey = GlobalKey();

  @override
  void onInit() {
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    // webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(Color(0x00000000))
    //   ..loadRequest(Uri.parse("http://smarttrack.ismart.link/dashboard"))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         debugPrint("WebView is loading (progress : $progress%)");
    //         if (progress == 100) {
    //           isLoading.value = false;
    //         } else {
    //           isLoading.value = true;
    //         }
    //       },
    //       onWebResourceError: (WebResourceError error) {
    //         // Get.rawSnackbar(
    //         //   backgroundColor: Colors.red,
    //         //   messageText: Text(
    //         //     "Error: ${error.description}",
    //         //     style: const TextStyle(
    //         //       fontSize: 16,
    //         //       color: Colors.white,
    //         //       fontWeight: FontWeight.bold,
    //         //     ),
    //         //   ),
    //         // );
    //       },
    //     ),
    //   );
    super.onInit();
  }

  // Future<void> onLoadStop(InAppWebViewController controller, Uri? url) async {
  //   const jsCode = """
  //           function handleOnClick() {
  //             call_android_bridge('finish');
  //           }
  //
  //           // Find the anchor element by its class
  //           var anchorElement = document.querySelector('.btn-fixed.right.btn-floating.waves-effect.waves-light.float-end.me-2.btn-large');
  //
  //           // Add an event listener to the anchor element
  //           anchorElement.addEventListener('click', function(event) {
  //             // Prevent the default action of the anchor element (e.g., following the href)
  //             event.preventDefault();
  //
  //             // Call the custom function to handle the onclick action
  //             handleOnClick();
  //           });
  //         """;
  //   var evaluation =
  //       await webViewController?.evaluateJavascript(source: jsCode);
  //   print(evaluation);
  // }
}
