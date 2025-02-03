const proxyUrl = 'https://tairitsu.redbear.moe/proxy/';
const hostUrl = 'https://nhentai.net';

String proxy(String url) {
  if (url.startsWith('https://')) {
    return proxyUrl + url;
  } else if (url.startsWith('http://')) {
    return proxyUrl + url;
  } else
  // if (url.startsWith('/')) {
  //   return proxyUrl + url;
  // }
  {
    return proxyUrl + url;
  }
}
