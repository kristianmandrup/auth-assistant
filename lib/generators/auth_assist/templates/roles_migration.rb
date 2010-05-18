class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :role_assignments
  end
end
