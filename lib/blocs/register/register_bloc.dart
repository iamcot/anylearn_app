library registerbloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/user_dto.dart';
import '../../models/user_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({required this.userRepository}) : super(RegisterInitState()) {
    on<RegisterButtonPressedEvent>(_onRegisterButtonPressedEvent);
    on<RegisterFormLoadEvent>(_onRegisterFormLoadEvent);
  }

  void _onRegisterButtonPressedEvent(RegisterButtonPressedEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterInprogressState());
      await userRepository.register(
        event.userInput.phone, 
        event.userInput.name, 
        event.userInput.password,
        event.userInput.refcode, 
        event.userInput.role
      );
      return emit(RegisterSuccessState());
      // emit(RegisterInitState();
    } catch (e) {
      emit(RegisterFailState(error: e.toString()));
    }
  }

  void _onRegisterFormLoadEvent(RegisterFormLoadEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterLoadingTocState());
      final toc = await userRepository.toc();
      emit(RegisterTocSuccessState(toc: toc));
    } catch (e) {
      emit(RegisterFailState(error: e.toString()));
    }
  }
  /*@override
  RegisterState get initialState => RegisterInitState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    try {
      if (event is RegisterButtonPressedEvent) {
        yield RegisterInprogressState();

        await userRepository.register(event.userInput.phone, event.userInput.name, event.userInput.password,
            event.userInput.refcode, event.userInput.role);
        yield RegisterSuccessState();
        // yield RegisterInitState();

      }

      if (event is RegisterFormLoadEvent) {
        yield RegisterLoadingTocState();
        final toc = await userRepository.toc();
        yield RegisterTocSuccessState(toc: toc);
      }
    } catch (e) {
      yield RegisterFailState(error: e.toString());
    }
  }*/
}
