Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_qIzQhRTYa1vj0VYgObISGyRl00lvU9GYrS'],
  secret_key:      ENV['sk_test_h8jB3FSsLUUQe5FXaNEknIxL00ofmc9Eg2']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
