import 'package:anylearn/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../blocs/pdp/pdp_blocs.dart';
import '../../dto/user_dto.dart';
import '../../widgets/loading_widget.dart';

class CourseShareScreen extends StatefulWidget {
  final pdpId;
  final pdpBloc;

  const CourseShareScreen({key, this.pdpBloc, this.pdpId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CourseShareScreen();
}

class _CourseShareScreen extends State<CourseShareScreen> {
  List<UserDTO>? _friends;
  Map<int, bool> selected = {};
  bool checkAll = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Scaffold(
        appBar: AppBar(
          title: Text("Chia sẻ khóa học"),
          centerTitle: false,
          bottom: PreferredSize(
            child: TextButton(
                onPressed: () {
                  widget.pdpBloc
                    ..add(PdpFriendShareEvent(
                        token: user.token,
                        itemId: widget.pdpId,
                        isALL: true,
                        friendIds: []));
                },
                child: Text(
                  "GỬI TẤT CẢ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            preferredSize: Size.fromHeight(40),
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              icon: Icon(Icons.send),
              onPressed: () {
                List<int> ids = [];
                selected.forEach((key, value) {
                  if (value) {
                    ids.add(key);
                  }
                });
                widget.pdpBloc
                  ..add(PdpFriendShareEvent(
                      token: user.token,
                      itemId: widget.pdpId,
                      friendIds: ids,
                      isALL: false));
              },
              label: Text("GỬI"),
            )
          ],
        ),
        body: BlocListener<PdpBloc, PdpState>(
          bloc: widget.pdpBloc,
          listener: (BuildContext context, PdpState state) {
            if (state is PdpShareSuccessState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Đã gửi lời mời tới các bạn."),
                )).closed.then((value) {
                  Navigator.of(context).pop();
                });
            }
            if (state is PdpShareFailState) {
              // toast(state.error, duration: Duration(seconds: 3));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.error),
                ));
            }
          },
          child: BlocBuilder<PdpBloc, PdpState>(
            bloc: widget.pdpBloc..add(PdpFriendLoadEvent(token: user.token)),
            builder: (context, state) {
              if (state is PdpShareFriendListSuccessState) {
                _friends = state.friends;
                for (var i = 0; i < _friends!.length; i++) {
                  selected[_friends![i].id] = false;
                }
              }

              return _friends == null
                  ? LoadingWidget()
                  : Container(
                      child: StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return ListView.separated(
                            itemBuilder: (context, index) => CheckboxListTile(
                              title: Text(_friends![index].name),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: selected[_friends![index].id],
                              secondary: Container(
                                width: 50,
                                height: 50,
                                child: _friends![index].image == ""
                                    ? Icon(
                                        Icons.account_circle,
                                        size: 32,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: _friends![index].image),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selected[_friends![index].id] = value!;
                                });
                              },
                            ),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: _friends!.length,
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
