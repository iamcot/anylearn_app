import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../customs/feedback.dart';
import '../main.dart';
import '../widgets/loading_widget.dart';
import 'account/account_body.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  late AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popAndPushNamed("/login");
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          if (state is AuthSuccessState) {
            user = state.user;
          } 
          return Scaffold(
            body: AccountBody(
                      authBloc: _authBloc,
                    )
            // user.token != ""
            //     ? CustomFeedback(
            //         user: user,
            //         child: AccountBody(
            //           authBloc: _authBloc,
            //         ),
            //       )
            //     : LoadingWidget(),
          );
        },
      ),
    );
  }
}
