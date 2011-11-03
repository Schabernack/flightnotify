class SubscriptionsController < ApplicationController
  def destroy      
    subscription = Subscription.find(params[:id])
    hash = params[:d]
    Rails.logger.info subscription.inspect
    Rails.logger.info hash.inspect
    if(subscription.del_token == hash)
      subscription.destroy
    else
      flash[:error] = 'Geht nit'
    end                         
    
    redirect_to root_path
    
  end

end
