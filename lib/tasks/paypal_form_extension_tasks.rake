namespace :radiant do
  namespace :extensions do
    namespace :paypal_form do
      
      desc "Runs the migration of the Paypal Form extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          PaypalFormExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          PaypalFormExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Paypal Form to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from PaypalFormExtension"
        Dir[PaypalFormExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(PaypalFormExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
