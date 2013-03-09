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
        FactoryGirl.create_list(:iteration_with_metrics, evaluator.iteration_count, burndown: burndown)
      end
    end
  end
end
