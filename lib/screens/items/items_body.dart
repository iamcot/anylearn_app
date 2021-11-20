import 'package:anylearn/widgets/user_quick_profile.dart';
import 'package:flutter/material.dart';

import '../../dto/items_dto.dart';
import '../../widgets/item_card.dart';
import '../../widgets/sliver_banner.dart';
import '../teacher/teacher_filter.dart';

class ItemsBody extends StatefulWidget {
  final ItemsDTO itemsDTO;

  const ItemsBody({Key key, this.itemsDTO}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemsBody();
}

class _ItemsBody extends State<ItemsBody> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return Container(
      color: Colors.grey[150],
      child: CustomScrollView(
        slivers: <Widget>[
          UserQuickProfile(user: widget.itemsDTO.user,),
          TeacherFilter(),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 0.65,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(5),
                   
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/pdp",
                            arguments: widget.itemsDTO.items.data[index].id); //data.items[index].id.toString()
                      },
                      child: ItemCard(
                        item: widget.itemsDTO.items.data[index],
                        width: width - 30,
                      ),
                    ));
              },
              childCount: widget.itemsDTO.items.data.length,
            ),
          ),
        ],
      ),
    );
  }
}
