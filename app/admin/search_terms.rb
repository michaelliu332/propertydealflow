ActiveAdmin.register SearchTerm do
	actions :all 
before_filter do @skip_sidebar = true end
	index do
 
		column :name 
		column :text
		column :hashtag
		    column "Actions" do |post|
 		      link_to "Edit", "/admin/search_terms/#{post.id}/edit"
	      end
	     
	       
	end
 
  
end
