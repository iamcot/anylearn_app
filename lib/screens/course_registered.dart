import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/dto/class_registered_user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/course/course_blocs.dart';
import '../dto/course_registered_params_dto.dart';
import '../widgets/loading_widget.dart';

class CourseRegisteredScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseRegisteredScreen();
}

class _CourseRegisteredScreen extends State<CourseRegisteredScreen> {
  late CourseBloc _courseBloc;
  List<ClassRegisteredUserDTO>? users;

  @override
  void didChangeDependencies() {
    final CourseRegisteredPramsDTO params = ModalRoute.of(context)!.settings.arguments as CourseRegisteredPramsDTO;
    if (params.itemId <= 0) {
      Navigator.of(context).pop();
    }
    _courseBloc = BlocProvider.of<CourseBloc>(context)
      ..add(RegisteredUsersEvent(token: params.token, itemId: params.itemId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Thành viên đăng ký khóa học"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: BlocListener<CourseBloc, CourseState>(
          bloc: _courseBloc,
          listener: (context, state) {},
          child: BlocBuilder<CourseBloc, CourseState>(
              bloc: _courseBloc,
              builder: (context, state) {
                if (state is RegisteredUsersSuccessState) {
                  users = state.users;
                }
                return users == null
                    ? LoadingWidget()
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: users![index].image == ""
                                ? Icon(Icons.account_circle)
                                : Container(width: 50, child: CustomCachedImage(url: users![index].image)),
                            title: Text(users![index].name +
                                (users![index].name != users![index].child ? " [" + users![index].child + "]" : "")),
                          //  subtitle: Text(users[index].phone),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: users!.length);
              }),
        ),
      ),
    );
  }
}
