part of imagesbloc;

abstract class ImagesEvent {}

class ImagesLoadEvent extends ImagesEvent {
  final url;

  ImagesLoadEvent({required this.url});
  List<Object> get props => [url];

  
}