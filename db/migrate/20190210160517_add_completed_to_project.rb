class AddCompletedToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :completed, :boolean
  end
end
