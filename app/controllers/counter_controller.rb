class CounterController < ActionController::Base

  def index
    if session[:clicks] != nil
      session[:clicks] = session[:clicks] + 1
    else
      session[:clicks] = 0
    end
  end

end
