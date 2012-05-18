class Chapter < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many   :headings
  belongs_to :section

  def short_code
    code.first(2)
  end

  def to_s
    "CHAPTER #{code.first(2)} - #{description}"
  end

  tire do
    mapping do
      indexes :id,           index: :not_analyzed
      indexes :section_id,   index: :not_analyzed # not sure this will be needed yet
      indexes :number
      indexes :description,  analyzer: 'snowball'
    end
  end
end
