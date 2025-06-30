author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_or_create_by(name: "Programming")

raise "Author or category missing!" unless author && category

course = Course.find_or_initialize_by(title: "Python")
course.description = "Master Python programming from the basics to advanced concepts including data structures, OOP, web development, and data analysis."
course.short_description = "Learn Python for versatile software development."
course.price = 2000
course.level = "beginner"
course.duration_minutes = 1200
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/c/c3/Python-logo-notext.svg"
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
    title: "Introduction to Python",
    description: "Start your Python journey with fundamentals and setup.",
    duration: 60,
    lessons: [
      {
        title: "Getting Started",
        duration: 30,
        topics: [
          { title: "What is Python?", content: "Introduction and history of Python.", slug: "what-is-python" },
          { title: "Installing Python", content: "How to install Python on various platforms.", slug: "installing-python" }
        ]
      },
      {
        title: "First Steps",
        duration: 30,
        topics: [
          { title: "Hello World", content: "Write your first Python script.", slug: "hello-world-python" },
          { title: "Using the REPL", content: "Interactive Python shell basics.", slug: "using-repl" }
        ]
      }
    ]
  },
  {
    title: "Python Basics",
    description: "Learn basic syntax, data types, and operators.",
    duration: 150,
    lessons: [
      {
        title: "Variables & Data Types",
        duration: 50,
        topics: [
          { title: "Numbers and strings", content: "Basic types and operations.", slug: "numbers-strings" },
          { title: "Lists and tuples", content: "Working with sequences.", slug: "lists-tuples" }
        ]
      },
      {
        title: "Control Flow",
        duration: 50,
        topics: [
          { title: "If statements", content: "Conditionals in Python.", slug: "if-statements" },
          { title: "Loops", content: "For and while loops.", slug: "loops-python" }
        ]
      },
      {
        title: "Functions",
        duration: 50,
        topics: [
          { title: "Defining functions", content: "Write reusable code blocks.", slug: "defining-functions" },
          { title: "Arguments and return", content: "Function parameters and results.", slug: "arguments-return" }
        ]
      }
    ]
  },
  {
    title: "Data Structures",
    description: "Handle data using dictionaries, sets, and more.",
    duration: 180,
    lessons: [
      {
        title: "Dictionaries & Sets",
        duration: 60,
        topics: [
          { title: "Working with dict", content: "Key-value pairs in Python.", slug: "working-with-dict" },
          { title: "Set basics", content: "Using sets for unique items.", slug: "set-basics" }
        ]
      },
      {
        title: "Advanced Collections",
        duration: 60,
        topics: [
          { title: "Collections module", content: "Specialized containers.", slug: "collections-module" },
          { title: "Defaultdict and Counter", content: "Useful collection tools.", slug: "defaultdict-counter" }
        ]
      },
      {
        title: "Comprehensions",
        duration: 60,
        topics: [
          { title: "List comprehensions", content: "Concise ways to create lists.", slug: "list-comprehensions" },
          { title: "Dict and set comprehensions", content: "Advanced comprehension usage.", slug: "dict-set-comprehensions" }
        ]
      }
    ]
  },
  {
    title: "Object-Oriented Programming",
    description: "Understand classes, inheritance, and OOP concepts.",
    duration: 150,
    lessons: [
      {
        title: "Classes & Objects",
        duration: 75,
        topics: [
          { title: "Defining classes", content: "Build custom types.", slug: "defining-classes" },
          { title: "Instance and class variables", content: "Managing attributes.", slug: "instance-class-vars" }
        ]
      },
      {
        title: "Inheritance & Polymorphism",
        duration: 75,
        topics: [
          { title: "Inheritance basics", content: "Reuse and extend classes.", slug: "inheritance-basics" },
          { title: "Overriding methods", content: "Polymorphic behavior.", slug: "overriding-methods" }
        ]
      }
    ]
  },
  {
    title: "File Handling & Modules",
    description: "Work with files and modularize your code.",
    duration: 150,
    lessons: [
      {
        title: "File Operations",
        duration: 75,
        topics: [
          { title: "Reading files", content: "Open and read data.", slug: "reading-files" },
          { title: "Writing files", content: "Write and append to files.", slug: "writing-files" }
        ]
      },
      {
        title: "Modules & Packages",
        duration: 75,
        topics: [
          { title: "Importing modules", content: "Use built-in and custom modules.", slug: "importing-modules" },
          { title: "Creating packages", content: "Organize your project.", slug: "creating-packages" }
        ]
      }
    ]
  },
  {
    title: "Web Development & Data",
    description: "Build web apps and handle data with Python.",
    duration: 180,
    lessons: [
      {
        title: "Web Frameworks",
        duration: 90,
        topics: [
          { title: "Introduction to Flask", content: "Build lightweight web apps.", slug: "flask-intro" },
          { title: "Introduction to Django", content: "Full-stack web development.", slug: "django-intro" }
        ]
      },
      {
        title: "Data Analysis",
        duration: 90,
        topics: [
          { title: "NumPy basics", content: "Numerical computing essentials.", slug: "numpy-basics" },
          { title: "Pandas introduction", content: "Data manipulation and analysis.", slug: "pandas-intro" }
        ]
      }
    ]
  },
  {
    title: "Testing & Deployment",
    description: "Ensure quality and deploy your Python applications.",
    duration: 150,
    lessons: [
      {
        title: "Testing Python Code",
        duration: 75,
        topics: [
          { title: "Unit testing", content: "Write tests using unittest and pytest.", slug: "unit-testing" },
          { title: "Mocking and fixtures", content: "Advanced testing techniques.", slug: "mocking-fixtures" }
        ]
      },
      {
        title: "Deployment",
        duration: 75,
        topics: [
          { title: "Packaging apps", content: "Prepare apps for distribution.", slug: "packaging-apps" },
          { title: "Deploying to servers", content: "Deploy with Docker and cloud services.", slug: "deploying-servers-python" }
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

puts "✅ Successfully seeded full Python course structure!"
