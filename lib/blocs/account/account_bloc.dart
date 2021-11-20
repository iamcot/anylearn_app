import 'package:anylearn/dto/friends_dto.dart';
import 'package:bloc/bloc.dart';

import '../../models/user_repo.dart';
import 'account_blocs.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  AccountBloc({this.userRepository}) : super(null);

  @override
  AccountState get initialState => AccountInitState();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    try {
      if (event is AccInitPageEvent) {
        yield AccInitPageSuccess(user: event.user);
      } else if (event is AccChangeAvatarEvent) {
        yield UploadAvatarInprogressState();

        String url = await userRepository.uploadAvatar(event.file, event.token);
        if (url != null && url.isNotEmpty) {
          yield UploadAvatarSuccessState(url: url);
        } else {
          yield AccountFailState(error: "Up ảnh không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại");
        }
      } else if (event is AccChangeBannerEvent) {
        yield UploadBannerInprogressState();
        String url = await userRepository.uploadBanner(event.file, event.token);
        if (url != null && url.isNotEmpty) {
          yield UploadBannerSuccessState(url: url);
        } else {
          yield AccountFailState(error: "Up banner không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại");
        }
      } else if (event is AccEditSubmitEvent) {
        yield AccEditSavingState();
        bool result = await userRepository.editUser(event.user, event.token);
        if (!result) {
          yield AccountFailState(error: "Cập nhật thông tin thất bại, vui lòng thử lại");
        } else {
          yield AccEditSaveSuccessState(result: result);
        }
      } else if (event is AccLoadFriendsEvent) {
        yield AccFriendsLoadingState();
        FriendsDTO friendsDTO = await userRepository.friends(event.userId, event.token);
        yield AccFriendsLoadSuccessState(friends: friendsDTO);
      } else if (event is AccLoadMyCalendarEvent) {
        yield AccMyCalendarLoadingState();
        final calendar = await userRepository.myCalendar(event.token);
        yield AccMyCalendarSuccessState(calendar: calendar);
      } else if (event is AccJoinCourseEvent) {
        await userRepository.joinCourse(event.token, event.scheduleId, event.childId);
        yield AccJoinSuccessState(itemId: event.itemId);
        this..add(AccLoadMyCalendarEvent(token: event.token));
      } else if (event is AccProfileEvent) {
        yield AccProfileLoadingState();
        final user = await userRepository.getProfile(event.userId);
        yield AccProfileSuccessState(user: user);
      } else if (event is AccLoadDocsEvent) {
        final userDocs = await userRepository.getDocs(event.token);
        yield AccLoadDocsSuccessState(userDocs: userDocs);
      } else if (event is AccAddDocEvent) {
        yield AccAddDocLoadingState();
        final userDocs = await userRepository.addDoc(event.token, event.file);
        yield AccAddDocSuccessState(userDocs: userDocs);
      } else if (event is AccRemoveDocEvent) {
        final userDocs = await userRepository.removeDoc(event.token, event.fileId);
        yield AccRemoveDocSuccessState(userDocs: userDocs);
      }
    } catch (error) {
      yield AccountFailState(error: error.toString());
    }

    try {
      if (event is AccSaveChildrenEvent) {
        yield AccSaveChildrenLoadingState();
        await userRepository.saveChildren(event.token, event.id, event.name);
        yield AccSaveChildrenSuccessState();
      } else if (event is AccLoadChildrenEvent) {
        yield AccChildrenLoadingState();
        final children = await userRepository.getChildren(event.token);
        yield AccChildrenSuccessState(children: children);
      }
    } catch (error) {
      yield AccChildrenFailState(error: error.toString());
    }

    try {
      if (event is AccChangePassEvent) {
        yield AccChangePassInProgressState();
        final result = await userRepository.changePass(event.token, event.newPass, event.oldPass);
        yield AccChangePassSuccessState();
      }
    } catch (error) {
      yield AccChangePassFailState(error: error.toString());
    }
  }
}
