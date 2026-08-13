// ignore_for_file: public_member_api_docs, sort_constructors_first
enum DiceSides { one, two, three, four, five, six }

class DieModel {
  DieModel({required this.id, required this.side});

  final int id;
  final DiceSides side;

  DieModel copyWith({DiceSides? side}) {
    return DieModel(id: id, side: side ?? this.side);
  }
}
