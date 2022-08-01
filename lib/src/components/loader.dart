import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double weigth;
  final Color? color;
  const Loader({Key? key, this.weigth = 20, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: weigth,
        height: weigth,
        child: CircularProgressIndicator(color: color),
      ),
    );
  }
}
