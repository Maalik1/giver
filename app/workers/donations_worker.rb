class DonationsWorker
  include Sidekiq::Worker

  def perform(args={})
    if ['user_id', 'project_id', 'card_token', 'amount'].all? { |a| args.key? a }
      reward_id = args['reward_id'] || nil
      anonymous = args['anonymous'] || false

      user  = User.find(args['user_id'])
      cents = args['amount'].to_i*100

      donation = Donation.create(
        user_id:    args['user_id'], 
        project_id: args['project_id'], 
        amount:     args['amount'],
        reward_id:  reward_id,
        anonymous:  anonymous
      )

      unless user.stripe_id.present?
        customer = Stripe::Customer.create(email: user.email, card: args['card_token'], description: user.name)
        user.update(stripe_id: customer.id)
      end

      Stripe::Charge.create(
        customer: user.stripe_id,
        amount: cents.floor,
        currency: "usd"
      )

    end
  end
end