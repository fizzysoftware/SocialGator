desc "Cleanup Raw Data"
task :cleanup_raw_data => :environment do
  Raw_Data.destroy_all
end

