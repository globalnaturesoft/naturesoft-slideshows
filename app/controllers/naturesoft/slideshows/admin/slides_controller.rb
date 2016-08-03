module Naturesoft
  module Slideshows
    module Admin
      class SlidesController < AdminController
        before_action :set_slide, only: [:show, :edit, :update, :destroy]
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Slides", naturesoft.admin_slides_path
        end
        
        # GET /slides
        def index
          @slides = Naturesoft::Slideshows::Slide.all.paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /slides/1
        def show
        end
    
        # GET /slides/new
        def new
          @slide = Naturesoft::Slideshows::Slide.new
          add_breadcrumb "New slide", naturesoft.new_admin_slide_path
        end
    
        # GET /slides/1/edit
        def edit
          add_breadcrumb @slide.name, naturesoft.new_admin_slide_path
          add_breadcrumb "Edit", nil,  class: "active"
        end
    
        # POST /slides
        def create
          @slide = Naturesoft::Slideshows::Slide.new(slide_params)
          @slide.user = current_user
    
          if @slide.save
            redirect_to admin_slides_path, notice: 'Slide was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /slides/1
        def update
          if @slide.update(slide_params)
            redirect_to admin_slides_path, notice: 'Slide was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /slides/1
        def destroy
          @slide.destroy
          redirect_to admin_slides_path, notice: 'Slide was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_slide
            @slide = Naturesoft::Slideshows::Slide.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def slide_params
            params.fetch(:slide, {}).permit(:name, :description, :image, :slideshow_id)
          end
      end
    end
  end
end
