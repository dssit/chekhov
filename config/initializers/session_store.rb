# Be sure to restart your server when you modify this file.

Chekhov::Application.config.session_store :cookie_store, key: '_chekhov_session'

# Needed for CAS Single Sign-Out
Chekhov::Application.config.session_store :active_record_store
