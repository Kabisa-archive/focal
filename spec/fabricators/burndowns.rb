Fabricator(:burndown) do
  name { sequence     { |i| "Burndown #{i}" } }
  pivotal_token       "pivotal-token"
  pivotal_project_id  42
end

Fabricator(:burndown_with_metrics, from: :burndown) do
  after_create do |burndown|
    3.times do |i|
      Fabricate(:metric, project_id: burndown.pivotal_project_id, captured_on: (Time.now.utc + i.days).to_date)
    end
  end
end
