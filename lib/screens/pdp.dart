import 'package:anylearn/dto/hot_items_dto.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/pdp_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/screens/pdp/pdp_body.dart';
import 'package:anylearn/widgets/appbar.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class PDPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PDPScreen();
}

class _PDPScreen extends State<PDPScreen> {
  final PdpDTO data = new PdpDTO(
    hotItems: [
      new HotItemsDTO(title: "Các sản phẩm liên quan", route: "/school", list: [
        new ItemDTO(
            title: "Trung tâm A",
            image:
                "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
            route: "/school"),
        new ItemDTO(
            title: "Trung tâm B có tên siêu dài cần cắt bớt đi cho đẹp",
            image:
                "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
            route: "/school"),
        new ItemDTO(
            title: "Trung tâm C",
            image:
                "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
            route: "/school"),
      ]),
    ],
    user: new UserDTO(
      name: "Thầy giáo Ba",
      role: "teacher",
      route: "/teacher",
    ),
    item: new ItemDTO(
      title: "Khóa học nổi bật A có tên thật dài hơn hai dòng sẽ bị cắt",
      date: "2020-05-02",
      rating: 1.5,
      price: 1256000,
      priceOrg: 2000000,
      dateStart: "2020-05-31",
      timeStart: "09:00",
      timeEnd: "12:00",
      numCart: 999,
      numShare: 99,
      numFavorite: 888,
      image:
          "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
      route: "/pdp",
      shortContent:
          "Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.",
      content:
          "<p>Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.</p><p>Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.</p><p>Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.</p>",
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "",
      ),
      body: PdpBody(data: data),
      bottomNavigationBar: BottomNav(
        index: data.user.role == "teacher" ? BottomNav.TEACHER_INDEX : BottomNav.SCHOOL_INDEX,
      ),
    );
  }
}
