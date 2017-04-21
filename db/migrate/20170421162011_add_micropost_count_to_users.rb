class AddMicropostCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :microposts_count, :integer, default: 0
    User.reset_column_information
    User.all.each do |p|
      User.update_counters p.id, microposts_count: p.microposts.length
    end
  end
end
