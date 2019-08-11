class Ability
	include CanCan::Ability

	def initialize(current_user)
		can [:read, :create, :new, :get_user_tweets], :all
		can [:edit, :destroy, :update], :all, :user_id => current_user.id
	end

end
