// import 'package:anylearn/blocs/pdp/pdp_blocs.dart';
// import 'package:anylearn/models/page_repo.dart';
// import 'package:anylearn/models/transaction_repo.dart';
import 'package:anylearn/widgets/goto_profile_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dto/items_dto.dart';
import '../../widgets/price_box.dart';
import '../../widgets/rating.dart';
import '../../widgets/sliver_banner.dart';
import '../../widgets/text2lines.dart';
import '../teacher/teacher_filter.dart';

class ItemsBody extends StatefulWidget {
  final ItemsDTO itemsDTO;

  const ItemsBody({Key key, this.itemsDTO}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemsBody();
}

class _ItemsBody extends State<ItemsBody> {
  // PdpBloc pdpBloc;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final pageRepo = RepositoryProvider.of<PageRepository>(context);
  //   final transRepo = RepositoryProvider.of<TransactionRepository>(context);
  //   pdpBloc = PdpBloc(pageRepository: pageRepo, transactionRepository: transRepo);
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverBanner(
          banner: widget.itemsDTO.user.banner,
        ),
        GotoProfileBar(userId: widget.itemsDTO.user.id),
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
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey[100],
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey[100],
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/pdp",
                            arguments: widget.itemsDTO.items.data[index].id); //data.items[index].id.toString()
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: width * 3 / 4,
                            child: ClipRRect(
                              child: widget.itemsDTO.items.data[index].image != null
                                  ? Image.network(
                                      widget.itemsDTO.items.data[index].image,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(Icons.broken_image),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text2Lines(
                              text: widget.itemsDTO.items.data[index].title,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RatingBox(
                      score: widget.itemsDTO.items.data[index].rating,
                      fontSize: 14.0,
                      alignment: "start",
                    ),
                    Row(children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: PriceBox(
                              price: widget.itemsDTO.items.data[index].price,
                              orgPrice: widget.itemsDTO.items.data[index].priceOrg),
                        ),
                      ),
                      // Container(
                      //     child: IconButton(
                      //   icon: Icon(
                      //     Icons.add_shopping_cart,
                      //     color: Colors.blue,
                      //   ),
                      //   onPressed: null,
                      // )),
                    ]),
                  ],
                ),
              );
            },
            childCount: widget.itemsDTO.items.data.length,
          ),
        ),
      ],
    );
  }
}
