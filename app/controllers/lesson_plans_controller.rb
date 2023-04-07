class LessonPlansController < ApplicationController

  def new
    @lesson_plan = LessonPlan.new
    @students = current_user.students
  end

  def create
    @lesson_plan = LessonPlan.new(lesson_plan_params)
     if @lesson_plan.save
      flash[:success] = "New Lesson Plan Created"
      redirect_to lesson_plan_path(@lesson_plan)
     else
      flash[:error] = "Couldn't create lesson plan"
      redirect_to new_lesson_plan_path(@lesson_plan)
     end
  end

  def show
    @lesson_plan = LessonPlan.find(params[:id])
  end

  def index
    @lesson_plans = LessonPlan.where(student_id: current_user.students.map(&:id))

    if params[:student_id] 
      @lesson_plans = @lesson_plans.where(student_id: params[:student_id])
    end
  end

  def edit
    @lesson_plan = LessonPlan.find(params[:id])
  end

  def update
    @lesson_plan = LessonPlan.find(params[:id])
    if @lesson_plan.update(lesson_plan_params)
      flash[:success] = "Lesson updated"
      redirect_to lesson_plans_path(student_id: @lesson_plan.student_id)
    else
      redirect_to edit_lesson_plan_path
      flash[:danger] = 'unsuccessful update'
    end
  end

  def destroy
    @lesson_plan = LessonPlan.find(params[:id])
    @lesson_plan.destroy
    flash[:success] = "Lesson deleted"
    redirect_to lesson_plans_path
  end

  private
    def lesson_plan_params
      params.require(:lesson_plan).permit(:title, :body, :student_id)
    end
end
