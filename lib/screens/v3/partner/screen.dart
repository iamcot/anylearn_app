import 'package:anylearn/blocs/partner/partner_bloc.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/partner_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/partner/body.dart';
import 'package:anylearn/widgets/appbar.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({Key? key}) : super(key: key);

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  late PartnerBloc partnerBloc;
  late int partnerId;
  PartnerDTO? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    partnerBloc = PartnerBloc(pageRepository: pageRepo);

    try {
      partnerId = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    } catch (error) {
      partnerId = 0;
      print('PartnerScreen $error');
    }
    // checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: partnerBloc..add(PartnerLoadEvent(partnerId: partnerId)),
      builder: (context, state) {
        if (state is PartnerLoadSuccessState) {
          data = state.data;
        }
        return data == null 
          ? LoadingScreen()
          : Scaffold(
            appBar: BaseAppBar (
              title: "",
              user: UserDTO(),
              screen: "",
            ),
            body: PartnerBody(data: data),
            bottomNavigationBar: BottomNav(BottomNav.HOME_INDEX),
          );
      }
    );
  }
}