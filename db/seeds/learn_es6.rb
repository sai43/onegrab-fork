author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_or_create_by(name: "Web Programming")

raise "Author or category missing!" unless author && category

course = Course.find_or_initialize_by(title: "ES6 (ECMAScript 6)")
course.description = "Deep dive into ES6 — the major JavaScript update that modernized web development. Learn new syntax, features like arrow functions, classes, modules, destructuring, promises, and more."
course.short_description = "Master modern JavaScript with ES6."
course.price = 1500
course.level = "intermediate"
course.duration_minutes = 800
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png"
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
    title: "Introduction to ES6",
    description: "Overview of ECMAScript 6 and why it matters.",
    duration: 50,
    lessons: [
      {
        title: "What is ES6?",
        duration: 20,
        topics: [
          { title: "History and motivation", content: "Why ES6 was introduced and its goals.", slug: "history-es6" },
          { title: "New possibilities", content: "What ES6 enables that ES5 didn't.", slug: "new-possibilities" }
        ]
      },
      {
        title: "Setup and Compatibility",
        duration: 30,
        topics: [
          { title: "Transpilers (Babel)", content: "Using Babel to write modern code today.", slug: "babel-transpiler" },
          { title: "Browser support", content: "Which browsers support ES6 features.", slug: "browser-support-es6" }
        ]
      }
    ]
  },
  {
    title: "New Syntax Features",
    description: "Simplified and modernized JavaScript syntax.",
    duration: 150,
    lessons: [
      {
        title: "Let & Const",
        duration: 40,
        topics: [
          { title: "Block scoping", content: "Understand block-level scope with let and const.", slug: "block-scope" },
          { title: "Hoisting differences", content: "How hoisting changes for let and const.", slug: "hoisting-let-const" }
        ]
      },
      {
        title: "Arrow Functions",
        duration: 40,
        topics: [
          { title: "Syntax and usage", content: "Concise syntax and benefits.", slug: "arrow-syntax" },
          { title: "Lexical this", content: "How 'this' works differently in arrow functions.", slug: "lexical-this" }
        ]
      },
      {
        title: "Template Literals",
        duration: 30,
        topics: [
          { title: "String interpolation", content: "Embed expressions into strings easily.", slug: "string-interpolation" },
          { title: "Multi-line strings", content: "Write cleaner multi-line code.", slug: "multiline-strings" }
        ]
      },
      {
        title: "Destructuring",
        duration: 40,
        topics: [
          { title: "Object destructuring", content: "Extract object properties into variables.", slug: "object-destructuring" },
          { title: "Array destructuring", content: "Extract values from arrays.", slug: "array-destructuring" }
        ]
      }
    ]
  },
  {
    title: "Advanced ES6 Features",
    description: "Powerful features that change how you structure code.",
    duration: 200,
    lessons: [
      {
        title: "Classes",
        duration: 50,
        topics: [
          { title: "Syntax and inheritance", content: "Simplify prototype-based inheritance.", slug: "classes-syntax" },
          { title: "Static methods", content: "When and how to use static methods.", slug: "static-methods" }
        ]
      },
      {
        title: "Modules",
        duration: 50,
        topics: [
          { title: "Import & export", content: "Break code into reusable pieces.", slug: "import-export" },
          { title: "Default vs named exports", content: "Choose the right export strategy.", slug: "export-strategies" }
        ]
      },
      {
        title: "Promises",
        duration: 50,
        topics: [
          { title: "Creating promises", content: "Basics of creating and using promises.", slug: "creating-promises" },
          { title: "Promise chaining", content: "Manage sequential async tasks.", slug: "promise-chaining" }
        ]
      },
      {
        title: "Iterators & Generators",
        duration: 50,
        topics: [
          { title: "Iterator protocols", content: "Use iterators to traverse collections.", slug: "iterator-protocols" },
          { title: "Generators", content: "Pause and resume function execution.", slug: "generators" }
        ]
      }
    ]
  },
  {
    title: "Project: ES6 in Practice",
    description: "Build a small project using all ES6 features.",
    duration: 150,
    lessons: [
      {
        title: "Project Setup",
        duration: 50,
        topics: [
          { title: "Planning and structure", content: "Design a modular app using ES6 modules.", slug: "project-planning" },
          { title: "Tooling", content: "Use Babel, Webpack, and other modern tools.", slug: "project-tooling" }
        ]
      },
      {
        title: "Implementation",
        duration: 100,
        topics: [
          { title: "Feature development", content: "Add features step by step using ES6 concepts.", slug: "feature-development" },
          { title: "Testing & deployment", content: "Test code and deploy app.", slug: "testing-deployment" }
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

puts "✅ Successfully seeded full ES6 course structure!"
