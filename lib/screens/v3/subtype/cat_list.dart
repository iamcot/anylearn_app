import 'package:anylearn/customs/custom_search_delegate.dart';
import 'package:anylearn/screens/v3/listing/args.dart';
import 'package:flutter/material.dart';
import 'package:anylearn/dto/v3/home_dto.dart';

class SubtypeCatList extends StatelessWidget {
  final String subtype;
  final List<CategoryDTO> categories;

  const SubtypeCatList({Key? key, required this.subtype, required this.categories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 25, right: 20, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey,
              width: 0,
            )),
        child: Column(
          children: categories.asMap().entries.map((entry) {
            return InkWell(
              onTap: () {
                final args = ListingRouteArguments(subtype: subtype, category: entry.value.id.toString());
                showSearch(
                  context: context, 
                  delegate: CustomSearchDelegate(screen: '', argsFromAnotherScreen: args),
                  query: entry.value.title,
                );
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: entry.key < (categories.length - 1)
                      ? Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        )
                      : null,
                ),
                child: ListTile(
                  title: Text(entry.value.title, style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),),
                  trailing: Icon(Icons.chevron_right_outlined),
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            );
        }).toList()
      )
    );
  }
}
