# README

Citrakara Backend

Gems used: 
Auth is using knock, JWT
Upload Image is usingCarrierWave, Cloudinary


USER

Signup
/v1/user/signup(.:format) \n
expected JSON POST request : {"user":{"username":"didi","email":"email@email.com","password":"123456","password_confirmation":"123456"}}

Signin
/v1/user/signin(.:format) \n 
expected JSON POST request : {"auth":{"email":"email@email.com","password":"123456"}}

List user
/v1/user/all(.:format) \n
GET request is expected with JWT token sent on the header 


