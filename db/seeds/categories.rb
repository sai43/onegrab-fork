categories = [
  "Programming",
  "Data Science",
  "Design",
  "Business",
  "Marketing",
  "Personal Development"
]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
  puts "✅ Category created: #{category_name}"
end
puts "🌱 Seeding categories completed!"
