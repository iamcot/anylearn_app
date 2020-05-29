import 'package:bloc/bloc.dart';

import '../../models/page_repo.dart';
import 'account_blocs.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final PageRepository pageRepository;
  AccountBloc({this.pageRepository});

  @override
  AccountState get initialState => AccountInitState();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    try {
      if (event is AccChangeAvatarEvent) {
      }
    
    } catch (error) {
      yield AccountFailState(error: "Có lỗi xảy ra, vui lòng thử lại. $error");
    }
  }
}
