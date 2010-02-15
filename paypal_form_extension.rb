# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class PaypalFormExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/paypal_form"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :paypal_form
  #   end
  # end
  define_routes do |map|
  	map.namespace(:admin) do |admin|
		map.resources :schools, :path_prefix => "/admin"
  		map.resources :price_options, :path_prefix => "/admin"
  	end
  end
  
  def activate
    Page.send :include, PaypalTags
    admin.tabs.add "Schools", "/admin/schools" #, :after => "Layouts", :visibility => [:all]
    admin.tabs.add "Price Options", "/admin/price_options" #, :after => "Layouts"
  end
  
  def deactivate
    # admin.tabs.remove "Paypal Form"
  end
  
end
