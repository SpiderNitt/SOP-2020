import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Graphqltemp extends StatelessWidget {
  
  dynamic home;
  
  Graphqltemp(this.home);
  
  @override

    Widget build(BuildContext context) {
    
    final HttpLink httpLink =
    HttpLink(uri: "https://countries.trevorblades.com/");
    
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink as Link,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    
    return GraphQLProvider(
      child: home,
      client: client,
    );
  }
}
