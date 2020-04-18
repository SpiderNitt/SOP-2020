import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'config.dart';

class Requestlist extends StatelessWidget {

String mentorname, mentorgitacc;  

  final String query = r"""
                    query GetContinent($code : ID!){
                      continent(code:$code){
                        name
                        countries{
                          name
                          capital
                        }
                      }
                    }
                  """;

Requestlist(this.mentorname, this.mentorgitacc);

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
     
      return ListView.builder(
      itemCount: result.data["continent"]["countries"].length,
      itemBuilder: (context, index){
        return Column(
          children: <Widget>[
            ListTile(
          contentPadding: EdgeInsets.all(3),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/android.png'),
          ),
          title: Text('${result.data["continent"]["countries"][index]["name"]}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   SizedBox(
                    height:5,
                  ),
                  Text('${result.data["continent"]["countries"][index]["capital"]}', softWrap: true,  style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.fontColor)),
                  SizedBox(
                    height:5,
                  ),
                  Text('Repo link: http://github.com/chakki/dfgh/dsafgdhf/sdafghj/dfshk/dfshk/dfhjkl/dfshk/dsfhj',  softWrap: true, style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.fontColor)),
                   SizedBox(
                    height:5,
                  ),
                  Text('Not reviewed', softWrap: true, style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.danger)),
                  SizedBox(
                    height:5,
                  ),
                  FlatButton(
                  onPressed: (){
                  Navigator.pushNamed(context, '/writereview', arguments: {
                  'repo_det': result.data["continent"]["countries"][index]["capital"],
                   });
          }, 
         child: Text('Write a review', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor)),
         ),
                ],
              ),
        ),
        Divider(
          color: config.fontColor,
          indent: 70,
        ),
        ],
        );
      }
    );
  }
});
  }
}