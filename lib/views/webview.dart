import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TutorWebScreen extends StatefulWidget {
  const TutorWebScreen({super.key});

  @override
  State<TutorWebScreen> createState() => _TutorWebScreenState();
}

class _TutorWebScreenState extends State<TutorWebScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome',
      home: Scaffold
      (
        appBar: AppBar(
        title: Text("nice"),
        ),
        body: WebView(
          initialUrl:"https://www.youtube.com/watch?v=dQw4w9WgXcQ",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}