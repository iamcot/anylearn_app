part of pdpbloc;
abstract class PdpState extends Equatable {
  const PdpState();
  @override
  List<Object> get props => [];
}

class PdpInitState extends PdpState {}

class PdpLoadingState extends PdpState {}

class PdpSuccessState extends PdpState {
  final PdpDTO data;
  PdpSuccessState({required this.data});
  @override
  List<Object> get props => [data];
}

class PdpFavoriteTouchingState extends PdpState {}

class PdpFavoriteTouchSuccessState extends PdpState {
  final bool isFav;
  PdpFavoriteTouchSuccessState({required this.isFav});
  @override
  List<Object> get props => [isFav];
}

class PdpRegisteringState extends PdpState {}

class PdpRegisterSuccessState extends PdpState {
  final bool result;
  PdpRegisterSuccessState({required this.result});
  @override
  List<Object> get props => [result];
}

class PdpRegisterFailState extends PdpState {
  final String error;
  const PdpRegisterFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class PdpSharingState extends PdpState {}

class PdpShareFailState extends PdpState {
  final String error;
  const PdpShareFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class PdpShareSuccessState extends PdpState {}

class PdpShareFriendListingState extends PdpState {}

class PdpShareFriendListSuccessState extends PdpState {
  final List<UserDTO> friends;

  PdpShareFriendListSuccessState({required this.friends});

  @override
  List<Object> get props => [friends];
}

class PdpFailState extends PdpState {
  final String error;
  const PdpFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
