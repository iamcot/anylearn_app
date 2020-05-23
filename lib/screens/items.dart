import '../dto/item_dto.dart';
import '../dto/items_dto.dart';
import '../dto/user_dto.dart';
import 'items/items_body.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemsScreen();
}

class _ItemsScreen extends State<ItemsScreen> {
  ItemsDTO data = new ItemsDTO(
    user: new UserDTO(
      name: "User Name",
      role: "school",
      banner:
          "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
    ),
    items: <ItemDTO>[
      new ItemDTO(
        title: "Khóa học nổi bật A",
        date: "2020-05-02",
        rating: 0,
        price: 1256000,
        priceOrg: 2000000,
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/pdp",
        shortContent:
            "Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.",
      ),
      new ItemDTO(
        title: "Khóa học nổi bật B có tên siêu dài.",
        date: "2020-05-17",
        rating: 5,
        price: 100000,
        priceOrg: 0,
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/pdp",
        shortContent: "Thông tin ngắn gọn về khóa học",
      ),
      new ItemDTO(
        title: "Khóa học nổi bật C",
        date: "2020-05-30",
        rating: 2.5,
        price: 100000,
        priceOrg: 0,
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/pdp",
        shortContent: "Thông tin ngắn gọn về khóa học abc",
      ),
      new ItemDTO(
        title: "Khóa học nổi bật D",
        date: "2020-05-30",
        rating: 4,
        price: 100000,
        priceOrg: 200000,
        image:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
        route: "/pdp",
        shortContent: "Thông tin ngắn gọn về khóa học abc",
      )
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: data.user.name,
      ),
      body: ItemsBody(
        data: data,
      ),
      bottomNavigationBar: BottomNav(
        index: data.user.role == "teacher" ? BottomNav.TEACHER_INDEX : BottomNav.SCHOOL_INDEX,
      ),
    );
  }
}
