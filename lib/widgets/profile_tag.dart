import 'package:flutter/material.dart';

class ProfileTag extends StatelessWidget {
  const ProfileTag({Key? key, required this.future, required this.tag})
      : super(key: key);

  final Future future;
  final String tag;

  @override
  Widget build(BuildContext context) {
    const double fontSizeText = 16;
    const FontWeight fontWeightText = FontWeight.bold;

    return Column(
      children: [
        FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot snapshotPost) {
              if (snapshotPost.data == null) {
                return const Text(
                  '0',
                  style: TextStyle(
                    fontWeight: fontWeightText,
                    fontSize: fontSizeText,
                  ),
                );
              }
              return Text(
                snapshotPost.data.length.toString(),
                style: const TextStyle(
                  fontWeight: fontWeightText,
                  fontSize: fontSizeText,
                ),
              );
            }),
        const SizedBox(height: 6),
        Text(
          tag,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
