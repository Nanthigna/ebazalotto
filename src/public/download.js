var send = document.getElementById("download");
send.addEventListener("click", download);

function download() {
  var url = "/EbazaLottery v.1.2.1.apk";
  const anchor = document.createElement('a');

  anchor.href = url;
  anchor.download = url.split('/').pop();
  document.body.appendChild(anchor);
  anchor.click();
  document.body.removeChild(anchor);

  return true;
}
