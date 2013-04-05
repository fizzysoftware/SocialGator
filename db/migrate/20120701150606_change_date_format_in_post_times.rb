class ChangeDateFormatInPostTimes < ActiveRecord::Migration
  def up
    change_column :post_times, :time, :string
  end

  def down
    change_column :post_times, :time, :datetime
  end

end
