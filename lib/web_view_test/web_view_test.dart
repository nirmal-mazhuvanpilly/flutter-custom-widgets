import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({super.key});

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  List<Map<String, String>> cookies = [
    {
      "name": "_fbp",
      "value": "fb.1.1712669475473.1444055679",
      "domain": ".h5p.com",
    },
    {
      "name": "_ga",
      "value": "GA1.1.1723379496.1712669475",
      "domain": ".h5p.com",
    },
    {
      "name": "_ga_J6PFFGTST3",
      "value": "GS1.1.1712669475.1.1.1712669527.8.0.0",
      "domain": ".h5p.com",
    },
    {
      "name": "_gcl_au",
      "value": "1.1.1187033999.1712669475",
      "domain": ".h5p.com",
    },
  ];

  final controller = WebViewController();
  final cookieManager = WebViewCookieManager();
  final cookieMan = WebviewCookieManager();

  setCookies() async {
    for (var element in cookies) {
      cookieManager.setCookie(WebViewCookie(
          name: element["name"] ?? "",
          value: element["value"] ?? "",
          domain: element["domain"] ?? ""));
    }
  }

  getCookies() async {
    final res = await cookieMan.getCookies("wac.h5p.com");
    for (var element in res) {
      print(element.name);
    }
    final res2 = await cookieMan.getCookies(".h5p.com");
    for (var element in res2) {
      print(element.name);
    }
    print(res);
  }

  @override
  void initState() {
    // cookieManager.clearCookies();
    // setCookies();
    // getCookies();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) async {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );
    controller.setOnConsoleMessage((message) {
      print("******\nmessage from web: ${message.message}\n********");
    });
    // controller.addJavaScriptChannel('Toaster',
    //     onMessageReceived: (JavaScriptMessage message) {
    //      // ignore: deprecated_member_use,
    //       print("******\nmessage from web: ${message.message}\n********");
    //     });
    controller.loadRequest(
      Uri.parse('https://race2excellence.webc.in/h5p-latest.html'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.loadRequest(Uri.parse("https://wac.h5p.com/"));
        },
      ),
    );
  }
}
