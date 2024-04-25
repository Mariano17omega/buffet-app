class HomeController < ApplicationController
  def index
    @buffets= Buffet.all
  end
  def login
  end

end
