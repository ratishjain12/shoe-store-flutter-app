// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteItemAdapter extends TypeAdapter<FavouriteItem> {
  @override
  final int typeId = 1;

  @override
  FavouriteItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteItem(
      id: fields[0] as int,
      name: fields[1] as String,
      imgUrl: fields[2] as String,
      price: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imgUrl)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
