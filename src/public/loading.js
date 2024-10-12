const url = 'https://ebazas.com/';
let urlString = window.location.search; //'https://ebazas.com/form?referrerid=nanthigna';
let paramString = urlString.split('?')[1];
let queryString = new URLSearchParams(paramString);
let referrerid = '';

for (let pair of queryString.entries()) {
    referrerid = pair[1];
    makeGetReferrerRequest(`${url}user/username=${referrerid}`);
}

function makeGetReferrerRequest(url) { // ES6
    fetch(url)
        .then((r) => r.json())
        .then((data) => {
            var referrer = data.data[0][0];

            if (referrer != undefined) {
                console.log(referrer);
                document.getElementById("referrerid").innerHTML = `Referrer: ` + pair[1];
            } else {
                console.log('This referrer does not exist!');
                window.location.assign('https://ebazas.com/error/index.html');
            }
        })
        .catch((e) => console.log('Fetch Error!'));
}

function makeGetReferrerXMLHttpRequest(url) { //XMLHttpRequest
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url);
    xhr.responseType = 'json';

    xhr.onload = function () {
        var response = xhr.response;
        var referrer = response.data[0][0];

        if (referrer != undefined) {
            console.log(referrer);
        } else {
            console.log('This referrer does not exist!');
        }
    };

    xhr.onerror = function () {
        console.log('Fetch Error!');
    };

    xhr.send();
}

function makeGetReferrerES7AsyncRequest(url) { // ES7 async functions
    (async () => {
        try {
            var response = await fetch(url);
            var data = await response.json();
            var referrer = data.data[0][0];

            if (referrer != undefined) {
                console.log(referrer);
            } else {
                console.log('This referrer does not exist!');
            }
        } catch (e) {
            console.log('Fetch Error!');
        }
    })();
}