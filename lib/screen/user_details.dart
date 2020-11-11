import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:github_app/providers/user_provider.dart';
import 'package:github_app/screen/repo.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  final username;

  UserDetailsScreen({this.username});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<UserProvider>(context)
          .getUserProfile(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
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
          : user.user.username == null &&
                  user.user.followers == null &&
                  user.user.imageUrl == null &&
                  user.user.followings == null &&
                  user.user.public_repo == null
              ? Center(
                  child: Text('Nothing Found'),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: new Offset(0.0, 0.0),
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage:
                                  NetworkImage(user.user.imageUrl.toString()),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        user.user.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.people_outline,
                                      color: Colors.amber),
                                  title: Text(
                                    'Following',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    user.user.followings.toString(),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Feather.users,
                                      color: Colors.amber),
                                  title: Text(
                                    'Followers',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    user.user.followers.toString(),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RepositiriesScreen(user.user.name),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading:
                                        Icon(Feather.book, color: Colors.amber),
                                    title: Text(
                                      'Public Repo',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Text(
                                      user.user.public_repo.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
