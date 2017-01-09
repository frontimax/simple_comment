# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_sc_session'
Rails.application.config.session_store :redis_session_store, {
  key: '_sc_session',
  redis: {
    expire_after: 10.minutes,
    key_prefix: 'sc:session:'
  }
}