# -*- coding: utf-8 -*-
# RailsAdmin config file. Generated on August 18, 2012 05:17
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Trpg Rolling', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # Mass assignments protection
  config.attr_accessible_role do
    :admin
  end

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Comment, GameSystem, Message, Room, Session, User, World]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Comment, GameSystem, Message, Room, Session, User, World]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Comment do
  #   # Found associations:
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :body, :text 
  #     configure :user_id, :bson_object_id         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model GameSystem do
  #   # Found associations:
  #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :name, :string 
  #     configure :description, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Message do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :room, :belongs_to_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :body, :text 
  #     configure :supplement, :text 
  #     configure :dice, :serialized 
  #     configure :alias, :serialized 
  #     configure :user_id, :bson_object_id         # Hidden 
  #     configure :room_id, :bson_object_id         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Room do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :roomable, :polymorphic_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :deleted_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :title, :string 
  #     configure :description, :text 
  #     configure :static, :boolean 
  #     configure :closed, :boolean 
  #     configure :closed_at, :datetime 
  #     configure :user_id, :bson_object_id         # Hidden 
  #     configure :roomable_type, :text         # Hidden 
  #     configure :roomable_field, :string         # Hidden 
  #     configure :roomable_id, :bson_object_id         # Hidden   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Session do
  #   # Found associations:
  #     configure :world, :belongs_to_association 
  #     configure :game_master, :belongs_to_association 
  #     configure :rooms, :has_many_association 
  #     configure :comments, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :world_id, :bson_object_id         # Hidden 
  #     configure :game_master_id, :bson_object_id         # Hidden 
  #     configure :title, :string 
  #     configure :description, :text 
  #     configure :started_at, :datetime 
  #     configure :finished_at, :datetime 
  #     configure :guidelines, :text 
  #     configure :open, :boolean 
  #     configure :published, :boolean 
  #     configure :finished, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :rooms, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :email, :text 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :text         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :text 
  #     configure :last_sign_in_ip, :text 
  #     configure :authentication_token, :text 
  #     configure :name, :string 
  #     configure :role, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model World do
  #   # Found associations:
  #     configure :owner, :belongs_to_association 
  #     configure :game_system, :belongs_to_association 
  #     configure :rooms, :has_many_association 
  #     configure :sessions, :has_many_association   #   # Found columns:
  #     configure :_type, :text         # Hidden 
  #     configure :_id, :bson_object_id 
  #     configure :deleted_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :owner_id, :bson_object_id         # Hidden 
  #     configure :game_system_id, :bson_object_id         # Hidden 
  #     configure :name, :string 
  #     configure :description, :text 
  #     configure :open, :boolean 
  #     configure :latest_session_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
