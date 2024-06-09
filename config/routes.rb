RedmineApp::Application.routes.draw do
  resources :projects do
    resources :tid_bits do
      resources :tidbit_comments, only: [:create]
    end
    resources :tid_bit_tags, except: [:show]
  end

  match 'projects/:id/settings/tid_bit_tags', to: 'tid_bit_tags#index', via: [:get, :post], as: 'project_settings_tid_bit_tags'
end