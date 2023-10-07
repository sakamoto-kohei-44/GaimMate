Rails.application.routes.draw do
  root 'pages#home'
  get 'dashboard/show'
  get 'recipe_suggestions/index'
  get 'recipes/search'
  get 'recipes/search_results'
  get 'users/body_info'
  get 'users/gender_age'
  get 'users/height_weight_target_weight'
  get 'users/activity_level'
  get 'users/allergies'
  get 'users/edit_profile'
  get 'users/update_profile'
  patch 'users/update_profile', to: 'users#update_profile'
  patch 'users/update_account', to: 'users#update_account'
  post 'save_goal', to: 'users#save_goal',as: 'save_goal' #ユーザーが目標（標準体型または細マッチョ）を選択したときに、その情報を保存するためのアクションを実行するためのもの


  # 利用規約とプライバシーポリシー
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'
  # Deviseによる認証関連
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # ユーザー情報関連のルーティング
  resources :users do
    collection do
      get 'body_info'
      get 'gender_age'
      get 'height_weight_target_weight'
      get 'activity_level'
      get 'allergies'
      post 'save_gender_age', to: 'users#save_gender_age', as: 'save_gender_age' #ユーザーの年齢、性別
      post 'users_save_height_weight_target_weight', to: 'users#save_height_weight_target_weight', as: 'save_height_weight_target_weight'
      post 'save_activity_level', to: 'users#save_activity_level', as: 'save_activity_level'
      # マイページ関連
      get 'my_page', to: 'users#edit_profile'      # => /my_page
      # アカウント設定関連
      get 'account_settings', to: 'users#edit_account'      # => /account_settings
    end
    # お気に入りレシピ
    resources :favorites, only: [:index]   # => /users/:user_id/favorites
  end

  # ダッシュボード
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # レシピ関連
  resources :recipes, only: [:index, :show] do
    collection do
      get 'search'  # => /recipes/search
      get 'search_results'  # => /recipes/search_results
    end
  end
end
