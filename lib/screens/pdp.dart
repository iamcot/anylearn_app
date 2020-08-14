import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_blocs.dart';
import '../blocs/pdp/pdp_blocs.dart';
import '../customs/feedback.dart';
import '../dto/pdp_dto.dart';
import '../dto/user_dto.dart';
import '../models/page_repo.dart';
import '../models/transaction_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'loading.dart';
import 'pdp/pdp_body.dart';

class PDPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PDPScreen();
}

class _PDPScreen extends State<PDPScreen> {
  PdpBloc pdpBloc;
  UserDTO user;
  PdpDTO data;
  int itemId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    pdpBloc = PdpBloc(pageRepository: pageRepo, transactionRepository: transRepo);
    try {
      itemId = int.parse(ModalRoute.of(context).settings.arguments);
    } catch (e) {
      itemId = ModalRoute.of(context).settings.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent()),
      builder: (BuildContext context, AuthState state) {
        if (state is AuthSuccessState) {
          user = state.user;
        }
        return BlocProvider<PdpBloc>(
          create: (context) {
            return pdpBloc..add(LoadPDPEvent(id: itemId, token: user == null ? "" : user.token));
          },
          child: Scaffold(
            appBar: BaseAppBar(
              title: "",
              user: user,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                pdpBloc..add(LoadPDPEvent(id: itemId, token: user == null ? "" : user.token));
              },
              child: BlocListener<PdpBloc, PdpState>(
                listener: (context, state) {
                  if (state is PdpFailState) {
                    Navigator.of(context).popUntil(ModalRoute.withName("/"));
                  }
                  if (state is PdpRegisterFailState) {
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text(state.error),
                    ));
                  }
                  if (state is PdpRegisterSuccessState) {
                    BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text(
                          "Bạn đã đăng ký thành công khóa học. Chúng tôi sẽ gửi thông báo về buổi học trong thời gian sớm nhất."),
                    ));
                  }
                },
                child: BlocBuilder<PdpBloc, PdpState>(
                  builder: (context, state) {
                    if (state is PdpSuccessState) {
                      data = state.data;
                    }
                    if (state is PdpFavoriteTouchSuccessState) {
                      data.isFavorite = state.isFav;
                    }
                    return data != null
                        ? CustomFeedback(
                            user: user,
                            child: PdpBody(
                              pdpBloc: pdpBloc,
                              data: data,
                              user: user,
                            ),
                          )
                        : LoadingScreen();
                  },
                ),
              ),
            ),
            bottomNavigationBar: BlocBuilder(
              bloc: pdpBloc,
              builder: (context, state) {
                return BottomNav(
                    index: data != null && data.author.role == "teacher"
                        ? BottomNav.TEACHER_INDEX
                        : BottomNav.SCHOOL_INDEX);
              },
            ),
          ),
        );
      },
    );
  }
}
