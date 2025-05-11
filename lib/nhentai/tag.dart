enum TagType { parody, character, tag, artist, group, language, category }

enum TagState { banned, required }

class Tag {
  Tag(this.id, this.name, this.tagType, {this.count, this.tagState});
  int id;
  String name;
  TagType tagType;
  int? count;

  TagState? tagState;

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['id'] as int,
      json['name'] as String,
      switch (json['tagType'] as String) {
        'parody' => TagType.parody,
        'character' => TagType.character,
        'tag' => TagType.tag,
        'artist' => TagType.artist,
        'group' => TagType.group,
        'language' => TagType.language,
        'category' => TagType.category,
        _ => throw Exception('Unknown tag type'),
      },
      count: json['count'] as int?,
      tagState: switch (json['tagState']) {
        'banned' => TagState.banned,
        'required' => TagState.required,
        _ => null,
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagType': tagType.name,
      'count': count,
      'tagState': tagState?.name,
    };
  }
}
