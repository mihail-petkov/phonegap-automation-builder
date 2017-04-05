require 'pathname'
require 'zip'

class Phonegap
  USER = 'email@gmail.com'
  ZIP_FILE = 'application.zip'
  APP_ID = '1466977'

  class << self

    def deploy
      remove_existing_archive
      zip
      upload
    end

    def remove_existing_archive
      File.delete(ZIP_FILE) if File.exist?(ZIP_FILE)
    end 

    def zip
      directory = Pathname.new(ARGV.first)
      Zip::File.open(ZIP_FILE, Zip::File::CREATE) do |zipfile|
        Dir[File.join(directory, '**', '**')].each do |file|
          path = Pathname.new(file)
          zipfile.add(path.relative_path_from(directory), file)
        end
      end
    end

    def upload
      Kernel.system "curl -u #{USER} -X PUT -o #{ZIP_FILE} https://build.phonegap.com/api/v1/apps/#{APP_ID}"
    end
  end

end

Phonegap.deploy