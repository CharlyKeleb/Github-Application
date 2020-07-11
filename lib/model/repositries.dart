class Repositries {
  final String repo_name;
  final String created_date;
  final String last_pushed;
  final String description;
  final String branch;
  final String language;
  final String url;
  final int stars;

  Repositries({
    this.repo_name,
    this.created_date,
    this.branch,
    this.description,
    this.language,
    this.last_pushed,
    this.stars,
    this.url,
  });
}
