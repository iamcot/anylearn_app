library listingbloc;

import 'package:anylearn/dto/v3/listing_dto.dart';
import 'package:anylearn/models/page_repo.dart';
import 'package:anylearn/screens/v3/listing/args.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final PageRepository pageRepository;

  ListingBloc({required this.pageRepository}) : super(ListingInitState()) {
    on<ListingLoadEvent>(_onListingLoadEvent);
    on<ListingFilterEvent>(_onListingFilterEvent);
    on<ListingPaginationEvent>(_onListingPaginationEvent);
  }

  Future<void> _onListingLoadEvent(ListingLoadEvent event, Emitter<ListingState> emit) async {     
    try {
      //print('Listing: ${event.args}');
      final data = await pageRepository.dataListing(event.args.toString());   
      return emit(ListingLoadSuccessState(data: data, hasReached: data.currentPage == data.numPage));
    } catch (error) {   
      print('Listing Error: $error');
      emit(ListingLoadFailState());
    }    
  }

  Future<void> _onListingFilterEvent(ListingFilterEvent event, Emitter<ListingState> emit) async {     
    try {
      event.args.sortBy = state.sort == event.args.sort ? !state.sortBy : true;   
      final data = await pageRepository.dataListing(event.args.toString());
      //print('Filter: ${event.args}'); 
      return emit(ListingLoadSuccessState(data:data, sort: event.args.sort, sortBy: event.args.sortBy));
    } catch (error) {   
      print('Listing Error: $error');
      return emit(ListingLoadFailState());
    }    
  }

  Future<void> _onListingPaginationEvent(ListingPaginationEvent event, Emitter<ListingState> emit) async {     
    try {
      if (state.hasReached) return;

      final data = await pageRepository.dataListing(event.args.toString()); 
      final next = ListingDTO(
        numPage: data.numPage,
        currentPage: data.currentPage,
        searchResults: List.of(state.data!.searchResults)..addAll(data.searchResults),
      );

      //print('Pagination: ${event.args}');
      return emit(ListingLoadSuccessState(
        data: next, 
        sort: event.args.sort,
        sortBy: event.args.sortBy,
        hasReached: event.args.page > next.numPage
      ));  
    } catch (error) {   
      print('Listing Error: $error');
      return emit(ListingLoadFailState());
    }    
  }
}