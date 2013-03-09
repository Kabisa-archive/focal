# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Burndown.delete_all
Iteration.delete_all
Metric.delete_all

b = Burndown.create do |b|
  b.name = "Sample Burndown"
  b.pivotal_project_id = 42
  b.pivotal_token = "abcdef"
end

i = Iteration.create do |i|
  i.burndown = b

  i.pivotal_iteration_id = 43143
  i.number = 1

  i.start_at = 1.week.ago
  i.finish_at = 2.week.from_now
end

[
  [50,  0,  0,  0,  0,  0],
  [42,  8,  0,  0,  0,  0],
  [40,  6,  3,  0,  1,  0],
  [40,  3,  3,  3,  1,  0],
  [32,  6,  1,  7,  4,  0],

  [20,  9,  5,  8,  8,  0],
  [18,  8,  2,  8, 12,  2]
].each_with_index do |metrics, n|

  Metric.create do |m|
    m.captured_on = (1.week.ago + n.days).to_date

    m.iteration_id = i.id

    m.unstarted = metrics[0]
    m.started   = metrics[1]
    m.finished  = metrics[2]
    m.delivered = metrics[3]
    m.accepted  = metrics[4]
    m.rejected  = metrics[5]
  end
end

puts "Created burndown #{b.id}"
