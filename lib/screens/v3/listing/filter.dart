import '../../../blocs/listing/listing_bloc.dart';
import 'args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingFilter extends StatefulWidget implements PreferredSizeWidget {
  final Function callback;
  final ListingRouteArguments args;
  final List<Map<String, dynamic>> data = [
    {'name': 'Nổi bật', 'value': 'hot'},
    //{'name': 'Khuyến mãi', 'value': 'voucher'},
    {'name': 'Mới nhất', 'value': 'date'},
    {'name': 'Giá cả', 'value': 'price'},
    //{'name': 'Rating', 'value': 'rating'},
  ];

  static const double height = 55; 

  ListingFilter({ Key? key, required this.callback, required this.args }) : super(key: key);

  @override 
  Size get preferredSize => Size.fromHeight(ListingFilter.height);

  @override
  State<ListingFilter> createState() => _ListingFilterState();
}

class _ListingFilterState extends State<ListingFilter> {
  late final ListingBloc _listingBloc;

  @override 
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listingBloc = BlocProvider.of<ListingBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingBloc, ListingState>(
      bloc: _listingBloc..add(ListingLoadEvent(args: widget.args)),
      builder: (context, state) {
        if (state is ListingLoadSuccessState) {
          return Container(
            //color: Colors.amber.shade100,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
            height: ListingFilter.height,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextButton(
                          child: Row(
                            children: [
                              Text(
                                widget.data[index]['name'], 
                                style: TextStyle(
                                  color: Colors.grey.shade800,            
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                              _getFilterIcon(state.args!, widget.data[index]),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          ), 
                          onPressed: () => widget.callback(context, widget.data[index]['value']),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Text('Có lỗi xảy ra, vui lòng kiểm tra lại !!');
      }    
    );
  }

  Widget _getFilterIcon(ListingRouteArguments args, Map<String, dynamic> sort) {
    Widget icon = Icon(Icons.import_export, size: 20);
    if (args.sort == sort['value']) {
      icon = Icon(
        args.sortBy 
          ? Icons.keyboard_double_arrow_down_sharp 
          : Icons.keyboard_double_arrow_up_sharp,
        color: Colors.green.shade400, 
        size: 19,
      );
    }
    return icon;
  }
}
