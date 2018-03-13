class IncomesController < ApplicationController
  before_action :require_login
  # before_action :require_current_budget, only: [:show, :edit, :destroy]

  def index
    @incomes = current_budget.incomes.by_name
  end

  def new
    @income = current_budget.incomes.new
  end

  def create
    @income = current_budget.incomes.create(
      income_params.merge(budget: current_budget),
    )

    respond_with(@income)
  end

  def show
  end

  def edit
  end

  def update
    income.update_attributes(income_params)

    respond_with(income)
  end

  def destroy
    income.delete

    respond_with income, location: -> { incomes_path }
  end

  private

  def income_params
    params.require(:income).permit(:amount, :due_date, :frequency, :name)
  end

  def income
    @income ||= current_budget.incomes.find(params[:id])
  end
  helper_method :income

  def current_budget
    current_user.budget
  end

  # def require_current_budget
  #   unless current_budget.incomes.include?(income.id)
  #     redirect_to budgets_path, alert: I18n.t(
  #       "incomes.flashes.alerts.require_current_budget",
  #     )
  #   end
  # end
end
