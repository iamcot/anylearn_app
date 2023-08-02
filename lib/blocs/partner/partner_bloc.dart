library partnerbloc;
import 'package:anylearn/dto/v3/partner_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'partner_state.dart';
part 'partner_event.dart';


class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  final PageRepository pageRepository;

  PartnerBloc({required this.pageRepository}) : super(PartnerInitState()) {
    on<PartnerLoadEvent>(_onPartnerLoadEvent);
  }

  Future<void> _onPartnerLoadEvent(PartnerLoadEvent event, Emitter<PartnerState> emit) async {  
    try {
      emit(PartnerLoadingState());
      final data = await pageRepository.dataPartner(event.partnerId);
      return emit(PartnerLoadSuccessState(data: data));
    } catch (error, trace) {
      print(error);
      print(trace);
    }
    return emit(PartnerLoadFailState());
  }
} 