import 'package:flutter/material.dart';

class GotoProfileBar extends StatelessWidget {
  final int userId;

  const GotoProfileBar({required this.userId});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: (Colors.grey[200])!))
          ),
          child: ListTile(
            title: Text("Thông tin giới thiệu", style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue
            ),),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed("/profile", arguments: userId);
            },
          ),
        
          ),
    );
  }
}
