class BookModel {
  String? title, description, thumbnail;

  BookModel({this.title, this.description, this.thumbnail});

  factory BookModel.fromApi(Map<String, dynamic> data) {

    String getThumbnailSafety(Map<String, dynamic> data) {
      final imageLinks = data['volumeInfo']['imageLinks'];
      if (imageLinks != null && imageLinks['thumbnail'] != null) {
        return imageLinks['thumbnail'];
      } else {
        return "https://yt3.ggpht.com/ytc/AKedOLR0Q2jl80Ke4FS0WrTjciAu_w6WETLlI0HmzPa4jg=s176-c-k-c0x00ffffff-no-rj";
      }
    }

    return BookModel(
        title: data['volumeInfo']['title'],
        description: data['volumeInfo']['description'],
        thumbnail: getThumbnailSafety(data));
  }
}
