# frozen_string_literal: true

# rubocop:disable Metrics/LineLength

require 'administrate/field/base'
# Custom field
class BelongsToCustomField < Administrate::Field::BelongsTo
  def candidate_resources
    associated_class.where(answer_type: 'Choice').order(:question) # add your custom order here
  end

  # tell this field to use the views of the `Field::BeqlongsTo` parent class
  def to_partial_path
    "/fields/belongs_to/#{page}"
  end
end
# rubocop:enable Metrics/LineLength
