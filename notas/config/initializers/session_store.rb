# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_notas_session',
  :secret      => '69d221145837bc21a402ab2c9888acf4156c73cda6c0065928fc092e162673124182eed7439f944bf84b01c4ba016809a31ff96c90f22a7b10d1b9531f5d9376'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
