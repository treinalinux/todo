# frozen_string_literal: true

require 'csv'

module Exportable
  extend ActiveSupport::Concern

  def export_csv
    headers = ['ID', 'Descrição', 'Finalizado', 'ID da tarefa pai', 'Criada em', 'Atualizado em']

    csv = CSV.generate(write_headers: true, headers: headers) do |row|
      Task.all.each do |task|
        row << [task.id, task.description, task.done? ? 'Sim' : 'Não', task.parent_id, task.created_at, task.updated_at]
      end
    end

    send_data csv, type: 'text/csv; charset=utf-8; header=present',
                   disposition: 'attachment; filename=tarefas.csv'
  end
end
