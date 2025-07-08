const proxyUrl = 'https://tairitsu.redbear.moe/proxy/';

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
