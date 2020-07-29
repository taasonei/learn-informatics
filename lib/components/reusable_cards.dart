import 'package:flutter/material.dart';
import 'package:learninformatics/screens/webview_screen.dart';
import 'package:learninformatics/components/styles.dart';
import 'dart:convert' show utf8;

class URLCard extends StatelessWidget {
  URLCard({this.title, this.subtitle, @required this.url});
  final String title;
  final String subtitle;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(5.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(13.0),
        title: Text(
          title,
          style: kCardTitleText,
        ),
        subtitle: Text(
          subtitle,
          style: kCardSubtitleText,
        ),
        onTap: () {
          if (url != null) {
            var decodedUrl = utf8.decode(utf8.encode(url));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => WebViewScreen(
                  title: title,
                  selectedUrl:
                      'https://drive.google.com/viewerng/viewer?embedded=true&url=' +
                          decodedUrl,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class EnabledCard extends StatelessWidget {
  EnabledCard({this.title, this.onTap, this.enabled});
  final String title;
  final Function onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
        title: Text(
          title,
          style: kCardTitleText,
        ),
        enabled: enabled ?? false,
        onTap: onTap ?? () {},
      ),
    );
  }
}
