# plugins/tid_bits/init.rb
require 'redmine'
# require File.expand_path('../lib/tid_bits/project_settings_hook', __FILE__)
require File.expand_path('../lib/tid_bits_project_settings_hook', __FILE__)
Redmine::Plugin.register :tid_bits do
  name 'Tid Bits plugin'
  author 'Your Name'
  description 'This is a plugin for managing tid bits and tid bit tags'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :tid_bits do
    permission :manage_tid_bit_tags, { tid_bit_tags: [:index, :new, :create, :edit, :update, :destroy] }
    permission :view_tid_bits, { tid_bits: [:index, :show] }
    permission :manage_tid_bits, { tid_bits: [:new, :create, :edit, :update, :destroy] }
  end

  menu :project_menu, :tid_bits, { controller: 'tid_bits', action: 'index' }, caption: 'Tid-Bits', after: :activity, param: :project_id
  menu :project_menu, :tid_bit_tags, { controller: 'tid_bit_tags', action: 'index' }, caption: 'Tags', after: :tid_bits, param: :project_id

  Rails.configuration.to_prepare do
    ProjectsHelper.module_eval do
      def project_settings_tabs
        tabs = super
        tabs << {
          name: 'tid_bit_tags',
          action: :manage_tid_bit_tags,
          partial: 'projects/settings/tid_bit_tags',
          label: :label_tid_bit_tags
        }
        tabs << {
          name: 'tid_bits',
          action: :view_tid_bits,
          partial: 'projects/settings/tid_bits',
          label: :label_tid_bits
        }
        tabs
      end
    end
  end
end