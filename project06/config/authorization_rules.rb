authorization do
  role :guest do
    has_permission_on :games, :to => :index
  end

  role :administrator do
    has_permission_on [:admin_users, :admin_roles, :admin_games], 
      :to => [:index, :show, :edit, :create, :update, :destroy, :new]
    has_permission_on [:members_games, :members_users, :games],
      :to => :index
    has_permission_on :members_users, :to => :show
  end

  role :member do
    has_permission_on :members_games,
      :to => [:index, :show, :create, :new]
    has_permission_on :members_games, :to => [:edit, :update, :destroy] do
        if_attribute :user => is { user }
      end 
    has_permission_on :members_users,
      :to => [:show, :edit, :update, :index]
    has_permission_on :games, :to => :index
  end

end