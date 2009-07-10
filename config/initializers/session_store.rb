# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_takkatak_session',
  :secret      => '1cd4293d82a068d17632a63f779aea777f78e74971c1ff4596a5171d35951c36fd71280f4b1a284866a2fde139ee6b927c4959803a7bef0a095ef374cf7be31c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
