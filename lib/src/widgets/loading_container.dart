import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        const Divider(height: 8.0)
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey.shade200,
      height: 24.0,
      width: 150.0,
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
