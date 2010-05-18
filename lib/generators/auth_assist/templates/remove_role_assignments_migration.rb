class CreateRoleAssignments < ActiveRecord::Migration
  def self.down
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    add_column :users, :role_id, :integer
        
  end

  def self.up
    drop_table :roles
    remove_column :users, :role_id
  end
  
end
