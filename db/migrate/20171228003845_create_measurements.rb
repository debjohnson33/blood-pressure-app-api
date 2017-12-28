class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.belongs_to :user
      t.integer :systolic_bp
      t.integer :diastolic_bp
      t.integer :pulse
      t.datetime :date_time
      t.text :notes

      t.timestamps
    end
  end
end
