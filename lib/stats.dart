import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inductions_20/statsdis.dart';
import 'config.dart';

class Stats extends StatefulWidget {
 
 String menteename, gitacc;
 Stats(this.menteename, this.gitacc);

  @override
  _StatsState createState() => _StatsState(this.menteename, this.gitacc);
}

class _StatsState extends State<Stats> {

  String menteename, gitacc;
 
  final String query = r"""
   
   query GetContinent($code : ID!){
                      country(code:$code){
                        name
                        capital
  											currency
                      }
                    }
   """;

  _StatsState(this.menteename, this.gitacc);

  @override

  Widget build(BuildContext context) {
    return  Query(
      options: QueryOptions(
        documentNode: gql(query),
        variables: {
          "code": "GB"
        }
      ), 
      builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }){
      
       if(result.loading)
        return Center(
          child: CircularProgressIndicator(),
        );
       
       else if(result.data == null)
       return Center(
          child: Text("No data found", style: TextStyle( color: config.fontColor ))
        );

      else{
        return Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 390.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
        itemCount: 1,
      itemBuilder: (context, index){
        return Statsdis(result.data['country']['name'], 0.6, 0.2) ;
      }
    ),
    );
  }
});
  }
}