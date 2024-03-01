import 'package:anylearn/blocs/account/account_bloc.dart';
import 'package:anylearn/blocs/pdp/pdp_bloc.dart';
import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:anylearn/main.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/models/transaction_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/study/activation_box.dart';
import 'package:anylearn/screens/v3/study/item_constants.dart';
import 'package:anylearn/screens/v3/study/schedule_box.dart';
import 'package:anylearn/widgets/default_scaffold.dart';
import 'package:anylearn/widgets/random_color.dart';
import 'package:anylearn/widgets/title_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseScreen extends StatefulWidget {
  final int orderItemID;
  final UserDTO user;
  const CourseScreen({Key? key, required this.orderItemID, required this.user})
      : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late PdpBloc _pdpBloc;
  late StudyBloc _studyBloc;
  late AccountBloc _accountBloc;
  late RegisteredItemDTO data;

  @override
  void initState() {
    super.initState();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    final transRepo = RepositoryProvider.of<TransactionRepository>(context);

    _studyBloc = StudyBloc(pageRepository: pageRepo);
    _loadBodyData();

    _pdpBloc = PdpBloc(pageRepository: pageRepo, transactionRepository: transRepo);
    _accountBloc = BlocProvider.of<AccountBloc>(context);
  }

  @override
  void dispose() {
    _studyBloc.close();
    _pdpBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<PdpBloc, PdpState>(
            bloc: _pdpBloc,
            listener: (context, state) {
              if (state is PdpFavoriteTouchSuccessState) {
                _loadBodyData();
              }
            },
          ),
          BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is AccJoinSuccessState) {
                _loadBodyData();
              }
            },
          ),
        ],
        child: BlocBuilder<StudyBloc, StudyState>(
            bloc: _studyBloc,
            builder: (context, state) {
              if (state is StudyLoadCourseSuccessState) {
                data = state.data;
                return DefaultScaffold(
                  body: SingleChildScrollView(
                    child: _buildBodyContent(context)
                  ),
                  fontSize: 15.0,
                );
              }
              return LoadingScreen();
            },
      )
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
                stops: [0.5, 1.0], // Adjust stops for the desired fade effect
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: CachedNetworkImage(
                imageUrl: data.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 230,
                errorWidget: (context, url, error) => RandomColor(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
              child: _buildNavigationBar(context),
            ),
            Container(
              margin: const EdgeInsets.only(top: 130, right: 20, left: 20),
              child: _buildCourseInfoBox(context),
            ),
          ],
        ),
        if (ItemConstants.CONFIRMABLE_SUBTYPES.contains(data.subtype) )
          Container(
            margin: EdgeInsets.all(20),
            child: ScheduleBox(
              data: data,
              confirmationCallback: () => _updateConfirmation(),
              iconColor: Colors.blue.shade200,
              keyColor: Colors.blue.shade50,
            ),
          ),
        if (ItemConstants.UNCONFIRMABLE_SUBTYPES.contains(data.subtype))
          Container(
            margin: EdgeInsets.all(20),
            child: ActivationBox(
              data: data,
              iconColor: Colors.amber.shade200,
              keyColor: Colors.amber.shade50,
            ),
          )
      ],
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Icon(Icons.arrow_back, color: Colors.grey, size: 20.0),
          ),
        ),
        InkWell(
          onTap: () => _updateFavorite(),
          child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  1 == data.favorited
                    ? Icon(Icons.favorite_sharp, color: Colors.pink.shade400, size: 20.0)
                    : Icon(Icons.favorite_border, color: Colors.grey.shade400, size: 20.0),
                  const SizedBox(width: 5.0),
                  Text('Yêu thích', style: TextStyle(fontSize: 15.0)),
                ],
              )),
        ),
      ],
    );
  }

  Widget _buildCourseInfoBox(BuildContext context) {
    final List<Map<String, dynamic>> courseInfo = [
      {'info': data.title, 'route': '/pdp', 'args': data.id},
      {'icon': Icons.school, 'info': data.author, 'route':'/partner', 'args': data.authorID},
      {'icon': Icons.account_circle, 'info': data.student},
      {'icon': Icons.category, 'info': _getTextSubtype(data.subtype)},
      {'icon': Icons.star, 'info': 'Đánh giá & nhận xét'},
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: courseInfo.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: 0 == index
                    ? TitleText(courseInfo[index]['info'])
                    : Text(
                        courseInfo[index]['info'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: Colors.grey.shade800,
                        ),
                      ),
                  leading: null != courseInfo[index]['icon']
                    ? Icon(courseInfo[index]['icon'], color: Colors.grey.shade400, size: 20.0)
                    : courseInfo[index]['icon'],
                  contentPadding: EdgeInsets.zero,
                  trailing: Icon(Icons.chevron_right, color: Colors.grey.shade300, size: 20.0),
                  minLeadingWidth: 10.0,
                  hoverColor: Colors.blue,
                  onTap: () {
                    if (null != courseInfo[index]['route']) {
                      Navigator.of(context)
                       .pushNamed(courseInfo[index]['route'], arguments: courseInfo[index]['args']);
                    }      
                  }
                ),
                if (index < courseInfo.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      height: 0, 
                      thickness: 0.5, 
                      color: Colors.grey.shade100,
                    ),
                  ),
              ],
            );
          }),
    );
  }

  String _getTextSubtype(String subtype) {
    return subtype.isNotEmpty ? ItemConstants.STUBYPES[subtype]! :  ItemConstants.DEFAULT_STATUS;
  }

  StudyBloc _loadBodyData() {
    return _studyBloc
      ..add(StudyLoadCourseDataEvent(
        token: widget.user.token, 
        orderItemID: widget.orderItemID
      ));
  }

  void _updateFavorite() {
    _pdpBloc..add(PdpFavoriteTouchEvent(itemId: data.id, token: user.token));
  }

  void _updateConfirmation() {
    _accountBloc..add(AccJoinCourseEvent(
        token: widget.user.token,
        itemId: data.id,
        scheduleId: data.orderItemID,
        childId: data.studentID,
    ));
  }
}
