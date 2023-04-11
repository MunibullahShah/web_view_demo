import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Controller extends GetxController {
  late WebViewController webViewController;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..loadRequest(Uri.parse("https://www.clips.drisrar.com/"))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("WebView is loading (progress : $progress%)");
            if (progress == 100) {
              isLoading.value = false;
            } else {
              isLoading.value = true;
            }
          },
          onWebResourceError: (WebResourceError error) {
            Get.rawSnackbar(
              backgroundColor: Colors.red,
              messageText: Text(
                "Error: ${error.description}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      );
    super.onInit();
  }
}
