part of imagesbloc;

abstract class ImagesState extends Equatable {
  const ImagesState();
  
  @override
  List<Object> get props => [];
}

class ImagesInitState extends ImagesState {}

class ImagesReadyState extends ImagesState {}

class ImagesLoadFailState extends ImagesState {}