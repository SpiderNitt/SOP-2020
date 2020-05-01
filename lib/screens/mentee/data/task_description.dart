import 'package:inductions_20/screens/mentee/config/extractjwt.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TaskDetails {
  int taskNo;
  var taskDescription;
  List<String> taskResourcesDesc;
  List<String> taskResourcesLink;
  int noSubmissions;
  TaskDetails(this.taskNo);

  Future<void> extractTaskDetails() async {
    ProvideJwt provideJwt = ProvideJwt();
    await provideJwt.extractjwt();
    String jwt = provideJwt.jwt;
    String url =
        "https://spider.nitt.edu/inductions20test/api/task/${this.taskNo}";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    };
    Response response = await get(url, headers: headers);
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      var parsedJson = json.decode(response.body);
      this.taskDescription = parsedJson["task_description"];
      int noResources = parsedJson["resources_no"];
      this.noSubmissions = parsedJson["no_of_submissions"];

      taskResourcesDesc = [];
      taskResourcesLink = [];
      var resourceList = parsedJson["resources"];
      for (int i = 0; i < noResources; i++) {
        this.taskResourcesDesc.add(resourceList["$i"]["description"]);
        this.taskResourcesLink.add(resourceList["$i"]["link"]);
      }
    } else {
      print("failed to load");
    }
  }
}
