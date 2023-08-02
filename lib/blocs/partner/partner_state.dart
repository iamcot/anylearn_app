part of partnerbloc;

class PartnerState extends Equatable {
  @override 
  List<Object> get props => [];
}

class PartnerInitState extends PartnerState {}

class PartnerLoadingState extends PartnerState {}

class PartnerLoadFailState extends PartnerState {}

class PartnerLoadSuccessState extends PartnerState {
  final PartnerDTO data;
  PartnerLoadSuccessState({required this.data});
}
