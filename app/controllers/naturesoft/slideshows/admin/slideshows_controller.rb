module Naturesoft
  module Slideshows
    module Admin
      class SlideshowsController < AdminController
        before_action :set_slideshow, only: [:show, :edit, :update, :destroy]
    
        # GET /slideshows
        def index
          @slideshows = Slideshow.all.paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /slideshows/1
        def show
        end
    
        # GET /slideshows/new
        def new
          @slideshow = Slideshow.new
        end
    
        # GET /slideshows/1/edit
        def edit
        end
    
        # POST /slideshows
        def create
          @slideshow = Slideshow.new(slideshow_params)
          @slideshow.user = current_user
    
          if @slideshow.save
            redirect_to admin_slideshows_path, notice: 'Slideshow was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /slideshows/1
        def update
          if @slideshow.update(slideshow_params)
            redirect_to admin_slideshows_path, notice: 'Slideshow was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /slideshows/1
        def destroy
          @slideshow.destroy
          redirect_to admin_slideshows_path, notice: 'Slideshow was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_slideshow
            @slideshow = Slideshow.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def slideshow_params
            params.fetch(:slideshow, {}).permit(:name, :height, :width, :image_style)
          end
      end
    end
  end
end
