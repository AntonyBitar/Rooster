import '../Item/ItemModel.dart';

class ItemImage {
  int? id;
  String? imgUrl;
  Item? item;

  ItemImage({this.id, this.imgUrl, this.item});

  factory ItemImage.fromJson(Map<String, dynamic> json) {
    return ItemImage(
      id: json['id'],
      imgUrl: json['img_url'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img_url': imgUrl,
      'item': item?.toJson(),
    };
  }
}
