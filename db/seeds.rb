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
  b.pivotal_project_id = 42
  b.pivotal_token = "abcdef"
end

[
  [50,  0,  0,  0,  0,  0],
  [42,  8,  0,  0,  0,  0],
  [40,  6,  3,  0,  1,  0],
  [40,  3,  3,  3,  1,  0],
  [32,  6,  1,  7,  4,  0],

  [20,  9,  5,  8,  8,  0],
  [18,  8,  2,  8, 12,  2],
  [ 6, 16,  4,  2, 12, 10],
  [ 3,  5,  0, 12, 30,  0],
  [ 0,  1,  0,  0, 48,  1],
].each_with_index do |metrics, i|

  Metric.create do |m|
    m.captured_on = (metrics.size - i).days.ago.to_date
    m.project_id = 42
    m.iteration_id = 1

    m.unstarted = metrics[0]
    m.started   = metrics[1]
    m.finished  = metrics[2]
    m.delivered = metrics[3]
    m.accepted  = metrics[4]
    m.rejected  = metrics[5]
  end
end

puts "Created burndown #{b.id}"
