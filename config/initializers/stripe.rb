if Rails.env.production?
	Stripe.api_key = ""
	STRIPE_PUBLIC_KEY = ""
else
	Stripe.api_key = ""
	STRIPE_PUBLIC_KEY = ""
end