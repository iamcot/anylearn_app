library imagesbloc;

import 'package:bloc/bloc.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:equatable/equatable.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final PageRepository pageRepository;
  ImagesBloc({required this.pageRepository}) : super(ImagesInitState()) {
    on<ImagesLoadEvent>(_onImagesLoadEvent);
  }

  Future<void> _onImagesLoadEvent(ImagesLoadEvent event, Emitter<ImagesState> emit) async {
    try {
      final readyImage = await pageRepository.imageValidation(event.url);
      if (readyImage) {
        return emit(ImagesReadyState());
      }
      return emit(ImagesLoadFailState());
    } catch (error) { 
      print(error);
      print('ImageValidation Exception: ${event.url}');
    }
  }
} 