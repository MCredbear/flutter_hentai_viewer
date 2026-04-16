enum TagType { parody, character, tag, artist, group, language, category }

enum TagState { banned, required }

class Tag {
  Tag(this.id, {this.name, this.slug, this.type, this.count, this.tagState});
  int id;
  String? name;
  String? slug;
  TagType? type;
  int? count;

  TagState? tagState;

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['id'] as int,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      type: switch (json['type'] as String) {
        'parody' => TagType.parody,
        'character' => TagType.character,
        'tag' => TagType.tag,
        'artist' => TagType.artist,
        'group' => TagType.group,
        'language' => TagType.language,
        'category' => TagType.category,
        _ => throw Exception('Unknown tag type: ${json['type']}'),
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
      'slug': slug,
      'type': type?.name,
      'count': count,
      'tagState': tagState?.name,
    };
  }
}
