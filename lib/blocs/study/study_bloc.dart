library studybloc;

import 'package:anylearn/dto/v3/study_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'study_event.dart';
part 'study_state.dart';

class StudyBloc extends Bloc<StudyEvent, StudyState> {
  final PageRepository pageRepository;

  StudyBloc({required this.pageRepository}) : super(StudyInitState()) {
    on<StudyLoadDataEvent>(_loadStudy);
  }

  Future<void> _loadStudy(StudyLoadDataEvent event, Emitter emit) async {
    try {
      print('loading Study Feature with id: ${event.studentID}');
      final study = await pageRepository.dataStudy(event.token, event.studentID);
      return emit(StudyLoadSuccessState(data: study));
    } catch (ex) {
      print('Study Screen:' + ex.toString());
    }
  }

  // Future<void> _loadCourse(StudyLoadDataEvent event, Emitter emit ) async {
  //   try {
  //     final course = await pageRepository.dataRegisteredCourse(event.token, event.orderID);
  //     return emit(StudyLoadSuccessState(data: course));
  //   } catch (ex) {
  //     print('Course Screen:' + ex.toString());
  //   }
  // }
}
