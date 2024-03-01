import 'package:anylearn/app_datetime.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCourse extends StatelessWidget {
  static const CONFIRMATION_TYPE = 'confirmation';
  static const COMPLETION_TYPE = 'completion';

  final RegisteredItemDTO data;
  final String type;
  final Function (RegisteredItemDTO data) callbackConfirmation;
  
  ItemCourse({ 
    Key? key, 
    required this.data,
    required this.callbackConfirmation,
    this.type = CONFIRMATION_TYPE
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: data.image, 
                    fit: BoxFit.cover, 
                    width: constraints.maxWidth,
                    height: constraints.maxWidth - 55,
                    errorWidget: (context, url, error) => Container(color: Colors.grey.shade50),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                if (CONFIRMATION_TYPE == type)
                Positioned(
                  right: 0, 
                  bottom: 0, 
                  child: _buildConfimationTag(context),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 35,
              child: Text(
                data.title,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold), 
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (CONFIRMATION_TYPE == type) 
                Wrap(
                  children: [
                    Icon(Icons.local_library, color: Colors.grey, size: 15),
                    const SizedBox(width: 3),
                    Text(
                      data.startDate == '' ? 'Đang cập nhật' : AppDateTime.convertDateFormat(data.startDate),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                if (COMPLETION_TYPE == type) 
                Wrap(
                  children: [
                    Icon(Icons.workspace_premium, color: Colors.amber, size: 15),
                    const SizedBox(width: 2),
                    Text(
                      data.endDate == '' ? 'Đang cập nhật' : AppDateTime.convertDateFormat(data.endDate),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),       
                Wrap(
                  children: [
                    Icon(Icons.grade, color: Colors.amber, size: 15),
                    if (0 < data.rating) Text(data.rating.toString(), style: TextStyle(fontSize: 12),
                    )
                  ]
                ),
              ],
            )
          ]
        );
      }
    );
  }

  Widget _buildConfimationTag(BuildContext context) {
    return InkWell(
      onTap: () => data.participantConfirm == 1 || data.organizerConfirm == 1
        ? _buildConfirmationSnackBar(context)
        : _buildConfirmationDialog(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6), // Adjust the radius as needed
            bottomRight: Radius.circular(6))),
        child: Row(
          children: [
            Icon(
              data.participantConfirm == 1 || data.organizerConfirm == 1 ? Icons.check : Icons.info_outline,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(width: 3),
            Text(
              data.participantConfirm == 1 || data.organizerConfirm == 1 ? 'Đang tham gia' : 'Chưa tham gia',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildConfirmationDialog(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) =>  AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          'Xác nhận tham gia ${data.title}?',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        actions: [
          TextButton(
            onPressed: () => callbackConfirmation(data),
            child: Text('Tham gia')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Đóng')
          ),
        ],
      ),
    );
  }

  void _buildConfirmationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
        content: Text('Bạn đã tham gia khóa học này rồi.', style: TextStyle(color: Colors.grey.shade800)),
        backgroundColor: Colors.amber.shade50,  
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      )
    );
  }
}