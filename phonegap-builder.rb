require 'pathname'
require 'zip'

class Phonegap
  USER = 'email@abv.bg'
  ZIP_FILE = 'application.zip'
  APP_ID = '1466977'

  class << self
    def deploy
      zip
      upload
    end

    def zip
      directory = Pathname.new(ARGV.first)
      File.delete(ZIP_FILE) if File.exist?(ZIP_FILE)
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