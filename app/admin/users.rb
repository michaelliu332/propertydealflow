ActiveAdmin.register User do
    actions :all, :except => [:new, :create]
    
    member_action :block do
      user = User.find(params[:id])
      user.active = !user.active 
      user.save
      redirect_to :action => :index
    end
    
    index do
      id_column
      column :active, lambda{|u| u.active?? status_tag('YES', :ok) : status_tag('NO', :error)}
      column :name
      column :twitter, lambda{|u| link_to("@#{u.nickname}", "http://twitter.com/#{u.nickname}", :target => '_blank') unless u.nickname.blank?}
      column :created_at
      column :updated_at
      column() do |u|
        link_to u.active?? 'Block' : 'Unblock', block_admin_user_path(u)
      end
      default_actions
    end
    form do |f|
      f.inputs :name, :nickname, :uid
      f.buttons
    end
    filter :name
    filter :nickname
    filter :created_at
    filter :updated_at
    
    
    
 

    
    
    
    
    
end

 