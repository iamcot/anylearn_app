library subtypebloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/v3/subtype_dto.dart';
import '../../models/page_repo.dart';

part 'subtype_event.dart';
part 'subtype_state.dart';

class SubtypeBloc extends Bloc<SubtypeEvent, SubtypeState> {
  final PageRepository pageRepository;
  SubtypeBloc({required pageRepository})
      : pageRepository = pageRepository,
        super(SubtypeInitState()) {
    on<LoadSubtypePageEvent>(_loadSubtypeEvent);
  }

  void _loadSubtypeEvent(LoadSubtypePageEvent event, Emitter<SubtypeState> emit) async {
    final data = await pageRepository.dataSubtype();
    return emit(SubtypeSuccessState(data: data));
  }
}
