# frozen_string_literal: true

# This controller is for LessonPlan actions
class LessonPlansController < ApplicationController
  def new
    @lesson_plan = LessonPlan.new
    @students = current_user.students
  end

  def create
    @lesson_plan = LessonPlan.new(lesson_plan_params)
    if @lesson_plan.save
      flash[:success] = 'New Lesson Plan Created.'
      redirect_to lesson_plan_path(@lesson_plan)
    else
      flash[:error] = 'Could not create lesson plan.'
      redirect_to new_lesson_plan_path(@lesson_plan)
    end
  end

  def show
    @lesson_plan = LessonPlan.find(params[:id])
    return if current_user.students.include?(@lesson_plan.student)

    @lesson_plan = nil
    flash[:error] = 'Not authorized to view this lesson plan.'
    redirect_to root_path
  end

  def index
    Benchmark.bm do |x|
      x.report('Lesson Plans index query without caching:') do
        cache_key = "user_#{current_user.id}_lesson_plans"
        @lesson_plans = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
          LessonPlan.where(
            student_id: current_user.students.map(&:id)
          ).order(created_at: :desc).to_a
        end

        if params[:student_id].present?
          @lesson_plans = @lesson_plans.select { |lp| lp.student_id == params[:student_id].to_i }
        end

        # return unless params[:student_id]

        # @lesson_plans = @lesson_plans.where(student_id: params[:student_id])
      end
    end
    # unless @lesson_plans.present?
    #   @lesson_plan = nil
    #   flash[:error] = "Not authorized to view these lessons"
    #   redirect_to root_path
    # end
  end

  def edit
    @lesson_plan = LessonPlan.find(params[:id])
    return if current_user.students.include?(@lesson_plan.student)

    @lesson_plan = nil
    flash[:error] = 'Not authorized to edit this lesson plan.'
    redirect_to root_path
  end

  def update
    @lesson_plan = LessonPlan.find(params[:id])
    if current_user.students.include?(@lesson_plan.student) &&
       @lesson_plan.update(lesson_plan_params)
      flash[:success] = 'Lesson updated.'
      redirect_to lesson_plans_path(student_id: @lesson_plan.student_id)
    elsif current_user.students.include?(@lesson_plan.student) &&
          @lesson_plan.update(lesson_plan_params) == false
      redirect_to edit_lesson_plan_path
      flash[:danger] = 'Unsuccessful update.'
    else
      @lesson_plan = nil
      flash[:error] = 'Not authorized to update this lesson plan.'
      redirect_to root_path
    end
  end

  def destroy
    @lesson_plan = LessonPlan.find(params[:id])
    if current_user.students.include?(@lesson_plan.student)
      @lesson_plan.destroy
      flash[:success] = 'Lesson deleted'
      redirect_to lesson_plans_path(student_id: @lesson_plan.student.id)
    else
      @lesson_plan = nil
      flash[:error] = 'Not authorized to delete this lesson plan.'
      redirect_to root_path
    end
  end

  private

  def lesson_plan_params
    params.require(:lesson_plan).permit(:title, :body, :student_id)
  end
end
