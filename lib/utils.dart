import 'package:flutter_hentai_viewer/global_settings_store.dart';

const cloudflareProxyUrl = 'https://tairitsu.redbear.moe/proxy/';
const vercelProxyUrl = 'https://hikari.redbear.moe/proxy/';

String proxy(String url) {
  switch (globalSettingsStore.proxyMode) {
    case ProxyMode.cloudflare:
      if (url.startsWith('https://')) {
        return cloudflareProxyUrl + url;
      } else if (url.startsWith('http://')) {
        return cloudflareProxyUrl + url;
      } else {
        return cloudflareProxyUrl + url;
      }
    case ProxyMode.vercel:
      if (url.startsWith('https://')) {
        return vercelProxyUrl + url.substring(8);
      } else if (url.startsWith('http://')) {
        return vercelProxyUrl + url.substring(7);
      } else {
        return vercelProxyUrl + url;
      }
    case ProxyMode.none:
      return url;
    default:
      if (url.startsWith('https://')) {
        return vercelProxyUrl + url.substring(8);
      } else if (url.startsWith('http://')) {
        return vercelProxyUrl + url.substring(7);
      } else {
        return vercelProxyUrl + url;
      }
  }
}
