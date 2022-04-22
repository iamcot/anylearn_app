import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/dto/user_doc_dto.dart';
import 'package:anylearn/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../image_view.dart';

class UserDocList extends StatelessWidget {
  final List<UserDocDTO> userDocs;

  const UserDocList({key, required this.userDocs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [];
    userDocs.forEach((e) {
      images.add(e.data);
    });
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: (userDocs.length / 3).ceil().toDouble() * (width / 3),
      child: GridView.builder(
        itemCount: userDocs.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              open(context, index, images);
            },
            child: Card(
                elevation: 0,
                child: CustomCachedImage(
                  url: userDocs[index].data,
                )),
          );
        },
      ),
    );
  }

   void open(BuildContext context, final int index, List<String> galleryItems) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewScreen(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
          imageText: "Chứng chỉ", loadingBuilder: (BuildContext context, ImageChunkEvent? event) { 
            return LoadingWidget();
           },
        ),
      ),
    );
  }
}
