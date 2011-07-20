# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_css3buttons_session',
  :secret      => '8ca5cb8757e02f41acba7a9e4a6c60a08a72eaf8128f52c8921201ae131291a82f1550ddaad0985eb5b2f8ed47abafb42e1b71c7c6ee626e34270bf9bc36a905'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
