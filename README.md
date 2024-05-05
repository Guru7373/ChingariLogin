This is a sample application that demonstarted below features

- Login
- Sign Up
- OTP Verification (Hardcoded value 111111)
- Dashboard View consisting tab bar with 3 tabs (Home, Profile & Settings)
- Home View (List with default posts(title, caption and a photo or video url))
- Profile View (Simply displays Name, Email & Phone)
- Settings View (Change light to dark mode)
  
Information such as Name, Email, Password and Phone Number is stored in Keychain.

For Validation of email and password, details is fetched from Keychain 
For Phone Number authentication, First details is fetched from Keychain against the provided phone number and logged in with default OTP 111111.
