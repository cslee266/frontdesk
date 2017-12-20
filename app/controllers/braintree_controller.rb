class BraintreeController < ApplicationController

  def new
     @user = current_user
  	@client_token = Braintree::ClientToken.generate
  end

  def paid
    # flash[:success] = "Payment successful."
    @user = current_user
  end


  def checkout
	nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => "10.00", #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
       :submit_for_settlement => true
      }
     )

    if result.success?
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
  
end
