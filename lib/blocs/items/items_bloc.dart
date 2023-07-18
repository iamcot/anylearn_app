library itemsbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:anylearn/dto/home_dto.dart';

import '../../dto/items_dto.dart';
import '../../dto/v3/home_dto.dart';
import '../../models/page_repo.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final PageRepository pageRepository;
  ItemsBloc({required this.pageRepository}) : super(ItemsInitState()) {
    on<ItemsSchoolLoadEvent>(_onItemsSchoolLoadEvent);
    on<ItemsTeacherLoadEvent>(_onItemsTeacherLoadEvent);
    on<CategoryLoadEvent>(_onCategoryLoadEvent);
  }

  void _onItemsSchoolLoadEvent(ItemsSchoolLoadEvent event, Emitter<ItemsState> emit) async {
    try {
      emit(ItemsLoadingState());
      var data = await pageRepository.dataSchoolPage(event.id, event.page, event.pageSize);
      if (data != null) {
        emit(ItemsSchoolSuccessState(data: data));
      }
    } catch (error, trace) {
      emit(ItemsLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error"));
      print(trace);
    }
  }

  void _onItemsTeacherLoadEvent(ItemsTeacherLoadEvent event, Emitter<ItemsState> emit) async {
    try {
      emit(ItemsLoadingState());
      var data = await pageRepository.dataTeacherPage(event.id, event.page, event.pageSize);
      if (data != null) {
        emit(ItemsTeacherSuccessState(data: data));
      }
    } catch (error, trace) {
      emit(ItemsLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error"));
      print(trace);
    }
  }

  void _onCategoryLoadEvent(CategoryLoadEvent event, Emitter<ItemsState> emit) async {
    try {
      emit(CategoryLoadingState());
      final List<CategoryPagingDTO> cats = await pageRepository.category(event.id, event.page, event.pageSize);
    } catch (error, trace) {
      emit(CategoryFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error"));
      print(trace);
    }
  }

 /* @override
  ItemsState get initialState => ItemsInitState();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    try {
      var data;
      if (event is ItemsSchoolLoadEvent) {
        yield ItemsLoadingState();
        data = await pageRepository.dataSchoolPage(event.id, event.page, event.pageSize);
        if (data != null) {
          yield ItemsSchoolSuccessState(data: data);
        }
      } else if (event is ItemsTeacherLoadEvent) {
        yield ItemsLoadingState();
        data = await pageRepository.dataTeacherPage(event.id, event.page, event.pageSize);
        if (data != null) {
          yield ItemsTeacherSuccessState(data: data);
        }
      }
      // if (data == null) {
      //   yield ItemsLoadFailState(error: "Không có thông tin bạn đang tìm kiếm.");
      // }
    } catch (error, trace) {
      yield ItemsLoadFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(trace);
    }
    try {
      if (event is CategoryLoadEvent) {
        yield CategoryLoadingState();
        final List<CategoryPagingDTO> cats = await pageRepository.category(event.id, event.page, event.pageSize);
      }
    } catch (error, trace) {
      yield CategoryFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
      print(error);
    }
  }*/
}
