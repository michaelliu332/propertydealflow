ActiveAdmin.register Deal do
  actions :all, :except => [:new, :create ]
  
 sidebar "sampe" do
     index do
 
      column :content

      default_actions
    end
    form do |f|
      f.inputs :content 
      f.buttons
    end
 end
  
end