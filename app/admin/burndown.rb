ActiveAdmin.register Burndown do

  config.filters = false

  index do
    selectable_column
    column :name
    column() do |burndown|
      link_to 'Force Update', force_update_admin_burndown_path(burndown), method: :put, confirmation: "Are you sure?"
    end
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

  member_action :force_update, method: :put do
    burndown = Burndown.find(params[:id])
    burndown.force_update
    redirect_to :back, notice: "Update performed. Thank you."
  end
end
