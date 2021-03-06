# Citrakara Backend

### Install Ruby using rvm

```bash
curl -sSL https://get.rvm.io | sudo bash -s stable
rvm install ruby-2.4.1
gem install bundler --no-rdoc --no-ri
```
### Prepare Database
Create user role:
```bash
sudo -u postgres psql --command "create role admin with createdb login password 'your_admin_password';"
```
Connection setting posgresql:
```bash
sudo vim /etc/postgresql/9.6/main/pg_hba.conf
```
Find part _local (line 90)_ and change _peer_ to _md5_
```bash
local all all md5
```
Restart service postgresql

### Setup Env
```bash
sudo vim /etc/environment
```
Add the following lines:
```bash
#PATH="/home/ubuntu/bin:/home/ubuntu/.local/bin:/usr/local/rvm/gems/ruby-2.4.1/bin:/usr/local/rvm/gems/ruby-2.4.1@global/bin:/usr/local/rvm/rubies/ruby-2.4.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/rvm/bin"
export CITRAKARA_DATABASE_PASSWORD="your_password"
export RAILS_SERVE_STATIC_FILES="public"
export SECRET_KEY_BASE="xxxxx"
```
Reload env
```bash
source /etc/environment
```
### Setup Rails
```bash
bundle install
RAILS_ENV=production bundle exec rake db:create db:migrate
RAILS_ENV=production bundle exec rake db:seed
RAILS_ENV=production bundle exec rake assets:precompile
```

### Create App
```bash
rails new citrakara --api --database=postgresql
cd citrakara
bundle install
rails db:create
```

### Gems: 
1. Auth is using _knock, JWT_
2. Upload Image is using _CarrierWave, Cloudinary_
3. CMS is using _forest CMS_



### Features
1. Manage User (CRUD and User role)
2. Manage passwords (forgot password by sending email token, update password, reset password)
3. Manage Paintings (CRUD)
4. Favorites
5. Welcome email greeting
6. Feedback
7. Notifications
8. Comments
8. Highlight Painting ( monetization )
9. Transaction ( payment/topup manual verification, balance manual verification, notifications by email)
10. CMS





