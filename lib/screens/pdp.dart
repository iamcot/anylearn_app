import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pdp/pdp_blocs.dart';
import '../models/page_repo.dart';
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
  @override
  void didChangeDependencies() {
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    pdpBloc = PdpBloc(pageRepository: pageRepo);
    final itemId = ModalRoute.of(context).settings.arguments;
    pdpBloc.add(LoadPDPEvent(id: itemId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PdpBloc>(
      create: (context) {
        return pdpBloc;
      },
      child: BlocListener<PdpBloc, PdpState>(
        listener: (context, state) {
          if (state is PdpFailState) {
            Navigator.of(context).popUntil(ModalRoute.withName("/"));
          }
        },
        child: BlocBuilder<PdpBloc, PdpState>(
          builder: (context, state) {
            var data;

            if (state is PdpSuccessState) {
              data = state.data;
            }
            if (state is PdpFavoriteAddState) {
              data = state.data;
            }
            if (state is PdpFavoriteRemoveState) {
              data = state.data;
            }
            return data != null
                ? Scaffold(
                    appBar: BaseAppBar(
                      title: "",
                    ),
                    body: PdpBody(
                      data: data,
                    ),
                    bottomNavigationBar: BottomNav(
                      index: data.user.role == "teacher" ? BottomNav.TEACHER_INDEX : BottomNav.SCHOOL_INDEX,
                    ))
                : LoadingScreen();
          },
        ),
      ),
    );
  }
}
