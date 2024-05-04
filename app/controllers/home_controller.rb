class HomeController < ApplicationController

  def index
    @buffets= Buffet.all
  end
  def login
  end

  def sign_up
  end
end
