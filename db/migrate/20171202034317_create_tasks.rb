class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :contenty

      t.timestamps
    end
  end
end
alter table book change isbn isbn13 varchar(13);
