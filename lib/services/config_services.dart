import 'package:anylearn/dto/deposit_config_dto.dart';

import '../dto/home_dto.dart';
import '../dto/hot_items_dto.dart';
import '../dto/item_dto.dart';

class ConfigServices {
  Future<HomeDTO> homeLayout(String role) async {
    return HomeDTO(
      banners: [
        "assets/banners/banner-1.jpg",
        "assets/banners/banner-2.jpg",
        "assets/banners/banner-3.jpg",
      ],
      hotItems: [
        new HotItemsDTO(title: "Trung tâm nổi bật", route: "/school", list: [
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
        new HotItemsDTO(title: "Chuyên gia nổi bật", route: "/teacher", list: [
          new ItemDTO(
              title: "Giảng viên A có tên siêu dài cần phải cắt đi",
              image:
                  "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
              route: "/teacher"),
          new ItemDTO(
              title: "Chuyên gia B",
              image:
                  "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
              route: "/teacher"),
          new ItemDTO(
              title: "Thầy giáo C",
              image:
                  "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
              route: "/teacher"),
        ]),
      ],
      monthCourses: [
        new ItemDTO(
          title: "Khóa học nổi bật A",
          date: "2020-05-02",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher",
          shortContent:
              "Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.",
        ),
        new ItemDTO(
          title: "Khóa học nổi bật B có tên siêu dài.",
          date: "2020-05-17",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher",
          shortContent: "Thông tin ngắn gọn về khóa học",
        ),
        new ItemDTO(
          title: "Khóa học nổi bật C",
          date: "2020-05-30",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/teacher",
          shortContent: "Thông tin ngắn gọn về khóa học abc",
        )
      ],
    );
  }

  Future<DepositeConfigDTO> depositeConfigs() async {
    return DepositeConfigDTO(
      walletM: 1000,
      walletC: 99,
      vipFee: 930000,
      vipDays: 30,
      suggests: [930000, 5000000, 2000000, 1000000, 500000, 200000],
      payments: [],
      lastTransactions: [],
    );
  }
}
