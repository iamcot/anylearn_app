import 'package:anylearn/blocs/images/image_bloc.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCachedImage extends StatefulWidget {
  final String url;
  final fit;
  final borderRadius;
  Widget? errorFallback;

  CustomCachedImage({required this.url, this.fit, this.borderRadius, this.errorFallback});

  @override
  State<CustomCachedImage> createState() => _CustomCachedImageState();
}

class _CustomCachedImageState extends State<CustomCachedImage> {
  late ImagesBloc imagesBloc;

  @override 
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    imagesBloc = ImagesBloc(pageRepository: pageRepo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc, ImagesState>(
      bloc: imagesBloc..add(ImagesLoadEvent(url: widget.url)),
      builder: (context, state) {
        if (state is ImagesReadyState) { 
          return CachedNetworkImage(
            imageUrl: widget.url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),                
                  image: DecorationImage(
                  image: imageProvider,
                  fit: widget.fit ?? BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => widget.errorFallback ?? Icon(Icons.error),
          );
        }

        if (state is ImagesLoadFailState) {
          return Icon(Icons.error);
        }

        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
