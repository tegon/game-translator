class GameTranslator::SessionsController < Devise::SessionsController
	def destroy
		p '='*150
		redirect_to user_index_path
		signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
	end
end