

class PendingOrderDTO{
  PendingOrderDTO({
    this.id,
    this.userId,
    this.quantity,
    this.amount,
    this.status,
    this.deliveryName,
    this.deliveryAddress,
    this.deliveryPhone,
    this.payment,
    this.createdAt,
    this.updatedAt,
    this.saleId,
    this.classes,
  });

  int? id;
  int? userId;
  int? quantity;
  int? amount;
  dynamic status;
  dynamic deliveryName;
  dynamic deliveryAddress;
  dynamic deliveryPhone;
  String? payment;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic saleId;
  String? classes;

  factory PendingOrderDTO.fromJson(Map<String, dynamic> json) => PendingOrderDTO(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        amount: json["amount"] == null ? null : json["amount"],
        status: json["status"] == null ? null : json["status"],
        deliveryName: json["delivery_name"],
        deliveryAddress: json["delivery_address"],
        deliveryPhone: json["delivery_phone"],
        payment: json["payment"] == null ? null : json["payment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        saleId: json["sale_id"],
        classes: json["classes"] == null ? null : json["classes"],
      );
}
