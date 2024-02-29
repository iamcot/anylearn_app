import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:anylearn/screens/v3/study/item_constants.dart';
import 'package:anylearn/widgets/bold_text.dart';
import 'package:anylearn/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActivationBox extends StatelessWidget {
  final RegisteredItemDTO data;
  final Color? iconColor;
  final Color? keyColor;

  const ActivationBox({
    Key? key, 
    required this.data,
    this.iconColor,
    this.keyColor,
  }) : super(key: key);

  @override
    Widget build(BuildContext context) {
    final Map<dynamic, dynamic> activation = data.activationInfo;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText('Thông tin kích hoạt'),
          const SizedBox(height: 15.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: iconColor, size: 20),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Điều này đảm bảo rằng bạn có quyền sử dụng một cách an toàn và bảo vệ thông tin cá nhân của bạn. Vui lòng không chia sẻ thông tin này!',
                  maxLines: 6,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 10.0),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Icon(Icons.link, color: iconColor, size: 20),
          //     const SizedBox(width: 10.0),
          //     Expanded(
          //       child: Text(''),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: keyColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: [
                if (activation.containsKey('account')) 
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 75, child: BoldText('Tài khoản:')),
                          Text(activation['account']!),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                if (activation.containsKey('password')) 
                  Row(
                    children: [
                      SizedBox(width: 75, child: BoldText('Mật khẩu:')),
                      Expanded(child: Text(activation['password']!)),
                    ],
                  ),
                if (activation.isEmpty || activation.containsKey('code')) 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(width: 100, child: BoldText('Mã kích hoạt:')),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: activation['code']!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Copied'),
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                )
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(activation.isNotEmpty ? activation['code']! : ItemConstants.DEFAULT_STATUS , maxLines: 2),
                                Text('(Chạm để copy)', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ],
                  )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/guide', arguments: 'guide_toc');
                },
                child: Text(
                  'Hướng dẫn sử dụng',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}