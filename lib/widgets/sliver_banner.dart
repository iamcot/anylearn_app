import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:flutter/material.dart';

class SliverBanner extends StatelessWidget {
  final String banner;

  const SliverBanner({required this.banner});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 2 / 3;
    return SliverToBoxAdapter(
      child: banner != null && banner.isNotEmpty
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  height: height,
                  child: CustomCachedImage(url: banner),
                ),
                Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: Colors.black12,
                ),
              ],
            )
          : SizedBox(
              height: 0,
            ),
    );
  }
}
