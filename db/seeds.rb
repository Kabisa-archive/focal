# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Burndown.delete_all
Metric.delete_all

b = Burndown.create do |b|
  b.name = "Sample Burndown"
  b.pivotal_project_ids = "42"
  b.pivotal_token = "abcdef"
end

10.times do |i|
  Metric.create do |m|
    m.captured_on = i.days.ago.to_date
    m.project_id = 42
    m.iteration_id = 1

    m.unstarted = rand(10)
    m.started = rand(10)
    m.finished = rand(10)
    m.delivered = rand(10)
    m.accepted = rand(10)
    m.rejected = rand(10)
  end
end

puts "Created burndown #{b.id}"