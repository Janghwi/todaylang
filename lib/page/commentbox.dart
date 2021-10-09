import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CommentWrite extends StatefulWidget {
  @override
  _CommentWriteState createState() => _CommentWriteState();
}

class _CommentWriteState extends State<CommentWrite> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List records = [];

  List filedata = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];

  Future<List> _fetchComments(
      // String view,
      ) async {
    // bool loadRemoteDatatSucceed = false;
    // Response response;
    try {
      Dio dio = Dio();
      var response = await dio.get(
        "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/comments?maxRecords=200&view=Gridview",
        // "https://api.airtable.com/v0/app95nB2yi0WAYDyn/comments?maxRecords=200&view=Gridview",
        options: Options(contentType: 'Application/json', headers: {
          'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
          'Accept': 'Application/json',
        }),
      );

      Map<String, dynamic> result = (response.data);

      records = result['records'];
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        // if (loadRemoteDatatSucceed == false) retryFuture(_fetchMenus, 200);
      }
    }
    return records;
  }

  _postRequest() async {
    final response = await Dio().post(
      'https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/comments',
      options: Options(
        contentType: 'Application/json',
        headers: {
          'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
          'Accept': 'Application/json',
        },
      ),
      data: {
        'records': [
          {
            'fields': {
              'name': 'name',
              'comment': commentController.text,
            }
          },
        ],
      },
    );
  }

  Widget commentChild(data) {
    return FutureBuilder(
        future: _fetchComments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(Colors.amber),
            ));
          } else {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: records.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                      // for (var i = 0; i < data.length; i++)
                      Padding(
                    padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () async {
                          // Display the image in large form.
                          print("Comment Clicked");
                        },
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(data[1]['pic'])),
                        ),
                      ),
                      title: Text(
                        records[index]['fields']['name'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          Text(records[index]['fields']['comment'].toString()),
                    ),
                  );
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: CommentBox(
          userImage:
              "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'janghwi': '장휘',
                  'pic':
                      'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                  'message': commentController.text
                };
                _postRequest();
                _fetchComments();
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
