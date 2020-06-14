import 'package:anylearn/screens/account/user_doc_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/account/account_blocs.dart';
import '../dto/const.dart';
import '../dto/user_dto.dart';
import '../models/user_repo.dart';
import '../widgets/loading_widget.dart';

class AccountProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountProfileScreen();
}

class _AccountProfileScreen extends State<AccountProfileScreen> {
  AccountBloc _accountBloc;
  UserDTO user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _userRepo = RepositoryProvider.of<UserRepository>(context);
    int userId = ModalRoute.of(context).settings.arguments;
    _accountBloc = AccountBloc(userRepository: _userRepo)..add(AccProfileEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider<AccountBloc>(create: (context) {
          return _accountBloc;
        }, child: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
          if (state is AccProfileSuccessState) {
            user = state.user;
            return ListView(children: [
              Stack(
                children: [
                  _bannerBox(width / 2),
                  _imageBox(width / 3),
                ],
              ),
              Text(
                user.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              user.role != MyConst.ROLE_SCHOOL
                  ? Text(
                      user.title ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    )
                  : SizedBox(height: 0),
              Text(
                user.introduce ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              ),
              user.role == MyConst.ROLE_SCHOOL
                  ? ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15),
                      leading: Icon(MdiIcons.shieldAccount),
                      title: Text(user.title),
                      isThreeLine: false,
                    )
                  : SizedBox(height: 0),
              user.address != null
                  ? ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15),
                      leading: Icon(MdiIcons.mapMarker),
                      title: Text(user.address),
                      isThreeLine: false,
                    )
                  : SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text("Chứng chỉ", style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: user.docs == null ? Text("Thành viên này chưa có chứng chỉ nào.") : UserDocList(userDocs: user.docs),
              ),
              Divider(
                thickness: 10,
              ),
              user.fullContent == null
                  ? SizedBox(height: 0)
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: Html(data: user.fullContent),
                    ),
            ]);
          }
          return LoadingWidget();
        })));
  }

  Widget _imageBox(double size) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: size, left: size, right: size),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: size / 2,
            child: (user.image != null && user.image != "")
                ? CircleAvatar(
                    radius: size / 2 - 2.0,
                    backgroundImage: NetworkImage(
                      user.image,
                    ),
                  )
                : Icon(
                    Icons.account_circle,
                    size: size,
                    color: Colors.grey,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _bannerBox(double size) {
    return Container(
      height: size,
      width: double.infinity,
      alignment: Alignment.bottomRight,
      decoration: user.banner != null
          ? BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(user.banner),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(color: Colors.grey[200]),
    );
  }
}
