export const signupData = {
  userId: null,
  password: null,
  passwordRecheck: null,
  name: null,
  year: null,
  month: null,
  day: null,
  sex: null,
  email: null,
  phoneNumber: null,
  interest: '영화감상, 노래, 보드타기',
  clausesAgree: null
}

export const signupJSON = {
  userId: null,
  password: null,
  name: null,
  dob: null,
  gender: null,
  email: null,
  phone: null,
  interests: '영화감상, 노래, 보드타기'
}

export function makeSignupJSON() {
  signupJSON.userId = signupData.userId;
  signupJSON.password = signupData.password;
  signupJSON.name = signupData.name;
  signupJSON.dob = `${signupData.year}-${signupData.month}-${signupData.day}`;
  signupJSON.gender = signupData.sex;
  signupJSON.email = signupData.email;
  signupJSON.phone = signupData.phoneNumber;
  // signupJSON.interests = signupData.interest.join(', ');
  return signupJSON;
}