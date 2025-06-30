author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_or_create_by(name: "Web Programming")

raise "Author or category missing!" unless author && category

course = Course.find_or_initialize_by(title: "JavaScript")
course.description = "Master JavaScript from basics to advanced topics including DOM manipulation, ES6 features, asynchronous programming, and modern frameworks integration."
course.short_description = "Learn JavaScript for modern web development."
course.price = 1800
course.level = "beginner"
course.duration_minutes = 1000
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png"
course.category = category
course.author = author
course.published = true

course.save!

puts "✅ Created course: #{course.title}"

raise "Course creation failed!" unless course.persisted?

sections_data = [
  {
    title: "Introduction to JavaScript",
    description: "Learn what JavaScript is and its role in web development.",
    duration: 60,
    lessons: [
      {
        title: "History & Evolution",
        duration: 20,
        topics: [
          { title: "JavaScript history", content: "Understand how JavaScript evolved.", slug: "js-history" },
          { title: "Role of JavaScript", content: "Why JavaScript is important for the web.", slug: "js-role" }
        ]
      },
      {
        title: "Getting Started",
        duration: 20,
        topics: [
          { title: "Setting up environment", content: "How to set up editors and tools.", slug: "setup-environment" },
          { title: "Hello World script", content: "Write your first JavaScript program.", slug: "hello-world" }
        ]
      },
      {
        title: "JavaScript Basics",
        duration: 20,
        topics: [
          { title: "Syntax & structure", content: "Learn the basic syntax rules.", slug: "syntax-structure" },
          { title: "Variables & types", content: "Understanding var, let, const and types.", slug: "variables-types" }
        ]
      }
    ]
  },
  {
    title: "Core JavaScript Concepts",
    description: "Deep dive into fundamental concepts.",
    duration: 150,
    lessons: [
      {
        title: "Operators & Expressions",
        duration: 30,
        topics: [
          { title: "Arithmetic & logical", content: "Learn about operators and expressions.", slug: "operators-expressions" },
          { title: "Comparison operators", content: "Understand equality and comparisons.", slug: "comparison-operators" }
        ]
      },
      {
        title: "Control Structures",
        duration: 40,
        topics: [
          { title: "If-else & switch", content: "Conditional logic in JavaScript.", slug: "if-else-switch" },
          { title: "Loops", content: "For, while, and do-while loops.", slug: "loops" }
        ]
      },
      {
        title: "Functions",
        duration: 40,
        topics: [
          { title: "Function declarations", content: "Different ways to define functions.", slug: "function-declarations" },
          { title: "Scope & closures", content: "Understanding function scope and closures.", slug: "scope-closures" }
        ]
      },
      {
        title: "Error Handling",
        duration: 40,
        topics: [
          { title: "Try-catch", content: "How to handle errors gracefully.", slug: "try-catch" },
          { title: "Debugging techniques", content: "Tools and methods for debugging.", slug: "debugging" }
        ]
      }
    ]
  },
  {
    title: "Advanced JavaScript",
    description: "Explore modern and powerful JS concepts.",
    duration: 180,
    lessons: [
      {
        title: "Objects & Prototypes",
        duration: 60,
        topics: [
          { title: "Object basics", content: "Creating and using objects.", slug: "object-basics" },
          { title: "Prototype chain", content: "Inheritance and prototypes.", slug: "prototype-chain" }
        ]
      },
      {
        title: "Asynchronous JavaScript",
        duration: 60,
        topics: [
          { title: "Callbacks & promises", content: "Handle async operations with callbacks and promises.", slug: "callbacks-promises" },
          { title: "Async/await", content: "Simplify async code using async/await.", slug: "async-await" }
        ]
      },
      {
        title: "Modules & Tooling",
        duration: 60,
        topics: [
          { title: "ES6 modules", content: "Using import and export.", slug: "es6-modules" },
          { title: "Build tools", content: "Webpack, Babel, and bundling.", slug: "build-tools" }
        ]
      }
    ]
  },
  {
    title: "DOM Manipulation",
    description: "Interact with HTML documents dynamically.",
    duration: 150,
    lessons: [
      {
        title: "Document Object Model",
        duration: 50,
        topics: [
          { title: "DOM tree", content: "Understanding the DOM structure.", slug: "dom-tree" },
          { title: "Selecting elements", content: "Query selectors and traversal.", slug: "selecting-elements" }
        ]
      },
      {
        title: "Events & Handlers",
        duration: 50,
        topics: [
          { title: "Event listeners", content: "Add and remove event listeners.", slug: "event-listeners" },
          { title: "Event propagation", content: "Capture and bubble phases.", slug: "event-propagation" }
        ]
      },
      {
        title: "Modifying DOM",
        duration: 50,
        topics: [
          { title: "Adding & removing elements", content: "Manipulate elements dynamically.", slug: "modify-elements" },
          { title: "Styling via JavaScript", content: "Change styles and classes.", slug: "style-js" }
        ]
      }
    ]
  },
  {
    title: "Project & Best Practices",
    description: "Build a real project and learn coding best practices.",
    duration: 150,
    lessons: [
      {
        title: "Project: Interactive Web App",
        duration: 75,
        topics: [
          { title: "Project setup", content: "Plan and set up your app.", slug: "project-setup" },
          { title: "Feature implementation", content: "Add core app features.", slug: "feature-implementation" }
        ]
      },
      {
        title: "Best Practices",
        duration: 75,
        topics: [
          { title: "Code quality", content: "Write clean and maintainable code.", slug: "code-quality" },
          { title: "Performance & security", content: "Optimize and secure your app.", slug: "performance-security" }
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

puts "✅ Successfully seeded full JavaScript course structure!"
