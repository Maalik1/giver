if Rails.env.production?
	Stripe.api_key = ""
	STRIPE_PUBLIC_KEY = ""
else
	Stripe.api_key = "sk_test_D42GOw8767rkLHb1wc3b8tdJ"
	STRIPE_PUBLIC_KEY = "pk_test_Avq0UL2OAin4RQ496cKEZR68"
end