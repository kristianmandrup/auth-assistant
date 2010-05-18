module AuthAssist
  module MigrationHelper
    def migration_dir
      File.join(Rails.root, 'db/migrate')          
    end
    
    def reverse_migration(mig_name)
      if migration_exists?(mig_name)
        new_migration = copy_migration(mig_name, "reverse_#{strategy_name}")
        reverse_migration_method_names(new_migration)
      end
    end

    def find_migration(name, &block)    
      FileUtils.cd migration_dir do          
        f = FileList['*.rb'].reject{|f| (f =~ /#{Regexp.escape(name)}/) == nil }.first
        return block.call(f) if block
      end
      f
    end

    def migration_exists?(name)
      find_migration(name)      
    end

    def copy_migration(name, new_name, &block) 
      # create empty new migration
      migration new_name
      new_migration = find_migration(name)          
      find_migration(name) do |mig|
        FileUtils.cp mig, new_migration
      end
      return block.call(new_migration) if block
      new_migration      
    end

    def reverse_migration_methods(new_migration) 
      file_swap_content(new_migration, 'self.up', 'self.down')
    end

    def file_reverse(file, str1, str2) 
      # use thor action          
      file.replace str1, str2
      file.replace str2, str1
    end

  end
end