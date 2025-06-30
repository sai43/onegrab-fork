author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_or_create_by(name: "Web Development")

raise "Author or category missing!" unless author && category

course = Course.find_or_initialize_by(title: "React")
course.description = "Master building dynamic user interfaces with React — learn JSX, components, hooks, state management, routing, and modern best practices."
course.short_description = "Build modern front-end apps with React."
course.price = 2200
course.level = "intermediate"
course.duration_minutes = 1200
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/a/a7/React-icon.svg"
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
    title: "Getting Started with React",
    description: "Introduction to React and setting up the environment.",
    duration: 60,
    lessons: [
      {
        title: "Introduction & Setup",
        duration: 30,
        topics: [
          { title: "What is React?", content: "Understand React's core concepts and ecosystem.", slug: "what-is-react" },
          { title: "Setting up the environment", content: "Create React App and tooling.", slug: "setup-environment-react" }
        ]
      },
      {
        title: "JSX & Rendering",
        duration: 30,
        topics: [
          { title: "JSX syntax", content: "Write UI with JSX.", slug: "jsx-syntax" },
          { title: "Rendering elements", content: "Learn how React renders components.", slug: "rendering-elements" }
        ]
      }
    ]
  },
  {
    title: "Components & Props",
    description: "Learn to build reusable UI components.",
    duration: 150,
    lessons: [
      {
        title: "Functional Components",
        duration: 50,
        topics: [
          { title: "Creating components", content: "Build simple and reusable components.", slug: "creating-components" },
          { title: "Passing props", content: "Customize components using props.", slug: "passing-props" }
        ]
      },
      {
        title: "Class Components",
        duration: 50,
        topics: [
          { title: "Understanding classes", content: "Build components using ES6 classes.", slug: "class-components" },
          { title: "Lifecycle methods", content: "Manage component lifecycle.", slug: "lifecycle-methods" }
        ]
      },
      {
        title: "Composition & Children",
        duration: 50,
        topics: [
          { title: "Component composition", content: "Combine components effectively.", slug: "component-composition" },
          { title: "Using children", content: "Pass children and render nested elements.", slug: "using-children" }
        ]
      }
    ]
  },
  {
    title: "State & Hooks",
    description: "Manage dynamic data and side effects.",
    duration: 180,
    lessons: [
      {
        title: "State Management Basics",
        duration: 60,
        topics: [
          { title: "useState hook", content: "Manage local component state.", slug: "use-state" },
          { title: "Updating state", content: "Handle state changes properly.", slug: "updating-state" }
        ]
      },
      {
        title: "Effect Hook",
        duration: 60,
        topics: [
          { title: "useEffect basics", content: "Perform side effects in components.", slug: "use-effect" },
          { title: "Cleanup and dependencies", content: "Control effect execution.", slug: "effect-cleanup" }
        ]
      },
      {
        title: "Advanced Hooks",
        duration: 60,
        topics: [
          { title: "useRef & useMemo", content: "Optimize and reference elements.", slug: "use-ref-memo" },
          { title: "Custom hooks", content: "Reuse logic with custom hooks.", slug: "custom-hooks" }
        ]
      }
    ]
  },
  {
    title: "Routing & Forms",
    description: "Add navigation and build interactive forms.",
    duration: 150,
    lessons: [
      {
        title: "React Router",
        duration: 75,
        topics: [
          { title: "Setting up routes", content: "Create multiple pages with routing.", slug: "setting-up-routes" },
          { title: "Nested & dynamic routes", content: "Advanced routing patterns.", slug: "nested-routes" }
        ]
      },
      {
        title: "Handling Forms",
        duration: 75,
        topics: [
          { title: "Controlled components", content: "Manage form state in React.", slug: "controlled-components" },
          { title: "Validation", content: "Validate form inputs.", slug: "form-validation-react" }
        ]
      }
    ]
  },
  {
    title: "State Management & Context",
    description: "Manage global app state with Context API and beyond.",
    duration: 150,
    lessons: [
      {
        title: "Context API",
        duration: 75,
        topics: [
          { title: "Creating context", content: "Provide and consume app-wide data.", slug: "creating-context" },
          { title: "Context vs props", content: "When to use context vs props.", slug: "context-vs-props" }
        ]
      },
      {
        title: "External State Management",
        duration: 75,
        topics: [
          { title: "Redux basics", content: "Centralized state with Redux.", slug: "redux-basics" },
          { title: "Redux toolkit", content: "Simplify Redux with modern tools.", slug: "redux-toolkit" }
        ]
      }
    ]
  },
  {
    title: "Testing & Deployment",
    description: "Write tests and deploy your React apps.",
    duration: 150,
    lessons: [
      {
        title: "Testing React Apps",
        duration: 75,
        topics: [
          { title: "Unit tests", content: "Test components and logic.", slug: "unit-tests" },
          { title: "Integration tests", content: "Test app flows.", slug: "integration-tests" }
        ]
      },
      {
        title: "Deployment",
        duration: 75,
        topics: [
          { title: "Build & optimize", content: "Prepare your app for production.", slug: "build-optimize" },
          { title: "Deploying to cloud", content: "Publish apps to Vercel, Netlify, or AWS.", slug: "deploy-cloud-react" }
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

puts "✅ Successfully seeded full React course structure!"
