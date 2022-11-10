// import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';


// class GridImage extends StatelessWidget {
//   final PostDTO photos;
//   final double padding;

//   const GridImage({
//     Key? key,
//     required this.photos,
//     this.padding = 12,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width - padding;
//     return buildImageGrid(photos, width, context);
//   }

//   Widget buildImageGrid(
//       PostDTO photos, double width, BuildContext context) {
//     switch (photos) {
//       case 0:
//         return const SizedBox();
//       case 1:
//         return _buildOneImage(photos, width, context);
//       // case 2:
//       //   return _buildTwoImage(photos, width, context);
//       // case 3:
//       //   return _buildThreeImage(photos, width, context);
//       case 4:
//         return const SizedBox();
//       case 5:
//         return const SizedBox();
//       default:
//         return _buildOneImage(photos[0], width, context);
//     }
//   }

//   Widget _buildOneImage(PostDTO photo, double width, BuildContext context) {
//     final image = photo.images;

//     return GestureDetector(
//       onTap: () => navigateToPhotoPage([photo], 0, context),
//       child: SizedBox(
//         height: 300,
//         width: width,
//         child: CachedNetworkImage(
//           imageUrl: image!,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   // Widget _buildTwoImage(
//   //     List<PostDTO> photos, double width, BuildContext context) {
//   //   final firstImg = photos[0].images;

//   //   // Vertical style
//   //   if (firstImg!.orgWidth! > firstImg.orgHeight!) {
//   //     final height = width - padding;
//   //     return SizedBox(
//   //       height: width,
//   //       child: Column(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: <Widget>[
//   //           PostImgItem(
//   //             url: photos[0].url,
//   //             width: width,
//   //             height: height / 2,
//   //             onTap: () => navigateToPhotoPage(photos, 0, context),
//   //           ),
//   //           _buildPadding(),
//   //           PostImgItem(
//   //             url: photos[1].url,
//   //             width: width,
//   //             height: height / 2,
//   //             onTap: () => navigateToPhotoPage(photos, 0, context),
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //   }

//   //   final height = width;
//   //   width = width - padding;
//   //   return Row(
//   //     children: <Widget>[
//   //       PostImgItem(
//   //         url: photos[0].url,
//   //         width: width / 2,
//   //         height: height,
//   //         onTap: () => navigateToPhotoPage(photos, 0, context),
//   //       ),
//   //       _buildPadding(),
//   //       PostImgItem(
//   //         url: photos[1].url,
//   //         width: width / 2,
//   //         height: height,
//   //         onTap: () => navigateToPhotoPage(photos, 0, context),
//   //       ),
//   //     ],
//   //   );
//   // }

//   // Padding _buildPadding() => Padding(
//   //       padding: EdgeInsets.only(left: padding, top: padding),
//   //     );

//   // Widget _buildThreeImage(
//   //     List<Photo> photos, double width, BuildContext context) {
//   //   final firstImg = photos[0].image;

//   //   // first vertical style images
//   //   if (firstImg!.orgHeight! > firstImg.orgWidth!) {
//   //     final height = width;
//   //     final itemHeight = height;
//   //     final itemWidth = width - padding;
//   //     return SizedBox(
//   //       height: height,
//   //       child: Row(
//   //         crossAxisAlignment: CrossAxisAlignment.stretch,
//   //         children: <Widget>[
//   //           PostImgItem(
//   //             url: photos[0].url,
//   //             width: itemWidth / 2,
//   //             height: itemHeight,
//   //             onTap: () => navigateToPhotoPage(photos, 0, context),
//   //           ),
//   //           _buildPadding(),
//   //           Column(
//   //             children: <Widget>[
//   //               PostImgItem(
//   //                 url: photos[1].url,
//   //                 width: itemWidth / 2,
//   //                 height: (itemHeight - padding) / 2,
//   //                 onTap: () => navigateToPhotoPage(photos, 1, context),
//   //               ),
//   //               _buildPadding(),
//   //               PostImgItem(
//   //                 url: photos[2].url,
//   //                 width: itemWidth / 2,
//   //                 height: (itemHeight - padding) / 2,
//   //                 onTap: () => navigateToPhotoPage(photos, 2, context),
//   //               ),
//   //             ],
//   //           )
//   //         ],
//   //       ),
//   //     );
//   //   }

//   //   final height = width;
//   //   final itemWidth = (width - padding) / 2;
//   //   final itemHeight = (height - padding) / 2;
//   //   return SizedBox(
//   //     height: height,
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.stretch,
//   //       children: <Widget>[
//   //         Row(
//   //           children: <Widget>[
//   //             PostImgItem(
//   //               url: photos[1].url,
//   //               width: itemWidth,
//   //               height: itemHeight,
//   //               onTap: () => navigateToPhotoPage(photos, 1, context),
//   //             ),
//   //             _buildPadding(),
//   //             PostImgItem(
//   //               url: photos[2].url,
//   //               width: itemWidth,
//   //               height: itemHeight,
//   //               onTap: () => navigateToPhotoPage(photos, 2, context),
//   //             ),
//   //           ],
//   //         ),
//   //         _buildPadding(),
//   //         PostImgItem(
//   //           url: photos[0].url,
//   //           width: width,
//   //           height: itemHeight,
//   //           onTap: () => navigateToPhotoPage(photos, 0, context),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   void navigateToPhotoPage(
//       List<PostDTO> photos, int index, BuildContext context) {}
// }
