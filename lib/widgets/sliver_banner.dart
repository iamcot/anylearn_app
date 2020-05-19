import 'package:flutter/material.dart';

class SliverBanner extends StatelessWidget {
  final String banner;

  const SliverBanner({Key key, this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width / 3;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: height,
            child: Image.network(
              this.banner,
              fit: BoxFit.cover,
            ),
          ),
          Divider(
            height: 0.0,
            thickness: 1.0,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
