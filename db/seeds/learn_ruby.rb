author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_or_create_by(name: "Programming")

raise "Author or category missing!" unless author && category

course = Course.find_or_initialize_by(title: "Ruby")
course.description = "Master the Ruby programming language from its elegant syntax to advanced topics including OOP, metaprogramming, and building CLI tools."
course.short_description = "Learn Ruby for general-purpose and web development."
course.price = 1800
course.level = "beginner"
course.duration_minutes = 1000
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/7/73/Ruby_logo.svg"
course.category = category
course.author = author
course.published = true

begin
  course.save!
  puts "✅ Created or updated course: #{course.title}"
rescue ActiveRecord::RecordInvalid => e
  puts "❌ Course save failed: #{e.record.errors.full_messages.join(", ")}"
  raise
end

raise "Course creation failed!" unless course.persisted?

sections_data = [
  {
    title: "Introduction to Ruby",
    description: "Get started with Ruby and understand its philosophy.",
    duration: 60,
    lessons: [
      {
        title: "History & Philosophy",
        duration: 30,
        topics: [
          { title: "Origins of Ruby", content: "Learn how Ruby was created and why.", slug: "origins-of-ruby" },
          { title: "Ruby's principles", content: "Focus on simplicity and productivity.", slug: "rubys-principles" }
        ]
      },
      {
        title: "Setup & Basics",
        duration: 30,
        topics: [
          { title: "Installing Ruby", content: "Install Ruby on your system.", slug: "installing-ruby" },
          { title: "First script", content: "Write and run your first Ruby program.", slug: "first-script-ruby" }
        ]
      }
    ]
  },
  {
    title: "Ruby Basics",
    description: "Learn the core syntax and foundational concepts.",
    duration: 120,
    lessons: [
      {
        title: "Variables & Data Types",
        duration: 40,
        topics: [
          { title: "Numbers and strings", content: "Work with basic data types.", slug: "numbers-strings-ruby" },
          { title: "Arrays and hashes", content: "Use collections effectively.", slug: "arrays-hashes" }
        ]
      },
      {
        title: "Control Flow",
        duration: 40,
        topics: [
          { title: "Conditionals", content: "if, else, and case statements.", slug: "conditionals-ruby" },
          { title: "Loops", content: "while, until, for loops.", slug: "loops-ruby" }
        ]
      },
      {
        title: "Methods",
        duration: 40,
        topics: [
          { title: "Defining methods", content: "Encapsulate reusable logic.", slug: "defining-methods-ruby" },
          { title: "Arguments & blocks", content: "Work with parameters and blocks.", slug: "arguments-blocks-ruby" }
        ]
      }
    ]
  },
  {
    title: "Object-Oriented Ruby",
    description: "Dive into Ruby’s powerful OOP features.",
    duration: 180,
    lessons: [
      {
        title: "Classes & Objects",
        duration: 60,
        topics: [
          { title: "Creating classes", content: "Define your own objects.", slug: "creating-classes-ruby" },
          { title: "Instance variables & methods", content: "Manage state and behavior.", slug: "instance-vars-methods-ruby" }
        ]
      },
      {
        title: "Inheritance & Modules",
        duration: 60,
        topics: [
          { title: "Inheritance basics", content: "Share and extend behavior.", slug: "inheritance-basics-ruby" },
          { title: "Mixins with modules", content: "Compose functionality.", slug: "mixins-modules-ruby" }
        ]
      },
      {
        title: "Metaprogramming",
        duration: 60,
        topics: [
          { title: "Dynamic methods", content: "Define methods on the fly.", slug: "dynamic-methods-ruby" },
          { title: "method_missing & hooks", content: "Intercept method calls.", slug: "method-missing-hooks-ruby" }
        ]
      }
    ]
  },
  {
    title: "Working with Files & Gems",
    description: "Handle files and extend Ruby with gems.",
    duration: 150,
    lessons: [
      {
        title: "File Handling",
        duration: 75,
        topics: [
          { title: "Reading and writing files", content: "Basic file I/O operations.", slug: "file-io" },
          { title: "Working with CSV and JSON", content: "Parse structured data formats.", slug: "csv-json" }
        ]
      },
      {
        title: "RubyGems & Bundler",
        duration: 75,
        topics: [
          { title: "Using gems", content: "Install and use Ruby libraries.", slug: "using-gems-ruby" },
          { title: "Managing dependencies", content: "Bundle and manage gem dependencies.", slug: "managing-dependencies-ruby" }
        ]
      }
    ]
  },
  {
    title: "Testing & Best Practices",
    description: "Write reliable code and follow Ruby conventions.",
    duration: 150,
    lessons: [
      {
        title: "Testing with RSpec",
        duration: 75,
        topics: [
          { title: "RSpec basics", content: "Write your first tests.", slug: "rspec-basics-ruby" },
          { title: "Mocks and stubs", content: "Mock behavior in tests.", slug: "mocks-stubs-ruby" }
        ]
      },
      {
        title: "Code Style & Maintenance",
        duration: 75,
        topics: [
          { title: "Ruby style guide", content: "Follow community standards.", slug: "ruby-style-guide-ruby" },
          { title: "Refactoring techniques", content: "Improve existing code.", slug: "refactoring-ruby" }
        ]
      }
    ]
  },
  {
    title: "Building CLI Tools",
    description: "Create powerful command-line tools using Ruby.",
    duration: 150,
    lessons: [
      {
        title: "Introduction to CLI",
        duration: 75,
        topics: [
          { title: "ARGV & OptionParser", content: "Handle command-line arguments.", slug: "argv-optionparser-ruby" },
          { title: "Interactive prompts", content: "Make your CLI interactive.", slug: "interactive-prompts-ruby" }
        ]
      },
      {
        title: "Packaging CLI Apps",
        duration: 75,
        topics: [
          { title: "Executable scripts", content: "Distribute your CLI apps.", slug: "executable-scripts-ruby" },
          { title: "Gem packaging", content: "Package CLI tools as gems.", slug: "gem-packaging-ruby" }
        ]
      }
    ]
  }
]

sections_data.each_with_index do |section_data, s_idx|
  section = course.sections.where(title: section_data[:title]).first_or_initialize
  section.description = section_data[:description]
  section.duration = section_data[:duration]
  section.position = s_idx + 1
  section.save!

  section_data[:lessons].each_with_index do |lesson_data, l_idx|
    lesson = section.lessons.where(title: lesson_data[:title]).first_or_initialize
    lesson.duration = lesson_data[:duration]
    lesson.position = l_idx + 1
    lesson.save!

    lesson_data[:topics].each_with_index do |topic_data, t_idx|
      topic = lesson.topics.where(slug: topic_data[:slug]).first_or_initialize
      topic.title = topic_data[:title]
      topic.content = topic_data[:content]
      topic.position = t_idx + 1
      topic.save!
    end
  end
end

puts "✅ Successfully seeded full Ruby course structure!"
