# frozen_string_literal: true

require 'administrate/base_dashboard'
# Dashboard for question model
class QuestionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    question: Field::String,
    answer_type: Field::Select.with_options(
      collection: %w[Text Numerical Choice]
    ),
    # view_to_list: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    choice: Field::HasMany
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :question,
    :answer_type
    # :view_to_list,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :question,
    :answer_type,
    # :view_to_list,
    :created_at,
    :updated_at,
    :choice
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :question,
    :answer_type
    # :view_to_list,
  ].freeze

  # Overwrite this method to customize how questions are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(question)
    question.question.to_s
  end
end
