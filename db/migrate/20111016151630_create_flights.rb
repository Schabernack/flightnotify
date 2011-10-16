class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :flight_number
      t.string :name
      t.string :departure_location
      t.string :arrival_location
      t.datetime :planned_departure
      t.datetime :planned_arrival
      t.datetime :actual_departure
      t.datetime :actual_arrival
      t.timestamp :updated_at
      t.string :departure_terminal
      t.string :arrival_terminal

      t.timestamps
    end
  end
end
