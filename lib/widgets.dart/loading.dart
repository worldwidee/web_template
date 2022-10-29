import "package:flutter/material.dart";

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 9.3 / 10,
      height: MediaQuery.of(context).size.width * 8 / 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading Datas'),
        ],
      ),
    );
  }
}
