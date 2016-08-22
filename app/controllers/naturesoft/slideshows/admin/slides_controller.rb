module Naturesoft
  module Slideshows
    module Admin
      class SlidesController < Naturesoft::Admin::AdminController
        before_action :set_slide, only: [:show, :edit, :update, :destroy, :enable, :disable]
        before_action :default_breadcrumb
        helper_method :change 
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Slides", naturesoft_slideshows.admin_slides_path
        end
        
        # GET /slides
        def index
          @slides = Naturesoft::Slideshows::Slide.search(params).paginate(:page => params[:page], :per_page => 1)
        end
    
        # GET /slides/1
        def show
          add_breadcrumb @slide.name, naturesoft_slideshows.new_admin_slide_path
          add_breadcrumb "Show"
        end
    
        # GET /slides/new
        def new
          @slide = Naturesoft::Slideshows::Slide.new
          add_breadcrumb "New slide", naturesoft_slideshows.new_admin_slide_path
        end
    
        # GET /slides/1/edit
        def edit
          add_breadcrumb @slide.name, naturesoft_slideshows.new_admin_slide_path
          add_breadcrumb "Edit"
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
          render text: "Slide was successfully destroyed."
        end
        
        # ENABLE /slides/stutus
        def enable
          @slide.enable
          render text: "Status was sucessfully enabled"
        end
        
        # DISABLE /slides/stutus
        def disable
          @slide.disable
          render text: "Status was sucessfully disabled"
        end
        
        # DELETE /slides/delete?ids=1,2,3
        def delete
          @slides = Slide.where(id: params[:ids].split(","))
          @slides.destroy_all
          render text: 'Slide(s) was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_slide
            @slide = Naturesoft::Slideshows::Slide.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def slide_params
            params.fetch(:slide, {}).permit(:name, :description, :image, :slideshow_id, :status)
          end
      end
    end
  end
end
