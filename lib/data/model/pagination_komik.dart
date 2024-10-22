class PaginationComic {
  final int currentPage, totalPage;

  PaginationComic({
    required this.currentPage,
    required this.totalPage,
  });

  factory PaginationComic.fromJson(Map<String, dynamic> json) {
    return PaginationComic(
      currentPage: json["current_page"],
      totalPage: json["last_visible_page"],
    );
  }
}
