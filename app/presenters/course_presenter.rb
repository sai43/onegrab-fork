class CoursePresenter
  include ActionView::Helpers::NumberHelper

  attr_reader :course

  def initialize(course)
    @course = course
  end

  def title
    course.title.titleize
  end

  def truncated_title
    course.title.truncate(50)
  end

  def description
    course.description.presence || "-"
  end

  def truncated_description
    course.description.present? ? course.description.truncate(80) : ""
  end

  def short_description
    course.short_description.presence || "-"
  end

  def formatted_price
    number_to_currency(course.price || 0, unit: "₹", precision: 0)
  end

  def category_name
    course.category&.name || "Uncategorized"
  end

  def author_name
    course.author&.username || "Unknown"
  end

  def level
    course.level.present? ? course.level.titleize : "-"
  end

  def published_status
    course.published? ? "Yes" : "No"
  end

  def published_at
    course.published_at || "-"
  end

  def duration
    course.duration_minutes.present? ? "#{course.duration_minutes} minutes" : "-"
  end

  def thumbnail_url
    course.thumbnail_url
  end

  def has_thumbnail?
    course.thumbnail_url.present?
  end

  def level_badge_class
    case course.level
    when "beginner"
      "bg-green-100 text-green-700"
    when "intermediate"
      "bg-yellow-100 text-yellow-700"
    when "advanced"
      "bg-red-100 text-red-700"
    else
      "bg-gray-100 text-gray-500"
    end
  end
end
