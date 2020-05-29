import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user_repo.dart';
import 'register_event.dart';
import 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  RegisterState get initialState => RegisterInitState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    
    if (event is RegisterButtonPressedEvent) {
      yield RegisterInprogressState();
      try {
        await userRepository.register(event.userInput.phone, event.userInput.name,
            event.userInput.password, event.userInput.refcode, event.userInput.role);
        yield RegisterSuccessState();
        // yield RegisterInitState();
      } catch (e) {
        yield RegisterFailState(error: e.toString());
      }
    }
  }
}
