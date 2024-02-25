library studybloc;

import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/calendar_dto.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
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
      final data = await pageRepository.dataStudy(event.account, event.token);
      return emit(StudyLoadSuccessState(data: data));
    } catch (e) {
      print('Study Screen:' + e.toString());
    }
    emit(StudyLoadFailState());
  }

  Future<void> _loadSchedule(StudyLoadScheduleDataEvent event, Emitter emit) async {
    try {
      final data = await pageRepository.dataSchedule(event.token, event.date);
      return emit(StudyLoadScheduleSuccessState(data: data));
    } catch (e) {
      print('Schedule Screen:' + e.toString());
    }
    emit(StudyLoadFailState());
  }

  Future<void> _loadCourse(StudyLoadCourseDataEvent event, Emitter emit) async {
    try {
      print(event.orderItemID);
      final data = await pageRepository.dataRegisteredCourse(event.token, event.orderItemID);
      return emit(StudyLoadCourseSuccessState(data: data));
    } catch (e) {
      print('Course Screen:' + e.toString());
    }
    emit(StudyLoadFailState());
  }
}
