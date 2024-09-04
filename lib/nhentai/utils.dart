const proxyUrl = 'https://hikari.redbear.moe/proxy/';
const hostUrl = 'https://nhentai.net';

String proxy(String url) {
  if (url.startsWith('https://')) {
    return proxyUrl + url.substring(8);
  } else if (url.startsWith('http://')) {
    return proxyUrl + url.substring(7);
  } else
  // if (url.startsWith('/')) {
  //   return proxyUrl + url;
  // }
  {
    return proxyUrl + url;
  }
}
