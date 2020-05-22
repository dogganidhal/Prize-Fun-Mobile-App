import 'package:cloud_firestore/cloud_firestore.dart';


enum PrizeCategoryType {
  SERVICE,
  PRODUCT
}

String stringForPrizeCategoryType(PrizeCategoryType type) {
  switch (type) {
    case PrizeCategoryType.SERVICE:
      return "Services";
    case PrizeCategoryType.PRODUCT:
      return "Produits";
  }
  return null;
}

class PrizeCategory {
  final String id;
  final String title;
  final PrizeCategoryType type;
  final String photoUrl;

  PrizeCategory({this.id, this.title, this.type, this.photoUrl});

  factory PrizeCategory.fromDocument(DocumentSnapshot document) => PrizeCategory(
    id: document.documentID,
    title: document.data['title'],
    photoUrl: document.data['photoUrl'],
    type: document.data['type'] == 'SERVICES' ?
      PrizeCategoryType.SERVICE :
      PrizeCategoryType.PRODUCT
  );
}