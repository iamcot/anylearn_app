
import 'package:anylearn/blocs/listing/listing_bloc.dart';
import 'package:anylearn/screens/v3/listing/args.dart';
import 'package:flutter/material.dart';

class ListingFilter extends StatelessWidget {
  final ListingBloc bloc;
  final ListingRouteArguments args;
  final List<Map<String, dynamic>> filters = [
    {'filter': 'Hot', 'value': 'hot'},
    {'filter': 'New', 'value': 'date'},
    {'filter': 'Price', 'value': 'price'},
  ];

  ListingFilter({Key? key, required this.bloc, required this.args}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      //color: Colors.amber.shade100,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              //return Text('123');
              return Container(
                margin: EdgeInsets.only(right: 10),
                child: FilledButton(
                  child: Text(
                    filters[index]['filter'], 
                    style: TextStyle(
                      color: Colors.grey.shade700,            
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                  ), 
                  onPressed: () {
                    args.sort = filters[index]['value'];
                    bloc..add(ListingFilterEvent(args: args));
                  }
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}