import '../dto/item_dto.dart';
import '../dto/items_dto.dart';
import '../dto/pdp_dto.dart';
import '../dto/user_dto.dart';

class ItemService {
  Future<ItemsDTO> itemsListOfUser(int userId, int page, int pageSize) async {
    return ItemsDTO(
      user: new UserDTO(
        name: "User Name",
        role: "school",
        banner:
            "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
      ),
      items: <ItemDTO>[
        new ItemDTO(
          id: 1,
          title: "Khóa học nổi bật A",
          date: "2020-05-02",
          rating: 0,
          price: 1256000,
          priceOrg: 2000000,
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          shortContent:
              "Thông tin ngắn gọn về khóa học được viết ở dòng để line tự động xuống dòng. dài thêm chút nữa để cắt ba chấm.",
        ),
        new ItemDTO(
          id: 2,
          title: "Khóa học nổi bật B có tên siêu dài.",
          date: "2020-05-17",
          rating: 5,
          price: 100000,
          priceOrg: 0,
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          shortContent: "Thông tin ngắn gọn về khóa học",
        ),
        new ItemDTO(
          id: 3,
          title: "Khóa học nổi bật C",
          date: "2020-05-30",
          rating: 2.5,
          price: 100000,
          priceOrg: 0,
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          shortContent: "Thông tin ngắn gọn về khóa học abc",
        ),
        new ItemDTO(
          id: 4,
          title: "Khóa học nổi bật D",
          date: "2020-05-30",
          rating: 4,
          price: 100000,
          priceOrg: 200000,
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          shortContent: "Thông tin ngắn gọn về khóa học abc",
        )
      ],
    );
  }

  Future<PdpDTO> getPDPData(int itemId) async {
    return new PdpDTO(
      hotItems: [
      ],
      author: new UserDTO(
        id: 1,
        name: "Thầy giáo Ba",
        role: "teacher",
        route: "/teacher",
      ),
      item: new ItemDTO(
        id: 1,
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
  }
}
