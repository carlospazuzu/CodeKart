class LegalAgeValidator < ActiveModel::Validator
  def validate(record)
    unless record.born_at.present? && record.born_at < 18.years.ago
      record.errors.add :born_at, 'Need to be at least 18 years old!'
    end
  end
end
