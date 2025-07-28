enum TagType {
  language,
  parody,
  character,
  artist,
  group,
  female,
  male,
  mixed,
  other
}

enum TagState { banned, required }

class Tag {
  Tag(this.name, this.tagType, {this.tagState});
  String name;
  TagType tagType;

  TagState? tagState;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Tag) return false;
    return name == other.name && tagType == other.tagType;
  }

  @override
  int get hashCode => Object.hash(name, tagType);

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['name'] as String,
      switch (json['tagType'] as String) {
        'parody' => TagType.parody,
        'character' => TagType.character,
        'artist' => TagType.artist,
        'group' => TagType.group,
        'language' => TagType.language,
        'female' => TagType.female,
        'male' => TagType.male,
        'mixed' => TagType.mixed,
        'other' => TagType.other,
        _ => throw Exception('Unknown tag type: ${json['tagType']}'),
      },
      tagState: switch (json['tagState']) {
        'banned' => TagState.banned,
        'required' => TagState.required,
        _ => null,
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tagType': tagType.name,
      'tagState': tagState?.name,
    };
  }
}
