import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'config.dart';

class Requestlist extends StatefulWidget {

String mentorname, mentorgitacc;  

Requestlist(this.mentorname, this.mentorgitacc);

  @override
  _RequestlistState createState() => _RequestlistState(this.mentorname, this.mentorgitacc);
}

class _RequestlistState extends State<Requestlist> {

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

  String mentorname, mentorgitacc, searchword = '';  

  final _formkey = GlobalKey<FormState>();

  dynamic resultobt; 

  _RequestlistState(this.mentorname, this.mentorgitacc);
 

List<Widget> listmaker(dynamic contxt){

List<Widget> finallist = [];
for(int i = 0; i< this.resultobt['continent']['countries'].length; i++){
  if(this.resultobt['continent']['countries'][i]['name'].contains(this.searchword) || this.searchword == ''){
    finallist.add(
      Column(
          children: <Widget>[
            ListTile(
          contentPadding: EdgeInsets.all(3),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/android.png'),
          ),
          title: Text('${this.resultobt['continent']['countries'][i]['name']}',  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   SizedBox(
                    height:5,
                  ),
                  Text('${this.resultobt['continent']['countries'][i]['capital']}', softWrap: true,  style: TextStyle( fontSize: 13, fontFamily: config.fontFamily, color: config.fontColor)),
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
                  Navigator.pushNamed(contxt, '/writereview', arguments: {
                  'repo_det': this.resultobt['continent']['countries'][i]['capital'],
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
        )
    );
  }
}
return finallist;
}

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
      this.resultobt = result.data;
      return
      Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: <Widget>[
            
            Form(
          key: _formkey,
          child: TextFormField(
          cursorColor: config.fontColor,
          style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
          maxLines: null,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     width: config.bordWid,
                     color: config.fontColor,
                   ), 
                 ),
             labelText: 'Search',
             labelStyle: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor),
          ),
          onChanged: (String value){
            this.setState(() {
              searchword = value;
            });
          },
          ),     
        ),

        Divider(
           color: config.fontColor,
        ),
   
      Container(
        child: Column(
        children: listmaker(context),
        ),
      ),
    ],
    ),
  );    
  }
});
  }
}

