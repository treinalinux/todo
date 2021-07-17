class TasksController < ApplicationController
  include Exportable
  before_action :set_task, only: %i[show edit update destroy]

  # index retorna uma colecao dos registros importantes
  # para essa pagina
  def index
    # O @varivail quer dizer que ela estara disponivel nas views.
    @tasks = Task.only_parents.order(:due_date)
  end

  # new cria um novo registro que depois ira persistir no db com o create.
  def new
    @task = Task.new
  end

  # O edit e o new tem views parecidas
  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Tarefa foi criada com sucesso.'
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Tarefa foi atualizada com sucesso.'
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Tarefa foi removida com sucesso.'
  end

  private

  # set evita a repeticao do codigo nos metodos.
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_date, :done, :parent_id)
  end
end
