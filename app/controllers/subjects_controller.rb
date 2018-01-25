 class SubjectsController < ApplicationController
   http_basic_authenticate_with name: "ravi", password: "lasya", only: :destroy

      before_action :confirm_logged_in

   layout 'admin'
  
  def index
    logger.debug("*********Testin the logger. ********")
    @subjects = Subject.sorted
    
  end

  def show
    @subject = Subject.find(params[:id])
  end
 
  def new
    @subject = Subject.new({:name => 'Default'})
    @subject_count = Subject.count + 1 

  end
  def create
      @subject = Subject.new(subject_params) 
  
      if @subject.save
        flash[:notice] = "Subject created successfuly"
        redirect_to (subjects_path)
      else
         @subject_count = Subject.count + 1 
        render('new')
      end
  end 

  def edit
     @subject = Subject.find(params[:id])
         @subject_count = Subject.count 
  end
  def update
    @subject = Subject.find(params[:id])
  
      if @subject.update_attributes(subject_params)
         flash[:notice] = "Subject updated successfuly"
        redirect_to(subjects_path(@subject))
      else
         @subject_count = Subject.count 
        render('edit')
      end 
  end

  def delete
    @subject = Subject.find(params[:id])

  end

  def destroy
    @subject = Subject.find(params[:id])
     
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroy successfuly"
    redirect_to(subjects_path)

  end
  private

  def subject_params
    params.require(:subject).permit(:name,:position, :visible, :created_at)

    end
end
