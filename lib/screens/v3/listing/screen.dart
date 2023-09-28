import 'package:anylearn/blocs/listing/listing_bloc.dart';
import 'package:anylearn/dto/v3/listing_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/listing/args.dart';
import 'package:anylearn/screens/v3/listing/body.dart';
import 'package:anylearn/screens/v3/listing/filter.dart';
import 'package:anylearn/screens/v3/listing/search_box.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final controller = ScrollController();
  late ListingBloc _bloc;

  ListingRouteArguments? _args;
  ListingDTO? data;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pageRepo = RepositoryProvider.of<PageRepository>(context);
    _bloc = ListingBloc(pageRepository: pageRepo);
    _args =  ModalRoute.of(context)!.settings.arguments as ListingRouteArguments;
  }

  @override 
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        _args!.page++;
        _bloc..add(ListingPaginationEvent(args: _args!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingBloc, ListingState>(
      bloc: _bloc..add(ListingLoadEvent(args: _args!)),
      builder: (context, state) {
        if (state is ListingLoadSuccessState) {   
          data = state.data;  
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back, color: Colors.grey.shade600),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: ListingSearchBox(search: _args!.search,)),
                ],
              ),
            ),
            bottom: PreferredSize(
              child: ListingFilter(bloc: _bloc, args: _args!), 
              preferredSize: Size.fromHeight(55),
            ),
          ),
          body: data == null 
            ? LoadingScreen()
            : ListingBody(
              controller: controller, 
              results: data!.searchResults, 
              hasReached: state.hasReached,
            ),
        );
      }
    );
  }
}
