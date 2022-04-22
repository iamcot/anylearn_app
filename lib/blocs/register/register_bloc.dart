import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user_repo.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({required this.userRepository}) :  super(RegisterInitState());

  @override
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
  }
}
