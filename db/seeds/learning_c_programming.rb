author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_by(name: "Programming")

raise "Author or category missing!" unless author && category


course = Course.find_or_create_by!(title: "Learning C Programming")

course.description = "Comprehensive course covering C language fundamentals, control flow, functions, pointers, file handling, and more. Includes practical projects and exercises."
course.short_description = "Master C programming from basics to advanced topics."
course.price = 2000
course.level = "beginner"
course.duration_minutes = 1200
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/C_Programming_Language.svg/926px-C_Programming_Language.svg.png"
course.category = category
course.author = author
course.published = true

course.save!


puts "✅ Created course: #{course.title}"

raise "Course creation failed!" unless course.persisted?

sections_data = [
  {
    title: "Introduction to C",
    description: "History, structure, compilation process, and syntax.",
    duration: 60,
    lessons: [
      {
        title: "History and Evolution",
        duration: 15,
        topics: [
          { title: "Overview of C language", content: "Learn how C evolved and its significance.", slug: "overview-of-c" },
          { title: "Milestones in C history", content: "Understand key milestones and versions.", slug: "milestones-in-c" }
        ]
      },
      {
        title: "Basic Syntax & Structure",
        duration: 20,
        topics: [
          { title: "C Program Structure", content: "Study preprocessor directives, main function, etc.", slug: "c-program-structure" },
          { title: "Comments and style", content: "Learn to use comments and maintain good code style.", slug: "comments-and-style" }
        ]
      },
      {
        title: "Compilation & Execution",
        duration: 25,
        topics: [
          { title: "Compilation process", content: "From source code to executable.", slug: "compilation-process" },
          { title: "Running your first C program", content: "Write and run your first C program.", slug: "running-c-program" }
        ]
      }
    ]
  },
  {
    title: "Fundamentals of C Programming",
    description: "Variables, data types, operators, and I/O.",
    duration: 120,
    lessons: [
      {
        title: "Variables & Data Types",
        duration: 30,
        topics: [
          { title: "Primitive data types", content: "Learn about int, float, char, etc.", slug: "primitive-data-types" },
          { title: "Type casting", content: "Convert between different data types.", slug: "type-casting" }
        ]
      },
      {
        title: "Operators & Expressions",
        duration: 30,
        topics: [
          { title: "Arithmetic and logical operators", content: "Understand how to perform operations.", slug: "arithmetic-operators" },
          { title: "Precedence & associativity", content: "Operator priority rules.", slug: "operator-precedence" }
        ]
      },
      {
        title: "Input & Output",
        duration: 30,
        topics: [
          { title: "Using scanf and printf", content: "Handle user input and print output.", slug: "scanf-printf" },
          { title: "Escape sequences", content: "Formatting output properly.", slug: "escape-sequences" }
        ]
      }
    ]
  },
  {
    title: "Control Flow",
    description: "Conditionals, loops, break & continue.",
    duration: 120,
    lessons: [
      {
        title: "Conditional Statements",
        duration: 40,
        topics: [
          { title: "if, else if, else", content: "Basic condition checking.", slug: "if-else-statements" },
          { title: "Switch statements", content: "Handling multiple conditions.", slug: "switch-statements" }
        ]
      },
      {
        title: "Loops",
        duration: 50,
        topics: [
          { title: "For loop", content: "Iterate using for loop.", slug: "for-loop" },
          { title: "While & do-while", content: "Other loop structures.", slug: "while-do-while" }
        ]
      },
      {
        title: "Break & Continue",
        duration: 30,
        topics: [
          { title: "Using break", content: "Exit loops early.", slug: "break-statement" },
          { title: "Using continue", content: "Skip current iteration.", slug: "continue-statement" }
        ]
      }
    ]
  },
  {
    title: "Functions & Modular Programming",
    description: "Functions, recursion, storage classes.",
    duration: 150,
    lessons: [
      {
        title: "Function Basics",
        duration: 50,
        topics: [
          { title: "Declaration & definition", content: "Define and declare functions.", slug: "function-declaration" },
          { title: "Parameter passing", content: "Pass arguments and return values.", slug: "parameter-passing" }
        ]
      },
      {
        title: "Recursion",
        duration: 30,
        topics: [
          { title: "Concept & examples", content: "Understand recursive functions.", slug: "recursion-examples" }
        ]
      },
      {
        title: "Storage Classes",
        duration: 20,
        topics: [
          { title: "auto, static, extern", content: "Scope and lifetime of variables.", slug: "storage-classes" }
        ]
      }
    ]
  },
  {
    title: "Arrays, Strings & Pointers",
    description: "Advanced data handling and memory.",
    duration: 180,
    lessons: [
      {
        title: "Arrays",
        duration: 60,
        topics: [
          { title: "1D and 2D arrays", content: "Learn about single and multi-dimensional arrays.", slug: "arrays" },
          { title: "Array operations", content: "Sorting and manipulating arrays.", slug: "array-operations" }
        ]
      },
      {
        title: "Strings",
        duration: 60,
        topics: [
          { title: "String basics", content: "Strings as char arrays.", slug: "string-basics" },
          { title: "String functions", content: "Common library functions.", slug: "string-functions" }
        ]
      },
      {
        title: "Pointers",
        duration: 60,
        topics: [
          { title: "Pointer basics", content: "Syntax and basics.", slug: "pointer-basics" },
          { title: "Dynamic memory", content: "malloc, calloc, free.", slug: "dynamic-memory" }
        ]
      }
    ]
  },
  {
    title: "Structures, Unions & File Handling",
    description: "Complex data types and file operations.",
    duration: 150,
    lessons: [
      {
        title: "Structures & Unions",
        duration: 60,
        topics: [
          { title: "Defining structures", content: "Group different data types.", slug: "defining-structures" },
          { title: "Pointers to structures", content: "Work with structures via pointers.", slug: "pointers-structures" },
          { title: "Using unions", content: "Save memory using unions.", slug: "using-unions" }
        ]
      },
      {
        title: "File Handling",
        duration: 90,
        topics: [
          { title: "Reading & writing files", content: "Open, read, write files.", slug: "file-read-write" },
          { title: "Error handling", content: "Handle file errors gracefully.", slug: "file-error-handling" }
        ]
      }
    ]
  },
  {
    title: "Projects & Advanced Topics in C",
    description: "Apply your knowledge through projects.",
    duration: 120,
    lessons: [
      {
        title: "Mini Projects in C",
        duration: 60,
        topics: [
          { title: "Calculator app", content: "Build a CLI calculator.", slug: "calculator-project" },
          { title: "Student record system", content: "Manage student records.", slug: "student-record-project" }
        ]
      },
      {
        title: "Advanced Concepts in C",
        duration: 60,
        topics: [
          { title: "Bitwise operators", content: "Learn advanced operator tricks.", slug: "bitwise-operators" },
          { title: "Command-line arguments", content: "Accept arguments from CLI.", slug: "cli-arguments" }
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

puts "✅ Successfully seeded full C Programming course structure!"
