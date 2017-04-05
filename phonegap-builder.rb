require 'pathname'
require 'zip'

class Phonegap
  SOURCE = ARGV[0] || '/path/to/source'
  APP_ID = ARGV[1] || 1111111
  USER = ARGV[2] || 'user@gmail.com'
  ZIP_FILE = ARGV[3] || 'application.zip'

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
      directory = Pathname.new(SOURCE)
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