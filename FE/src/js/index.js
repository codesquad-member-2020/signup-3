import { $ } from "./utils/selector.js";
import {
  VALID_CHECK_REGEX,
  STATE_MESSAGE,
  ALERT_MESSAGE
} from "./constant/constant.js";
import {
  signupData,
  makeSignupJSON,
} from "./data/signupData.js";

//userID
const userIdInput = $("#user-id");
const userIdLog = $(".userIdLog");
const userIdLabel = $(".id_label");
userIdInput.addEventListener("change", userIdValidation);
userIdInput.addEventListener("input", userIdValidation);
function checkedUserId() {
  const url = `https://signup-test8877.herokuapp.com/check-duplicate/userId`
  fetch(url, {
    method: 'GET', 
    mode: 'no-cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
        'Content-Type': 'application/json',
    },
    redirect: 'follow',
    referrer: 'no-referrer',
  })
  .then(res => console.log(res))
}

function labelHidden(label, length) {
  if (length > 0) {
    label.style.display = "none";
  } else {
    label.style.display = "block";
  }
}

function userIdValidation(e) {
  const {target: { value }} = e;

  labelHidden(userIdLabel, value.length);
  const idReg = VALID_CHECK_REGEX.ID;
  if (!idReg.test(value)) {
    userIdLog.innerHTML = STATE_MESSAGE.INVALID.ID;
    userIdLog.style.color = "red";
  } else {
    userIdLog.innerHTML = STATE_MESSAGE.VALID.ID;
    userIdLog.style.color = "green";
    signupData.userId = value;
    checkedUserId() 
  }
}

//passwod
const userPasswordInput = $("#user-password");
const passwordLog = $(".passwordLog");
const passwordLabel = $(".password_label");
const passwordComfirmLog = $(".passwordComfirmLog");
const userPasswordConfirmInput = $("#password-comfirm");
const passwordComfirmLabel = $(".password-comfirm");
function passwordValidation(e) {
  const {target: { value }} = e;
  labelHidden(passwordLabel, value.length);
  const passwordRegLength = VALID_CHECK_REGEX.PASSWORD.LENGTH;
  const passwordRegUpper = VALID_CHECK_REGEX.PASSWORD.UPPER;
  const passwordRegNumber = VALID_CHECK_REGEX.PASSWORD.NUMBER;
  const passwordRegSpecial = VALID_CHECK_REGEX.PASSWORD.SPECIAL;
  passwordLog.style.color = "red";
  if (!passwordRegLength.test(value)) {
    passwordLog.innerHTML = STATE_MESSAGE.INVALID.PASSWORD.LENGTH;
  } else if (!passwordRegNumber.test(value)) {
    passwordLog.innerHTML = STATE_MESSAGE.INVALID.PASSWORD.NUMBER;
  } else if (!passwordRegUpper.test(value)) {
    passwordLog.innerHTML = STATE_MESSAGE.INVALID.PASSWORD.UPPER;
  } else if (!passwordRegSpecial.test(value)) {
    passwordLog.innerHTML = STATE_MESSAGE.INVALID.PASSWORD.SPECIAL;
  } else {
    passwordLog.style.color = "green";
    passwordLog.innerHTML = STATE_MESSAGE.VALID.PASSWORD;
    signupData.password = value;
  }
}

function passwordComfirm(e) {
  const {target: { value }} = e;
  labelHidden(passwordComfirmLabel, value.length);
  if (value == userPasswordInput.value) {
    passwordComfirmLog.innerHTML = STATE_MESSAGE.VALID.PASSWORD_RECHECK;
    passwordComfirmLog.style.color = "green";
    signupData.passwordRecheck = value;
  } else {
    passwordComfirmLog.innerHTML = STATE_MESSAGE.INVALID.PASSWORD_RECHECK;
  }
}
userPasswordInput.addEventListener("input", passwordValidation);
userPasswordConfirmInput.addEventListener("input", passwordComfirm);
