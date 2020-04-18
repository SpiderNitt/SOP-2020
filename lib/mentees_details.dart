import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'config.dart';

class MenteeDet extends StatelessWidget {

String mentorname, mentorgitacc;  

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

final List <String> name = ['anish', 'jerry', 'Thrishik', 'Bharat', 'joel', 'vishal',  'ashuwin',  'akash',  'sidb'];

MenteeDet(this.mentorname, this.mentorgitacc);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(query),
        variables: {
          "code": "AS"
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
      itemCount: result.data["continent"]["countries"].length,
      itemBuilder: (context, index){
        return Column(
          children: <Widget>[
            ListTile(
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: config.fontColor, ),
          contentPadding: EdgeInsets.all(3),
          onTap: (){
            Navigator.pushNamed(context, '/menteetask', arguments: {
              'name': result.data["continent"]["countries"][index]["name"],
              'git':result.data["continent"]["countries"][index]["name"],
            });
          },
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/android.png'),
          ),
          title: Text('${result.data["continent"]["countries"][index]["name"]}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        Divider(
          color: config.fontColor,
          indent: 70,
        ),
        ],
        );
      }
    ),
    );
        }
      }
      );
  }
}