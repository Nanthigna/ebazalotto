var send = document.getElementById("submit");
send.addEventListener("click", formValidation);

function formValidation(e) {
  //Account value
  var username = document.getElementById("username").value;
  var phoneno = document.getElementById("phoneno").value;
  var email = document.getElementById("email").value;
  var password = document.getElementById("password").value;
  var password2 = document.getElementById("password2").value;

  //Email value
  var pattern = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;
  var isValid = pattern.test(email);

  //Account validation
  if (username === "" || phoneno === "" || email === "" || password === "") {
    e.preventDefault();
    let dialog = xdialog.create({ title: 'Missing Info', body: 'All account information must be filled.', buttons: ['ok'] });
    dialog.show();

    return false;
  }

  //Email validation
  if (isValid === false) {
    e.preventDefault();
    let dialog = xdialog.create({ title: 'Wrong E-mail Format', body: 'E-mail has wrong format.', buttons: ['ok'], effect: 'slide_in_right' });
    dialog.show();
    return false;
  }

  //Password validation
  if (password !== password2) {
    e.preventDefault();
    let dialog = xdialog.create({ title: 'Passwords Do Not Match', body: 'Passwords must match.', buttons: ['ok'], effect: '3d_flip_vertical' });
    dialog.show();
    return false;
  }

  var username = document.getElementById("username").value;
  var phoneno = document.getElementById("phoneno").value;
  var email = document.getElementById("email").value;
  var password = document.getElementById("password").value;

  var registerInfo = {
    'username': username,
    'phoneno': phoneno,
    'email': email,
    'password': password
  };

  postRegisterInfo(registerInfo);

  return true;
}


function postRegisterInfo(e) {
  const xhr = new XMLHttpRequest();
  xhr.open("POST", "http://localhost:3000/user/submit_registration");
  xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");

  const body = JSON.stringify({
    referrerid: referrerid,
    username: e.username,
    phoneno: e.phoneno,
    email: e.email,
    password: e.password
  });
  xhr.send(body);
}