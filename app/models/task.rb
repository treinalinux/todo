# frozen_string_literal: true

# class Task < ApplicationRecord
class Task < ApplicationRecord
  validates :description, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :parent, class_name: 'Task', optional: true

  has_many :sub_tasks, class_name: 'Task', foreign_key: :parent_id, dependent: :destroy

  scope :only_parents, -> { where(parent_id: nil) }

  def parent?
    parent_id.nil?
  end

  def sub_task?
    !parent?
  end

  # Voltar na aula:
  # Criando aplicacoes reais - Gerenciador de tarefas (parte 4)
  # O que sera criada a seguir nao e recomendado.
  # O correto seria estar em um decorator
  def symbol
    case status
    when 'pending'  then '»'
    when 'done'     then '✓'
    when 'expired'  then '✕'
    end
  end

  def css_color
    case status
    when 'pending'  then 'primary'
    when 'done'     then 'success'
    when 'expired'  then 'danger'
    end
  end

  private

  def status
    return 'done' if done?

    due_date.past? ? 'expired' : 'pending'
  end
end
