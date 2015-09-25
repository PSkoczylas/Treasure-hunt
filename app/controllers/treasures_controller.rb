class TreasuresController < ApplicationController
  before_action :get_in
  before_action :check_if_exists, only: [:create]
  skip_before_action :verify_authenticity_token
  
  def create
    @treasure = Treasure.new(email: @email)
    if @treasure.save
      return_result  
    else
      render json: { :status => 'error', :distance => -1, :error => 'error description' }
    end
  end

  private
    def check_if_exists
      @treasure = Treasure.find_by(email: @email)
      if @treasure != nil
        if @treasure.is_winner == true
          render json: { :status => 'error', :distance => -1, :error => 'You won one time, it is enough'}
        else
          return_result
        end
      end
    end
    
    def return_result
      distance = check_distance
      if check_distance <= 5
        @treasure.is_winner = true
        @treasure.save
        place = Treasure.where(is_winner: true).count
        render json: { :status => 'You are ' + place.to_s + ' treasure hunter who has found the treasure.', :place => place}
      else
        @treasure.is_winner = false
        @treasure.save
        render json: { :status => 'ok', :distance => distance} 
      end
    end
    
    def check_distance()
      return Math.sqrt((50.051227 - @x)**2 + (19.945704 - @y)**2)
    end
    
    def get_in
  		@email = params[:email]
	  	@x = params[:current_location][0].to_f
	  	@y = params[:current_location][1].to_f
    end
end
