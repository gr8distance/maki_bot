ActiveAdmin.register Serif do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  active_admin_importable do |model, hash|
    model.create(id: hash[:id], text: hash[:text], tag_id: hash[:tag_id], weight: hash[:weight])
  end
end
