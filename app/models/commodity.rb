class Commodity < ActiveRecord::Base
  extend FriendlyId

  include Tire::Model::Search
  include Tire::Model::Callbacks

  friendly_id :code

  belongs_to :heading

  tire do
    mapping do
      indexes :id,                      index: :not_analyzed
      indexes :description,             analyzer: 'snowball'
      indexes :code,                    analyzer: 'snowball'

      indexes :heading do
        indexes :id,                      index: :not_analyzed
        indexes :description,             analyzer: 'snowball'
        indexes :code,                    analyzer: 'snowball'
      end

      indexes :chapter do
        indexes :id,                      index: :not_analyzed
        indexes :description,             analyzer: 'snowball'
        indexes :code,                    analyzer: 'snowball'
      end

      indexes :section do
        indexes :id,                      index: :not_analyzed
        indexes :title,                   analyzer: 'snowball'
        indexes :numeral,                 index: :not_analyzed
      end
    end
  end

  def to_indexed_json
    chapter = heading.chapter
    section = chapter.section

    {
      code: code,
      description: description,
      heading: {
        id: heading.id,
        code: heading.code,
        description: heading.description
      },
      chapter: {
        id: chapter.id,
        code: chapter.code,
        description: chapter.description
      },
      section: {
        id: section.id,
        title: section.title,
        numeral: section.numeral
      }
    }.to_json
  end

  def to_param
    code
  end

  def to_s
    code
  end
end
