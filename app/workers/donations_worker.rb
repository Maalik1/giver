class DonationsWorker
	include Sidekiq::Worker

	def perform(user_id, project_id, reward_id, card_token, amount)
		
		user  = User.find(user_id)
    cents = amount.to_i*100

    unless user.stripe_id.present?
      customer = Stripe::Customer.create(
        card: card_token,
        email: user.email
      )
      user.update(stripe_id: customer.id)
    end

    Stripe::Charge.create(
      customer: user.stripe_id,
      amount: cents.floor,
      currency: "usd"
    )

    Donation.create(
      user_id: user_id, 
      project_id: project_id, 
      reward_id: reward_id,
      amount: amount
    )
  end
end