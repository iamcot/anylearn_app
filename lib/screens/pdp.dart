import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/pdp/pdp_blocs.dart';
import '../customs/feedback.dart';
import '../dto/pdp_dto.dart';
import '../main.dart';
import '../models/page_repo.dart';
import '../models/transaction_repo.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import 'loading.dart';
import 'pdp/pdp_body.dart';

class PDPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PDPScreen();
}

class _PDPScreen extends State<PDPScreen> {
  late PdpBloc pdpBloc;
  PdpDTO? data;
  late int itemId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);
    pdpBloc = PdpBloc(pageRepository: pageRepo, transactionRepository: transRepo);
    try {
      itemId = int.parse((ModalRoute.of(context)?.settings.arguments.toString())!);
    } catch (e) {
      itemId = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PdpBloc>(
      create: (context) {
        return pdpBloc..add(LoadPDPEvent(id: itemId, token: user.token));
      },
      child: Scaffold(
        appBar: BaseAppBar(
          title: "",
          user: user,
          screen: "",
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
            pdpBloc..add(LoadPDPEvent(id: itemId, token: user.token));
          },
          child: BlocListener<PdpBloc, PdpState>(
            listener: (context, state) {
              if (state is PdpFailState) {
                Navigator.of(context).popUntil(ModalRoute.withName("/"));
              }
              if (state is PdpRegisterFailState) {
                // toast(state.error);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(state.error),
                  ));
              }
              if (state is PdpRegisterSuccessState) {
                BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text(
                            "Bạn đã đăng ký thành công khóa học. Chúng tôi sẽ gửi thông báo về buổi học trong thời gian sớm nhất.")
                        .tr(),
                  ));
              }
            },
            child: BlocBuilder<PdpBloc, PdpState>(
              builder: (context, state) {
                if (state is PdpSuccessState) {
                  data = state.data;
                }
                if (state is PdpFavoriteTouchSuccessState) {
                  data!.isFavorite = state.isFav;
                }
                return data != null
                    ? CustomFeedback(
                        user: user,
                        child: PdpBody(
                          pdpBloc: pdpBloc,
                          data: data!,
                        ),
                      )
                    : LoadingScreen();
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButtonHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        bottomNavigationBar: BlocBuilder(
            bloc: pdpBloc,
            builder: (context, state) {
              return BottomNav(BottomNav.HOME_INDEX);
            }),
      ),
    );
  }
}
