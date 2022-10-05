class PendingOrderDTO {
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

  factory PendingOrderDTO.fromJson(dynamic json) => PendingOrderDTO(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        quantity: json["quantity"] ?? 0,
        amount: json["amount"] ?? 0,
        status: json["status"] ?? "",
        deliveryName: json["delivery_name"] ?? "",
        deliveryAddress: json["delivery_address"] ?? "",
        deliveryPhone: json["delivery_phone"] ?? "",
        payment: json["payment"] ?? "",
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        saleId: json["sale_id"] ?? 0,
        classes: json["classes"] ?? "",
      );
}
