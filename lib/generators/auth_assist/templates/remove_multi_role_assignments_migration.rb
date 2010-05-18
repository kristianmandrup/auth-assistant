class CreateMultiRoleAssignments < ActiveRecord::Migration
  def self.down
    create_table :role_assignments do |t|
      t.integer :user_id
      t.integer :role_id
      t.timestamps
    end

    create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    add_column :users, :role_assignment_id, :integer
        
  end

  def self.up
    drop_table :role_assignments
    drop_table :roles
    remove_column :users, :role_assignment_id
  end
  
end
