
class News {
  int id;
  String title;
  String? thumbnailImage;
  String content;
  String category;
  String? url;
  int imageHeight;
  int imageWidth;


  News({required this.id, required this.title, required this.content, this.thumbnailImage, required this.category, this.url, this.imageHeight = 2400, this.imageWidth = 1600});


  factory News.fromJSON(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"]["rendered"],
    content: json["content"]["rendered"],
    category: json["categories"][0].toString(),
    thumbnailImage: json["yoast_head_json"]["og_image"][0]["url"],
    url: json["link"],
    imageHeight: json["yoast_head_json"]["og_image"][0]["height"],
    imageWidth: json["yoast_head_json"]["og_image"][0]["width"]
  );
  


}