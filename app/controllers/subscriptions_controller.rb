class SubscriptionsController < ApplicationController
  def destroy      
    subscription = Subscription.find(params[:id])
    hash = params[:d]
    if(subscription.del_token == hash)
      subscription.destroy
    else
      flash[:error] = 'Geht nit'
    end                         
    
    redirect_to root_path
    
  end

end
