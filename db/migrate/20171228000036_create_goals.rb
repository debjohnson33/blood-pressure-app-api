class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.belongs_to :user
      t.integer :systolic_bp
      t.integer :diastolic_bp
      t.string :frequency

      t.timestamps
    end
  end
end
