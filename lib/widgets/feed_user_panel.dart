import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyFeedUserPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final String user_image;
  final Function() more_button_tap;
  const MyFeedUserPanel(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.user_image,
      required this.more_button_tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.only(left: 10.0),
      width: double.infinity,
      child: Row(
        children: [
          _circleAvatar(user_image),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5)),
                subtitle.isNotEmpty ? SizedBox(height: 2.0) : SizedBox.shrink(),
                subtitle.isNotEmpty
                    ? Text(subtitle,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal))
                    : SizedBox.shrink()
              ],
            ),
          ),
          SizedBox(width: 10.0),
          // @ more button
          Container(
            height: 50,
            width: 50,
            child: Material(
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                onTap: more_button_tap,
                borderRadius: BorderRadius.circular(25),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _circleAvatar(String url) => CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        imageBuilder: (con, imageProvider) => Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
      );
}
