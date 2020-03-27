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

// name
const userName = $("#user-name");
const userNameLabel = $(".username_label");
function userNameValidation(e) {
  const {
    target: { value }} = e;
  labelHidden(userNameLabel, value.length);
  signupData.name = value;
}
userName.addEventListener("input", userNameValidation);


//성별
const genderLog = $(".genderLog");
const userGender = $(".user_gender");
function selectGender() {
  const genderData = document.querySelector('input[name="gender"]:checked').value;
  if (genderData == "none") {
    signupData.sex = genderData;
    genderLog.innerHTML = STATE_MESSAGE.INVALID.GENDER;
  } else {
    signupData.sex = genderData;
    genderLog.innerHTML = "";
  }
}
userGender.addEventListener("change", selectGender);

//생일
const userBirthYear = $(".year");
const userBirthMonth = $(".month");
const userBirthDay = $(".day");
function selectYear() {
  const userYear = userBirthYear.options[userBirthYear.selectedIndex].value;
  signupData.year = userYear;
}

function selectMonth() {
  const userMonth = userBirthMonth.options[userBirthMonth.selectedIndex].value;
  signupData.month = userMonth;
}

function selectDay() {
  const userDay = userBirthDay.options[userBirthDay.selectedIndex].value;
  signupData.day = userDay;
}

userBirthYear.addEventListener("change", selectYear);
userBirthMonth.addEventListener("change", selectMonth);
userBirthDay.addEventListener("change", selectDay);

//메일
const userEmail = $("#user-email");
const emailLabel = $(".email_label");
const emailLog = $(".emailLog");
function userEmailValidation(e) {
  const {target: { value }} = e;
  labelHidden(emailLabel, value.length);
  const emailReg = VALID_CHECK_REGEX.EMAIL;
  if (!emailReg.test(value)) {
    emailLog.style.color = "red";
    emailLog.innerHTML = STATE_MESSAGE.INVALID.EMAIL;
  } else {
    emailLog.innerHTML = "";
    signupData.email = value;
  }
}
userEmail.addEventListener("input", userEmailValidation);

//핸드폰
const phoneNumberLabel = $(".phone_number_label");
const phoneNumber = $("#phone");
const phoneLog = $(".phoneLog");
function userPhoneNumberValidation(e) {
  const {target: { value }} = e;
  labelHidden(phoneNumberLabel, value.length);

  const phoneReg = VALID_CHECK_REGEX.PHONE_NUMBER;
  if (!phoneReg.test(value)) {
    phoneLog.style.color = "red";
    phoneLog.innerHTML = STATE_MESSAGE.INVALID.PHONE_NUMBER;
  } else {
    phoneLog.innerHTML = "";
    signupData.phoneNumber = value;
  }
}
phoneNumber.addEventListener("input", userPhoneNumberValidation);

//modal
function activeModal() {
  clausesWrap.classList.toggle("active");
}

function closeModal() {
  clausesWrap.classList.add("active");
}

const clausesWrap = $(".clauses-wrap");
const clausesCloseBtn = $(".clauses-close-btn");
const clausesText = $(".clauses-text");
const clausesAgreeBtn = $(".clauses-agree-btn");
function clausesScrollEnd() {
  if (
    clausesText.offsetHeight + clausesText.scrollTop >=
    clausesText.scrollHeight
  ) {
    clausesAgreeBtn.style.backgroundColor = "#41b883";
    clausesAgreeBtn.disabled = false;
    clausesAgreeBtn.style.cursor = "pointer";
  }
}

const contentAgreeBtn = $(".content-agree-btn");
const agreeCheckBtn = $(".agree_btn");
function checkContent(e) {
  e.preventDefault();
  agreeCheckBtn.checked = true;
  signupData.clausesAgree = true;
}

contentAgreeBtn.addEventListener("click", activeModal);
clausesCloseBtn.addEventListener("click", closeModal);
clausesText.addEventListener("scroll", clausesScrollEnd);
clausesAgreeBtn.addEventListener("click", checkContent);

