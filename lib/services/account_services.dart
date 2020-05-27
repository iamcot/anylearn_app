import '../dto/account_transaction_dto.dart';
import '../dto/transaction_dto.dart';

class AccountServices {
  Future<Map<String, AccountTransactionDTO>> transactionHistory(int userId) async {
    return {
      AccountTransactionDTO.WALLET_M: AccountTransactionDTO(
        currentAmount: 99123456,
        wallet: AccountTransactionDTO.WALLET_M,
        transactions: [
          TransactionDTO(
            id: 4,
            amount: -200000,
            content: "Mua khóa học thoát Ế",
            createdDate: "2020-05-20 09:00:00",
            status: 1,
            orderId: 2123012,
          ),
          TransactionDTO(
            id: 1,
            amount: 930000,
            content: "Nạp tiền vào ví tiền, thanh toán Momo",
            createdDate: "2020-05-10 09:00:00",
            status: 1,
          ),
        ],
      ),
      AccountTransactionDTO.WALLET_C: AccountTransactionDTO(
        currentAmount: 2300,
        wallet: AccountTransactionDTO.WALLET_C,
        transactions: [
          TransactionDTO(
            id: 6,
            amount: -100,
            content: "Chuyển điểm sang ví tiền",
            createdDate: "2020-05-13 19:30:00",
            status: 0,
          ),
          TransactionDTO(
            id: 3,
            amount: 50,
            content: "Chiết khấu từ đơn hàng của Thầy Giáo Ba, Thanh toán Khóa học X",
            createdDate: "2020-05-13 19:30:00",
            status: 1,
            orderId: 3423012,
          ),
          TransactionDTO(
            id: 2,
            amount: 100,
            content: "Chiết khấu trực tiếp mua hàng, Thanh toán Khóa học A",
            createdDate: "2020-05-12 12:30:00",
            status: 1,
            orderId: 73423012,
          ),
        ],
      )
    };
  }
}
