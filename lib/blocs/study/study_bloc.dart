library studybloc;

import 'package:anylearn/dto/v3/registered_courses_dto.dart';
import 'package:anylearn/dto/v3/schedule_dto.dart';
import 'package:anylearn/dto/v3/study_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'study_event.dart';
part 'study_state.dart';

class StudyBloc extends Bloc<StudyEvent, StudyState> {
  final PageRepository pageRepository;

  StudyBloc({required this.pageRepository}) : super(StudyInitState()) {
    on<StudyLoadMainDataEvent>(_loadStudy);
    on<StudyLoadCourseDataEvent>(_loadCourse);
    on<StudyLoadScheduleDataEvent>(_loadSchedule);
  }

  Future<void> _loadStudy(StudyLoadMainDataEvent event, Emitter emit) async {
    try {
      print('loading Study Feature with id: ${event.studentID}');
      final data = await pageRepository.dataStudy(event.token, event.studentID);
      return emit(StudyLoadSuccessState(data: data));
    } catch (ex) {
      print('Study Screen:' + ex.toString());
    }
    emit(StudyLoadFailState());
  }

  Future<void> _loadSchedule(StudyLoadScheduleDataEvent event, Emitter emit) async {
    try {
      final data = await pageRepository.dataSchedule(event.token, event.dateOn);
      return emit(StudyLoadScheduleSuccessState(data: data));
    } catch (ex) {
      print('Schedule Screen:' + ex.toString());
    }
    emit(StudyLoadFailState());
  }

  Future<void> _loadCourse(StudyLoadCourseDataEvent event, Emitter emit ) async {
    try {
      final data = await pageRepository.dataRegisteredCourse(event.token, event.orderItemID);
      return emit(StudyLoadCourseSuccessState(data: data));
    } catch (ex) {
      print('Course Screen:' + ex.toString());
    }
    emit(StudyLoadFailState());
  }
}
