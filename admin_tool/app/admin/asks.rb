ActiveAdmin.register Ask do
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
    ask = model.find_or_initialize_by(question: hash[:question], answer: hash[:answer])
    ask.prepare_save!
    ask.save!
  end
end
