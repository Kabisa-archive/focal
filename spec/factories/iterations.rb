FactoryGirl.define do
  sequence(:iteration_number) {|n| n }

  factory :iteration do
    burndown

    pivotal_iteration_id  123123
    number  { generate(:iteration_number) }

    start_at   { 1.week.ago }
    finish_at  { 1.week.from_now }

    factory :iteration_with_metrics do
      ignore do
        metrics_count 3
      end

      after(:create) do |iteration, evaluator|
        evaluator.metrics_count.times do |i|
          FactoryGirl.create(:metric, captured_on: iteration.start_at + i.days, iteration: iteration)
        end
      end
    end
  end
end