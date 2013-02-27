namespace :focal do

  desc "Perform daily metrics import for all projects"
  task import: :environment do
    Metric.import_all    
  end
end
