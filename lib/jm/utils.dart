import 'package:http/http.dart' as http;

final domains = [
  "18comic.vip",
  "18comic-xq.cc",
  "jmcomic-zzz.org",
  "18comic-cnye.org",
  "18comic-cnye.club",
  "18comic.org",
  "jmcomic-zzz.one",
  "jm-uc.vip/ZNPJam",
];

Future<int> pingDomain(String domain) async {
  try {
    final stopwatch = Stopwatch()..start();
    final response = await http.get(Uri.parse("https://$domain/album/123456"));
    stopwatch.stop();
    if (response.statusCode == 200) {
      return stopwatch.elapsedMilliseconds;
    } else {
      return -1;
    }
  } catch (e) {
    return -1;
  }
}
