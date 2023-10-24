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
    on<ListingMoreLoadEvent>(_onListingMoreLoadEvent);
  }

  Future<void> _onListingLoadEvent(ListingLoadEvent event, Emitter<ListingState> emit) async {     
    try {
      final data = await pageRepository.dataListing(event.args.toString());   
      return emit(ListingLoadSuccessState(data: data, args: event.args));
    } catch (error) {   
      print('Listing Error: $error');
      emit(ListingLoadFailState());
    }    
  }

  Future<void> _onListingFilterEvent(ListingFilterEvent event, Emitter<ListingState> emit) async {     
    try {
      if (state.args!.sort == event.sort) {
        state.args!.sortBy = !state.args!.sortBy;
      } else {
        state.args!.sort = event.sort;
        state.args!.sortBy = true;
      } 

      final args = ListingRouteArguments.clone(state.args!); 
      final data = await pageRepository.dataListing(state.args.toString());
      return emit(ListingLoadSuccessState(data: data, args: args, isRerender: !state.isRerender));

    } catch (error) {   
      print('Listing Error Filterd: $error');
      return emit(ListingLoadFailState());
    }    
  }

  Future<void> _onListingMoreLoadEvent(ListingMoreLoadEvent event, Emitter<ListingState> emit) async {     
    try {
      if (state.hasReachedMax) return;
      state.args!.page++;

      final data = await pageRepository.dataListing(state.args.toString()); 
      final next = ListingDTO(
        numPage: data.numPage,
        currentPage: data.currentPage,
        searchResults:  List.of(state.data!.searchResults)..addAll(data.searchResults),
      );

      return emit(ListingLoadSuccessState(data: next, args: state.args!, isRerender: state.isRerender));  

    } catch (error) {   
      print('Listing Error: $error');
      return emit(ListingLoadFailState());
    }    
  }
  
}