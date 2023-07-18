library accountbloc;

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dto/friends_dto.dart';
import '../../dto/account_calendar_dto.dart';
import '../../dto/user_doc_dto.dart';
import '../../dto/user_dto.dart';

import '../../models/user_repo.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  AccountBloc({required this.userRepository}) : super(AccountInitState()) {
    on<AccInitPageEvent>(_onAccInitPageEvent);
    on<AccChangeAvatarEvent>(_onAccChangeAvatarEvent);
    on<AccChangeBannerEvent>(_onAccChangeBannerEventt);
    on<AccEditSubmitEvent>(_onAccEditSubmitEventt);
    on<AccLoadFriendsEvent>(_onAccLoadFriendsEvent);
    on<AccLoadMyCalendarEvent>(_onAccLoadMyCalendarEvent);
    on<AccJoinCourseEvent>(_onAccJoinCourseEvent);
    on<AccProfileEvent>(_onAccProfileEvent);
    on<AccLoadDocsEvent>(_onAccLoadDocsEvent);
    on<AccAddDocEvent>(_onAccAddDocEvent);
    on<AccRemoveDocEvent>(_onAccRemoveDocEventt);
    on<AccSaveChildrenEvent>(_onAccSaveChildrenEvent);
    on<AccLoadChildrenEvent>(_onAccLoadChildrenEvent);
    on<AccChangePassEvent>(_onAccChangePassEvent);
  }

  void _onAccInitPageEvent(AccInitPageEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccInitPageSuccess(user: event.user));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }

  void _onAccChangeAvatarEvent(AccChangeAvatarEvent event, Emitter<AccountState> emit) async {
    try {
      emit(UploadAvatarInprogressState());
      String url = await userRepository.uploadAvatar(event.file, event.token);
      if (url != "") {
        emit(UploadAvatarSuccessState(url: url));
      } else {
        emit(AccountFailState(
          error: "Up ảnh không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại"
        ));
      }
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }

 void _onAccChangeBannerEventt(AccChangeBannerEvent event, Emitter<AccountState> emit) async {
    try {
      emit(UploadBannerInprogressState());
      String url = await userRepository.uploadBanner(event.file, event.token);
      if (url != "") {
        emit(UploadBannerSuccessState(url: url));
      } else {
        emit(AccountFailState(
          error: "Up banner không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại"
        ));
      }
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }

  void _onAccEditSubmitEventt(AccEditSubmitEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccEditSavingState());
      bool result = await userRepository.editUser(event.user, event.token);
      if (!result) {
        emit(AccountFailState(error: "Cập nhật thông tin thất bại, vui lòng thử lại"));
      } else {
        emit(AccEditSaveSuccessState(result: result));
      }
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }
    
  void _onAccLoadFriendsEvent(AccLoadFriendsEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccFriendsLoadingState());
      FriendsDTO friendsDTO = await userRepository.friends(event.userId, event.token);
      emit(AccFriendsLoadSuccessState(friends: friendsDTO));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }   
    
  void _onAccLoadMyCalendarEvent(AccLoadMyCalendarEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccMyCalendarLoadingState());
      final calendar = await userRepository.myCalendar(event.token);
      emit(AccMyCalendarSuccessState(calendar: calendar));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  } 

  void _onAccJoinCourseEvent(AccJoinCourseEvent event, Emitter<AccountState> emit) async {
    try {
      await userRepository.joinCourse(event.token, event.scheduleId, event.childId);
      emit(AccJoinSuccessState(itemId: event.itemId));
      this..add(AccLoadMyCalendarEvent(token: event.token));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  } 

  void _onAccProfileEvent(AccProfileEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccProfileLoadingState());
      final user = await userRepository.getProfile(event.userId);
      emit(AccProfileSuccessState(user: user));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  } 

  void _onAccLoadDocsEvent(AccLoadDocsEvent event, Emitter<AccountState> emit) async {
    try {
      final userDocs = await userRepository.getDocs(event.token);
      emit(AccLoadDocsSuccessState(userDocs: userDocs));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }

  void _onAccAddDocEvent(AccAddDocEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccAddDocLoadingState());
      final userDocs = await userRepository.addDoc(event.token, event.file);
      emit(AccAddDocSuccessState(userDocs: userDocs));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }
  
  void _onAccRemoveDocEventt(AccRemoveDocEvent event, Emitter<AccountState> emit) async {
    try {
      final userDocs = await userRepository.removeDoc(event.token, event.fileId);
      emit(AccRemoveDocSuccessState(userDocs: userDocs));
    } catch (error) {
      emit(AccountFailState(error: error.toString()));
    }
  }

  void _onAccSaveChildrenEvent(AccSaveChildrenEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccSaveChildrenLoadingState());
      final newChildId = await userRepository.saveChildren(event.token, event.id, event.name, event.dob);
      emit(AccSaveChildrenSuccessState(id: newChildId));
    } catch (error) {
      emit(AccChildrenFailState(error: error.toString()));
    }
  }

  void _onAccLoadChildrenEvent(AccLoadChildrenEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccChildrenLoadingState());
      final children = await userRepository.getChildren(event.token);
      emit(AccChildrenSuccessState(children: children));
    } catch (error) {
      emit(AccChildrenFailState(error: error.toString()));
    }
  }
  
  void _onAccChangePassEvent(AccChangePassEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccChangePassInProgressState(token: event.token, newPass: event.newPass, oldPass: event.oldPass));
      final result = await userRepository.changePass(event.token, event.newPass, event.oldPass);
      emit(AccChangePassSuccessState());
    } catch (error) {
     emit(AccChangePassFailState(error: error.toString()));
    }
  }

  /*@override
  AccountState get initialState => AccountInitState();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    try {
      if (event is AccInitPageEvent) {
        yield AccInitPageSuccess(user: event.user);
      } else if (event is AccChangeAvatarEvent) {
        yield UploadAvatarInprogressState();

        String url = await userRepository.uploadAvatar(event.file, event.token);
        if (url != "") {
          yield UploadAvatarSuccessState(url: url);
        } else {
          yield AccountFailState(error: "Up ảnh không thành công. Có thể file ảnh không phù hợp. Vui lòng thử lại");
        }
      } else if (event is AccChangeBannerEvent) {
        yield UploadBannerInprogressState();
        String url = await userRepository.uploadBanner(event.file, event.token);
        if (url != "") {
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
        final newChildId = await userRepository.saveChildren(event.token, event.id, event.name, event.dob);
        yield AccSaveChildrenSuccessState(id: newChildId);
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
        yield AccChangePassInProgressState(token: event.token, newPass: event.newPass, oldPass: event.oldPass);
        final result = await userRepository.changePass(event.token, event.newPass, event.oldPass);
        yield AccChangePassSuccessState();
      }
    } catch (error) {
      yield AccChangePassFailState(error: error.toString());
    }
  }*/
}
