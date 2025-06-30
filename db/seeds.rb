# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

programming = Category.find_or_create_by(name: 'Programming')
web_dev = Category.find_or_create_by(name: 'Web Development')
author = User.find_by(email: ENV['AUTHOR_EMAIL'])

courses = [
    {
        title: "Introduction to C Programming",
        description: "Learn the fundamentals of C programming language including syntax, data types, and basic algorithms.",
        category: programming
    },
    {
        title: "Python for Beginners",
        description: "Start your programming journey with Python, learning syntax, data structures, and basic projects.",
        category: programming
    },
    {
        title: "Java Fundamentals",
        description: "Get introduced to Java programming language, object-oriented concepts, and core APIs.",
        category: programming
    },
    {
        title: "Ruby on Rails Basics",
        description: "Learn Ruby language fundamentals and get started with Ruby on Rails web development.",
        category: web_dev
    },
    {
        title: "HTML5 | CSS3 | JavaScript Fundamentals",
        description: "Learn the latest features of Web and how to build semantic, accessible web pages.",
        category: web_dev
    }
]

# courses.each do |course_attrs|
#   Course.find_or_create_by(title: course_attrs[:title]) do |course|
#     course.description = course_attrs[:description]
#     course.category = course_attrs[:category]
#     course.author = author
#   end
# end
#
# puts "Seeded #{courses.size} courses."


# db/seeds.rb

students_data = [
    {
        name: "Alice Johnson",
        email: "alice.johnson@example.com",
        phone: "9876543210",
        address: "123 Maple St, Springfield",
        gender: "female",
        dob: Date.new(2005, 5, 14),
        enrollment_date: Date.new(2023, 1, 10),
        status: "active",
        parent_guardian_name: "Mary Johnson",
        emergency_contact: "9876543211",
        progress_status: "in_progress"
    },
    {
        name: "Bob Smith",
        email: "bob.smith@example.com",
        phone: "9123456789",
        address: "456 Oak Ave, Rivertown",
        gender: "male",
        dob: Date.new(2004, 8, 22),
        enrollment_date: Date.new(2022, 9, 1),
        status: "active",
        parent_guardian_name: "John Smith",
        emergency_contact: "9123456790",
        progress_status: "not_started"
    }
]

# students_data.each do |student_attrs|
#   Student.create!(student_attrs)
# end

# Post.create!(
#     [
#         {
#             title: "Getting Started with Ruby on Rails",
#             content: "Ruby on Rails is a powerful web development framework...",
#             excerpt: "An introductory guide to Ruby on Rails.",
#             published_at: 2.days.ago,
#             status: "published",
#             author: author
#         },
#         {
#             title: "Understanding ActiveRecord Associations",
#             content: "ActiveRecord associations simplify working with related models...",
#             excerpt: "Learn about the basics of ActiveRecord associations.",
#             published_at: 1.day.ago,
#             status: "published",
#             author: author
#         }
#     ]
# )

#===========Plans Seed Data===========

# puts "🌱 Seeding Plans..."

plans = [
  {
    name: "Basic",
    slug: "basic",
    description: "Access to beginner-level courses. Perfect for starting your journey.",
    price: 2000,
    currency: "INR",
    interval: "monthly",
    interval_count: 1,
    duration_days: 30,
    active: true
  },
  {
    name: "Pro",
    slug: "pro",
    description: "Access to all courses, including intermediate & advanced levels.",
    price: 5000,
    currency: "INR",
    interval: "monthly",
    interval_count: 1,
    duration_days: 90,
    active: true
  },
  {
    name: "Premium",
    slug: "premium",
    description: "Full access to all content, premium resources, mentorship, and live sessions.",
    price: 12000,
    currency: "INR",
    interval: "monthly",
    interval_count: 1,
    duration_days: 365,
    active: true
  }
]

# plans.each do |plan_data|
#   next if Plan.exists?(slug: plan_data[:slug]) # Check by slug now

#   Plan.create!(plan_data)
#   puts "✅ Created plan: #{plan_data[:name]}"
# end

# puts "✅ Plans seeding complete!"


#=======================================

subscriptions = [
  {
    user: User.find_by(email: "csai@cendyn.com"),
    plan_name: "premium",
    status: "pending",
    payment_method: "cash"
  }
]

# puts "🌱 Seeding Subscriptions..."

# subscriptions.each do |sub_data|
#   plan = Plan.find_by(slug: sub_data[:plan_name])
#   next unless plan && sub_data[:user]

#   unless sub_data[:user].subscription.present?
#     sub_data[:user].create_subscription!(
#       plan: plan,
#       amount: plan.price,
#       currency: plan.currency,
#       status: sub_data[:status],
#       started_at: Time.current,
#       ends_at: Time.current + plan.duration_days.days,
#       payment_method: sub_data[:payment_method]
#     )
#     puts "✅ Created subscription for #{sub_data[:user].email} to #{plan.name}"
#   else
#     puts "⚠️ Subscription already exists for #{sub_data[:user].email}"
#   end
# end

# puts "✅ Subscriptions seeding complete!"


# Course
#   ├── Section
#         ├── Lesson
#               ├── Topic

require_relative './seeds/learning_c_programming'

