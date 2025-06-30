
namespace :courses do
  desc "Update courses with missing required fields"
  task fix_missing_fields: :environment do
    Course.find_each do |course|
      updated = false

      # Add short description if blank
      if course.short_description.blank?
        course.short_description = course.description.truncate(150) rescue "No short description provided."
        updated = true
      end

      # Add status if blank
      if course.status.blank?
        course.status = "Draft"
        updated = true
      end

      # Add slug if blank
      if course.slug.blank?
        course.slug = course.title.parameterize
        updated = true
      end

      if updated
        if course.save
          puts "✅ Updated course: #{course.title}"
        else
          puts "⚠️ Failed to update course: #{course.title} - #{course.errors.full_messages.join(', ')}"
        end
      end
    end

    puts "🎉 Finished updating courses!"
  end
end
