import 'package:anylearn/dto/v3/home_dto.dart' show CategoryDTO;
import 'package:flutter/material.dart';

class SearchCategories extends StatelessWidget {
  final List<CategoryDTO> data;
  final Function callback;

  const SearchCategories({
    Key? key, 
    required this.data,
    required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tất cả các lĩnh vực', style: Theme.of(context).textTheme.titleMedium),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index].title, style: Theme.of(context).textTheme.bodyMedium),
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              shape: Border(
                bottom: BorderSide(
                  color:index == data.length - 1 
                    ? Colors.white
                    : Colors.black12
                ),
              ),
              onTap: () => callback(context, data[index]),
            );
          }
        ),
      ]
    );
  }
}