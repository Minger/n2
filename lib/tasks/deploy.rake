namespace :n2 do
  namespace :deploy do
    desc "This task runs commands after a capistrano deploy"
    task :after do
      Rake::Task['n2:util:compass:compile_css'].invoke
      Rake::Task['n2:widgets:update'].invoke
      Rake::Task['i18n:populate:update_from_rails'].invoke
      Rake::Task['i18n:populate:synchronize_translations'].invoke
    end

    desc "Run misc upgrade scritps after a deploy upgrade"
    task :post_upgrade => :environment do
      #Rake::Task['n2:util:compass:compile_css'].invoke
      #Rake::Task['n2:widgets:update'].invoke
      #Rake::Task['i18n:populate:update_from_rails'].invoke
      #Rake::Task['i18n:populate:synchronize_translations'].invoke
      Rake::Task['db:seed'].invoke
      version = Metadata::Setting.get_setting('version','newscloud').try(:value)
      code_version = File.read(File.join(Rails.root, 'config', 'version'))
    end
  end

  namespace :util do
    namespace :compass do

      desc "Compile Compass css for specific application"
      task :compile_css do
        puts "Compiling Compass css"
        system("`which compass` compile")
      end
    end

  end
end
