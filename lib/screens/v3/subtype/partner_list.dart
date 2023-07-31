import 'package:anylearn/dto/user_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PartnerList extends StatelessWidget {
  final List<UserDTO> partners;
  const PartnerList({Key? key, required this.partners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return partners.isEmpty
      ? Container()
      : Container(
        padding: EdgeInsets.only(bottom: 10, left: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Các đối tác', 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1.1)
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 100/130
                  ),
                itemCount: partners.length,
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => _itemBuilder(context, constraints, partners[index]),
                ),    
              ),
            ),
          ]
        ),
      );
  }

  Widget _itemBuilder(BuildContext context, BoxConstraints constraints, UserDTO partner) {
    return Container(
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed('/partner', arguments: {'id', partner.id }),
        child: Column(children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(imageUrl: partner.image, fit: BoxFit.fitWidth)
            ),
          ),
          Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(partner.name, 
                    style: TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis
                    )
                  ),
                ),
              ),
            )
          ]),
        ]),
      ),
    );
  }
}