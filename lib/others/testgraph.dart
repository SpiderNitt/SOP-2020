import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class TestGraphql extends StatelessWidget {

  final String query = r"""
                    query GetContinent($code : ID!){
                      continent(code:$code){
                        name
                        countries{
                          name
                        }
                      }
                    }
                  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GraphlQL Client"),
      ),
      body: Query(
    options: QueryOptions(
    documentNode: gql(query), 
    variables:  {
      'code': "AS",
    },
  ),
  builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
    if (result.hasException) {
        return Text(result.exception.toString());
    }

    else if (result.loading) {
      return Text('Loading');
    }
     
     return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
           return ListTile(
              title:
                 Text(result.data['continent']['countries'][index]['name']),
              );
            },
      itemCount: result.data['continent']['countries'].length,
    );
  },
),
    );
  }
}
