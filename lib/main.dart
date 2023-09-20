import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_view_demo/controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(
        kDebugMode);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dr Israr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("InAppWebView Demo"),
        ),
        body: Container(
          child: InAppWebView(
            key: controller.webViewKey,
            initialUrlRequest: URLRequest(
              url: Uri.parse(
                  "https://data.ismart.link/web_view/emergency_form?trip_id=9a2d89e7-7235-4950-b796-c270bbd8f113&vehicle_id=8"),
            ),
            pullToRefreshController: controller.pullToRefreshController,
            initialOptions: controller.options,
            // onLoadStop: controller.onLoadStop,
            onWebViewCreated: (webController) {
              controller.webViewController = webController;
              controller.webViewController?.addJavaScriptHandler(
                handlerName: 'submitFromWeb',
                callback: (arguments) {
                  Get.back();
                },
              );
            },
            androidOnPermissionRequest: (InAppWebViewController controller,
                String origin, List<String> resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
          ),
        ),
      ),
    );
  }
}
