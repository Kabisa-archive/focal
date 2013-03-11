FactoryGirl.define do
  sequence(:burndown_name) {|n| "Burndown ##{n}" }

  factory :burndown do
    name                  { generate(:burndown_name) }
    pivotal_token         "pivotal-token"
    pivotal_project_id    42

    factory :burndown_with_metrics do
      ignore do
        iteration_count 1
      end

      after(:create) do |burndown, evaluator|
        evaluator.iteration_count.times do |i|
          FactoryGirl.create(:iteration_with_metrics,
            burndown: burndown,
            number: i + 1,
            start_at: (i*2).weeks.ago,
            finish_at: (i*2).weeks.ago + 2.weeks
          )
        end
      end
    end
  end
end
