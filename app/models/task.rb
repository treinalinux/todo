class Task < ApplicationRecord
  validates :description, presence: true
  validates :done, inclusion: { in: [true, false] }

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
