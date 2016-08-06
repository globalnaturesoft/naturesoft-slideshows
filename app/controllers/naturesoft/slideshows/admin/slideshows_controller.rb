module Naturesoft
  module Slideshows
    module Admin
      class SlideshowsController < Naturesoft::Admin::AdminController
        before_action :set_slideshow, only: [:show, :edit, :update, :destroy]
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Slideshows", naturesoft_slideshows.admin_slideshows_path
        end
    
        # GET /slideshows
        def index
          @slideshows = Slideshow.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /slideshows/1
        def show
          add_breadcrumb @slideshow.name, naturesoft_slideshows.new_admin_slideshow_path
          add_breadcrumb "Show"
        end
    
        # GET /slideshows/new
        def new
          @slideshow = Slideshow.new
          add_breadcrumb "New slideshow", naturesoft_slideshows.new_admin_slideshow_path
        end
    
        # GET /slideshows/1/edit
        def edit
          add_breadcrumb @slideshow.name, naturesoft_slideshows.new_admin_slideshow_path
          add_breadcrumb "Edit"
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
          render text: 'Slideshow was successfully destroyed.'
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
