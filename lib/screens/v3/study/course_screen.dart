import 'package:anylearn/blocs/study/study_bloc.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseScreen extends StatefulWidget {
  final int orderItemID;
  const CourseScreen({Key? key, required this.orderItemID}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late StudyBloc _studyBloc;

  @override
  void initState() {
    super.initState();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _studyBloc = StudyBloc(pageRepository: pageRepo);
  }

  @override
  void dispose() {
    _studyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTextStyle(
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 14,
          ),
          child: BlocBuilder<StudyBloc, StudyState>(
              bloc: _studyBloc..add(
                StudyLoadCourseDataEvent(token: 'token', orderItemID: widget.orderItemID)),
              builder: (context, state) {
                switch (state.runtimeType) {
                  case StudyLoadCourseSuccessState:
                    final data = (state as StudyLoadCourseSuccessState).data;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(
                                    0.3), // Set the overlay color and opacity
                                BlendMode.srcATop,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: data.courseImage,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: kToolbarHeight, left: 20, right: 20),
                              // color: Colors.amber.shade100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Icon(Icons.arrow_back,
                                          color: Colors.white)),
                                  Icon(Icons.favorite_border,
                                      color: Colors.white, size: 25)
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 120, right: 20, left: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                              color: Colors.grey.shade50))),
                                      child: Text(
                                          data.title,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          )),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade100))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.school,
                                              color: Colors.grey.shade600,
                                              size: 20),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              data.author,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade100))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.account_circle,
                                              color: Colors.grey.shade600,
                                              size: 20),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(data.student),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade100))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.category,
                                              color: Colors.grey.shade600,
                                              size: 20),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              'Học qua ứng dụng',
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.grey.shade600,
                                              size: 20),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              'Đánh giá & nhận xét',
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: _getScheduleInfoUI(),
                        ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   padding: EdgeInsets.all(20),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.grey.shade100),
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //   ),
                        //   child: _getScheduleInfoUI(),
                        // )
                      ],
                    );
                  default:
                    return LoadingScreen();
                }
              }),
        ));
  }

  Widget _getActivationInfoUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin kích hoạt',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                'Điều này đảm bảo rằng bạn có quyền sử dụng một cách an toàn và bảo vệ thông tin cá nhân của bạn. Vui lòng không chia sẻ thông tin này!',
                maxLines: 6,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.link, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                'https://anylearn.com....',
                maxLines: 6,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 80,
                      child: Text('Tài khoản:',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Text('username123', style: TextStyle()),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                      width: 80,
                      child: Text('Mật khẩu:',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Text('password123'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                // Add your button press logic here
                print('TextButton Pressed');
              },
              child: Text(
                'Hướng dẫn sử dụng',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _getScheduleInfoUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thời khóa biểu ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                'Bạn chưa tham gia khóa học này',
                maxLines: 6,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.event, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '12/12/2021 - 12/12/2122',
                maxLines: 6,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '9 Đ. Võ Thị Sáu, P. ĐaKao, Quận 1, TP.HCM',
                maxLines: 6,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 50,
                      child: Text('Thứ 4:',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Text('12:34 AM - 15:50 PM'),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                      width: 50,
                      child: Text('Thứ 6:',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Text('12:34 AM - 15:50 PM'),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                // Add your button press logic here
                print('TextButton Pressed');
              },
              child: Text(
                'Tham gia',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        )
      ],
    );
  }
}
