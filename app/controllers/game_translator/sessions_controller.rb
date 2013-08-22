class GameTranslator::SessionsController < Devise::SessionsController
	def destroy
    stop_translating if current_user.translator?
		redirect_to user_index_path
		signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
	end

  private

  def stop_translating
    p 'stop_translating'*250
    current_user.games.where(status: 'translating').map do |game|
      game.update_attribute(:status, 'not_translated')
    end
  end
end