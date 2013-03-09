ActiveAdmin.register Burndown do

  config.filters = false

  index do
    selectable_column
    column :name
    default_actions
  end

  form do |f|
    f.inputs do
      if f.object.new_record?
        # New form
        f.input :name
        f.input :pivotal_token,
          label: "Pivotal Tracker API Token"
        f.input :pivotal_project_id,
          label: "Pivotal Tracker Project ID"
      else
        # Edit form
        f.input :name
        f.input :pivotal_token,
          label: "Pivotal Tracker API Token"
      end
    end

    f.actions
  end
end
