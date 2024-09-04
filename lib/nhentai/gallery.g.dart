// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gallery _$GalleryFromJson(Map<String, dynamic> json) => Gallery(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['coverImageUrl'] as String,
      (json['tagIds'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    )..language = $enumDecode(_$LanguageEnumMap, json['language']);

Map<String, dynamic> _$GalleryToJson(Gallery instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coverImageUrl': instance.coverImageUrl,
      'language': _$LanguageEnumMap[instance.language]!,
      'tagIds': instance.tagIds,
    };

const _$LanguageEnumMap = {
  Language.japanese: 'japanese',
  Language.chinese: 'chinese',
  Language.english: 'english',
};
