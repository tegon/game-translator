class GameTranslator::SessionsController < Devise::SessionsController
	def destroy
		redirect_to 'localhost'
		signed_out = Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
	end
end