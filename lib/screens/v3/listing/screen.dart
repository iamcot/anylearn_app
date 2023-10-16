import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/listing/listing_bloc.dart';
import '../../loading.dart';
import 'args.dart';
import 'card.dart';

class ListingScreen extends StatefulWidget {
  final ListingRouteArguments? args;
  const ListingScreen({Key? key, this.args}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late final ScrollController _scrollController = ScrollController();
  late ListingBloc _bloc;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<ListingBloc>(context);
  }

  @override 
  void initState() {
    super.initState(); 
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        _bloc..add(ListingLoadMoreEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingBloc, ListingState>(
      bloc: _bloc..add(ListingLoadEvent(args: widget.args)),
      builder: (context, state) {   
        if (state is ListingLoadSuccessState) {

          final searchResults = state.data!.searchResults; 
          if (searchResults.isEmpty) {
            return Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm."));
          }
          
          return Container(
            padding: EdgeInsets.only(top: 10),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    key: ValueKey<bool>(state.isRerender),
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      if(index == searchResults.length - 1 && !state.hasReachedMax) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListingCard(data: searchResults[index]);
                    }
                  ),
                ),
              ],
            ),
          );
        }

        return LoadingScreen();
      }  
    );
  }

}


