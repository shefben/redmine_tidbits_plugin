# plugins/tid_bits/lib/tid_bits_project_settings_hook.rb
module TidBitsProjectSettingsHook
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_projects_settings_menu, partial: 'projects/settings/tid_bits'
  end
end