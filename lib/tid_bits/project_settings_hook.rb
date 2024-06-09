# plugins/tid_bits/lib/tid_bits/project_settings_hook.rb
module TidBits
  class ProjectSettingsHook < Redmine::Hook::ViewListener
    render_on :view_projects_show_left, partial: 'projects/settings/tid_bit_tags'
    render_on :view_projects_show_left, partial: 'projects/settings/tid_bits'
  end
end