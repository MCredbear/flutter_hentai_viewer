// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      (json['id'] as num).toInt(),
      json['name'] as String,
      $enumDecode(_$TagTypeEnumMap, json['tagType']),
      count: (json['count'] as num?)?.toInt(),
      tagState: $enumDecodeNullable(_$TagStateEnumMap, json['tagState']),
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagType': _$TagTypeEnumMap[instance.tagType]!,
      'count': instance.count,
      'tagState': _$TagStateEnumMap[instance.tagState],
    };

const _$TagTypeEnumMap = {
  TagType.parody: 'parody',
  TagType.character: 'character',
  TagType.tag: 'tag',
  TagType.artist: 'artist',
  TagType.group: 'group',
  TagType.language: 'language',
  TagType.category: 'category',
};

const _$TagStateEnumMap = {
  TagState.disabled: 'disabled',
  TagState.banned: 'banned',
  TagState.required: 'required',
};
