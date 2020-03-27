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
