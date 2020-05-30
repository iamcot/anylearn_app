import 'package:anylearn/dto/friends_dto.dart';
import 'package:bloc/bloc.dart';

import '../../models/user_repo.dart';
import 'account_blocs.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  AccountBloc({this.userRepository});

  @override
  AccountState get initialState => AccountInitState();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    try {
      if (event is AccInitPageEvent) {
        yield AccInitPageSuccess(user: event.user);
      }
      if (event is AccChangeAvatarEvent) {
        yield UploadAvatarInprogressState();

        String url = await userRepository.uploadAvatar(event.file, event.token);
        if (url != null) {
          yield UploadAvatarSuccessState(url: url);
        } else {
          yield AccountFailState(error: "Up ảnh không thành công. Vui lòng thử lại");
        }
      }

      if (event is AccChangeBannerEvent) {
        yield UploadBannerInprogressState();
        String url = await userRepository.uploadBanner(event.file, event.token);
        if (url != null) {
          yield UploadBannerSuccessState(url: url);
        } else {
          yield AccountFailState(error: "Up banner không thành công. Vui lòng thử lại");
        }
      }

      if (event is AccEditSubmitEvent) {
        yield AccEditSavingState();
        bool result = await userRepository.editUser(event.user, event.token);
        if (!result) {
          yield AccountFailState(error: "Cập nhật thông tin thất bại, vui lòng thử lại");
        } else {
          yield AccEditSaveSuccessState(result: result);
        }
      }

      if (event is AccLoadFriendsEvent) {
        yield AccFriendsLoadingState();
        FriendsDTO friendsDTO = await userRepository.friends(event.userId, event.token);
        yield AccFriendsLoadSuccessState(friends: friendsDTO);
      }
    } catch (error) {
      yield AccountFailState(error: error.toString());
    }
  }
}
