class User {
  String username;
  String imageUrl;
  String location;
  int followers;
  int followings;
  int public_repo;
  String joined_date;
  String name;

  User({
    this.username,
    this.imageUrl,
    this.joined_date,
    this.followers,
    this.followings,
    this.public_repo,
    this.location,
    this.name,
  });
}
