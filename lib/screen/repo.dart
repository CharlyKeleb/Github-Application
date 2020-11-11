import 'package:flutter/material.dart';
import 'package:github_app/providers/repo_provider.dart';
import 'package:github_app/screen/repo_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RepositiriesScreen extends StatefulWidget {
  String username;
  RepositiriesScreen(this.username);
  @override
  _RepositiriesScreenState createState() => _RepositiriesScreenState();
}

class _RepositiriesScreenState extends State<RepositiriesScreen> {
  var _init = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<RepositriesProvider>(context)
          .getRepositriesList(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    final repoData = Provider.of<RepositriesProvider>(context);
    final dateF = new DateFormat.yMMMMd("en_US");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Repositories'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://icon-library.net/images/github-icon-png/github-icon-png-29.jpg',
              ),
              backgroundColor: Colors.transparent,
              radius: 20,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: repoData.repoList.length,
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => InfoScreen(
                          repoData.repoList[index].repo_name,
                          repoData.repoList[index].url),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 8.0,
                            top: 3.0,
                            bottom: 3.0,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: repoData.repoList[index].repo_name == null
                                ? Text(
                                    'No Name',
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text(
                                    repoData.repoList[index].repo_name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 8.0,
                            top: 3.0,
                            bottom: 3.0,
                          ),
                          child: repoData.repoList[index].description == null
                              ? Text(
                                  'No descriptions provided',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              : Text(
                                  repoData.repoList[index].description
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5.0,
                            right: 50.0,
                            top: 3.0,
                            bottom: 3.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 10.0,
                                width: 10.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 3.0),
                              repoData.repoList[index].language == null
                                  ? Text(
                                      '--',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : Text(
                                      repoData.repoList[index].language,
                                      style: TextStyle(color: Colors.black),
                                    ),
                              SizedBox(width: 4.0),
                              Icon(
                                Icons.star,
                                size: 20.0,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 2.0),
                              Text(
                                repoData.repoList[index].stars.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 4.0),
                              Icon(Icons.call_split, color: Colors.black),
                              SizedBox(width: 2.0),
                              Text(
                                repoData.repoList[index].branch,
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
