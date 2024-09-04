import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

enum TagType { parody, character, tag, artist, group, language, category }

enum TagState { disabled, banned, required }

@JsonSerializable()
class Tag {
  Tag(this.id, this.name, this.tagType, {this.count, this.tagState});
  int id;
  String name;
  TagType tagType;
  int? count;

  TagState? tagState;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
