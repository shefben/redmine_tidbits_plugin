# plugins/tid_bits/config/initializers/project_settings_tab.rb
require 'redmine'
require_dependency 'project_settings_hook'

Redmine::Plugin.register :tid_bits do
  name 'Tid Bits plugin'
  author 'Your Name'
  description 'This is a plugin for managing tid bits tags'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :tid_bits do
    permission :manage_tid_bit_tags, { tid_bit_tags: [:index, :new, :create, :edit, :update, :destroy] }
  end

  menu :project_menu, :tid_bit_tags, { controller: 'tid_bit_tags', action: 'index' }, caption: 'Tags', after: :activity, param: :project_id

  Redmine::AccessControl.map do |map|
    map.permission :manage_tid_bit_tags, { tid_bit_tags: [:index, :new, :create, :edit, :update, :destroy] }, require: :member
  end

  Rails.configuration.to_prepare do
    require_dependency 'projects_helper'
    ProjectsHelper.module_eval do
      def project_settings_tabs
        tabs = super
        tabs << {
          name: 'tid_bit_tags',
          action: :manage_tid_bit_tags,
          partial: 'projects/settings/tid_bit_tags',
          label: :label_tid_bit_tags
        }
        tabs
      end
    end
  end
end