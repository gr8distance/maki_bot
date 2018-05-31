require 'csv'
require 'pry'
require 'activerecord-import'

class CSV::AllImporter
  class << self
    def execute()
      puts all_csv
      puts '从廿_廿从 < インポートヲハジメルワヨ！'
      all_csv.each do |csv_path|
        klass = klass(by: csv_path)
        klass.transaction do
          klass.delete_all
          csv_header, csv_data = load_csv(csv_path)
          instances = csv_data.map do |data|
            build_privacy_policy(klass: klass, data: data, header: csv_header)
          end
          instances.each(&:prepare_save!)
          klass.import!(instances)
          puts "从廿_廿从 < #{klass}"
        end
      end
      puts '从廿_廿从 < 終ッタワヨ！'
    end

    private

    def klass(by:)
      file_name = File.basename(by, '.*')
      file_name.singularize.camelize.constantize
    end

    def build_privacy_policy(klass:, data:, header:)
      data_with_title = header.zip(data).to_h
      klass.new(data_with_title)
    end

    def load_csv(path)
      csv = CSV.read(path, encoding: 'UTF-8')
      header = csv[0].map(&:to_sym)
      body = csv.drop(1)
      [header, body]
    end

    def all_csv
      Dir.glob("#{csv_path}/*").select do |file|
        file.match(/\.csv/)
      end
    end

    def csv_path
      'csv/'
    end
  end
end
