author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_or_create_by(name: "Web Development")

raise "Author or category missing!" unless author && category

course = Course.find_or_initialize_by(title: "Node.js")
course.description = "Learn backend development with Node.js — covering core modules, asynchronous programming, building REST APIs, working with databases, and deploying production-ready apps."
course.short_description = "Master backend development using Node.js."
course.price = 2000
course.level = "intermediate"
course.duration_minutes = 1200
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/d/d9/Node.js_logo.svg"
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
    title: "Introduction to Node.js",
    description: "Understand what Node.js is and why it's popular for server-side development.",
    duration: 60,
    lessons: [
      {
        title: "What is Node.js?",
        duration: 30,
        topics: [
          { title: "History & philosophy", content: "Why Node.js was created and its design principles.", slug: "node-history" },
          { title: "Event-driven architecture", content: "Understand Node's event loop and non-blocking I/O.", slug: "event-driven" }
        ]
      },
      {
        title: "Setting up Node.js",
        duration: 30,
        topics: [
          { title: "Installing Node & npm", content: "Get your development environment ready.", slug: "install-node" },
          { title: "Writing your first script", content: "A simple hello world server.", slug: "first-script" }
        ]
      }
    ]
  },
  {
    title: "Core Modules & Packages",
    description: "Learn the standard modules and package management using npm.",
    duration: 150,
    lessons: [
      {
        title: "Built-in modules",
        duration: 50,
        topics: [
          { title: "fs & path", content: "Work with file systems and paths.", slug: "fs-path" },
          { title: "http & events", content: "Create servers and use event emitters.", slug: "http-events" }
        ]
      },
      {
        title: "npm & packages",
        duration: 50,
        topics: [
          { title: "Package.json", content: "Manage dependencies with npm.", slug: "package-json" },
          { title: "Popular packages", content: "Intro to express, dotenv, and more.", slug: "popular-packages" }
        ]
      },
      {
        title: "Module patterns",
        duration: 50,
        topics: [
          { title: "CommonJS & exports", content: "Organize your code with modules.", slug: "commonjs" },
          { title: "ES6 modules", content: "Use import/export in Node.", slug: "es6-modules-node" }
        ]
      }
    ]
  },
  {
    title: "Building REST APIs",
    description: "Develop scalable APIs using Express and middleware.",
    duration: 200,
    lessons: [
      {
        title: "Express basics",
        duration: 60,
        topics: [
          { title: "Routing", content: "Define routes and handle requests.", slug: "express-routing" },
          { title: "Middleware", content: "Process requests with middleware.", slug: "middleware" }
        ]
      },
      {
        title: "Request & Response",
        duration: 70,
        topics: [
          { title: "Parsing data", content: "Handle JSON and form data.", slug: "parsing-data" },
          { title: "Sending responses", content: "Return proper status and payloads.", slug: "sending-responses" }
        ]
      },
      {
        title: "Authentication & Security",
        duration: 70,
        topics: [
          { title: "JWT authentication", content: "Secure APIs with JSON Web Tokens.", slug: "jwt-auth" },
          { title: "Helmet & CORS", content: "Add security best practices.", slug: "helmet-cors" }
        ]
      }
    ]
  },
  {
    title: "Database Integration",
    description: "Connect Node.js apps with databases like MongoDB and SQL.",
    duration: 200,
    lessons: [
      {
        title: "Using MongoDB",
        duration: 100,
        topics: [
          { title: "Mongoose basics", content: "Define schemas and models.", slug: "mongoose-basics" },
          { title: "CRUD operations", content: "Implement create, read, update, delete.", slug: "crud-mongoose" }
        ]
      },
      {
        title: "Using SQL databases",
        duration: 100,
        topics: [
          { title: "Sequelize basics", content: "ORM concepts with Sequelize.", slug: "sequelize-basics" },
          { title: "Relations & queries", content: "Work with relationships and advanced queries.", slug: "sequelize-relations" }
        ]
      }
    ]
  },
  {
    title: "Deployment & Best Practices",
    description: "Make your app production-ready and learn best practices.",
    duration: 150,
    lessons: [
      {
        title: "Deployment",
        duration: 75,
        topics: [
          { title: "Environment configs", content: "Manage config with dotenv and environments.", slug: "env-configs" },
          { title: "Deploying to cloud", content: "Use services like Heroku or AWS.", slug: "deploy-cloud" }
        ]
      },
      {
        title: "Best Practices",
        duration: 75,
        topics: [
          { title: "Error handling", content: "Centralize and log errors.", slug: "error-handling" },
          { title: "Performance optimization", content: "Optimize for speed and scalability.", slug: "performance-optimization-node" }
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

puts "✅ Successfully seeded full Node.js course structure!"
