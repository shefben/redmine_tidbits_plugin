Redmine::Plugin.register :tid_bits do
  permission :manage_tid_bit_tags, { tid_bit_tags: [:index, :new, :create, :edit, :update, :destroy] }, require: :member

  project_module :tid_bits do
    permission :view_tid_bit_tags, { tid_bit_tags: [:index] }
    permission :manage_tid_bit_tags, { tid_bit_tags: [:new, :create, :edit, :update, :destroy] }
  end

  menu :project_menu, :tid_bit_tags, { controller: 'tid_bit_tags', action: 'index' }, caption: 'Tid-Bit Tags', after: :activity, param: :project_id
  menu :admin_menu, :tid_bit_tags, { controller: 'tid_bit_tags', action: 'index' }, caption: 'Tid-Bit Tags'
end