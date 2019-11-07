# frozen_string_literal: true

require 'administrate/base_dashboard'
# Dashboard for employee model
class EmployeeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    role: Field::Select.with_options(
      collection: %w[Employee Admin]
    ),
    password: Field::Password,
    password_confirmation: Field::Password,
    created_at: Field::DateTime,
    profile_picture: CarrierwaveField,
    material: Field::HasMany
    # material: Field::HasMany.with_options(show: %i[name material_type])
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    profile_picture
    name
    email
    role
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    # :id,
    :profile_picture,
    :name,
    :email,
    :role,
    # :created_at,
    :material
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    profile_picture
    email
    name
    role
    password
    password_confirmation
  ].freeze

  # Overwrite this method to customize how employees are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(employee)
    employee.name.to_s
  end
end
