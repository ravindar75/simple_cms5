class SectionsController < ApplicationController


  layout "admin"
  
  before_action :confirm_logged_in

  def index
    @sections = Section.sorted
  end

  def show
     @section  =  Section.find(params[:id])
  end
 
  def new
    @section  = Section.new({:name => 'Default'})
      @section_count = Section.count + 1
    @pages = Page.sorted
  end
  def create
       @section  = Section.new(section_params) 
  
      if  @section .save
        flash[:notice] = "Subject created successfuly"
        redirect_to (sections_path)
      else
         @section_count = Section.count + 1
    @pagess = Page.sorted
        render('new')
      end
  end 

  def edit
      @section  = Section.find(params[:id])
       @section_count = Section.count 
    @pages = Page.sorted
  end
  def update
   @section  = Section.find(params[:id])
  
      if  @section.update_attributes(section_params)
         flash[:notice] = "section updated successfuly"
        redirect_to(sections_path(@subject))
      else
         @section_count = Section.cunt 
    @pages = Page.sorted
        render('edit')
      end 
  end

  def delete
     @section  = Section.find(params[:id])

  end

  def destroy
     @section  = Section.find(params[:id])
     
    @section .destroy
    flash[:notice] = "section '#{@section.name}' destroy successfuly"
    redirect_to(sections_path)

  end
  private

  def section_params
    params.require(:section).permit(:page_id,:name, :position, :visible,:content_type,:content)

    end
end
