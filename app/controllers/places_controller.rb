class PlacesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@places = Place.paginate(:page => params[:page], :per_page => 5)
	end

	def new
		@place = Place.new
	end

	def show
		@place = Place.find(params[:id])
	end

	def create
		current_user.places.create(place_params)
		redirect_to root_path
	end

	def edit
		@place = Place.find(params[:id])

		if @place.user != current_user
			return render text: 'Not allowed', status: :forbidden
		end
	end

	def update
		@place = Place.find(params[:id])

		if @place.user != current_user
			return render text: 'Not allowed', status: :forbidden
		end
		@place.update_attributes(place_params)
		redirect_to root_path
	end

	def destroy
		@place = Place.find(params[:id])

		if @place.user != current_user
			return render text: 'Not allowed', status: :forbidden
		end
		@place.destroy
		redirect_to root_path
	end

	private

	def place_params
		params.require(:place).permit(:name, :description, :address)
	end
end
