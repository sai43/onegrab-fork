author = User.find_by(email: ENV['AUTHOR_EMAIL'])
category = Category.find_by(name: "Web Development")

raise "Author or category missing!" unless author && category

course = Course.find_or_initialize_by(title: "HTML5 & CSS3")

course.description = "Comprehensive course covering modern HTML5 semantics and CSS3 styling techniques, including layouts, animations, and best practices."
course.short_description = "Master modern web design with HTML5 & CSS3."
course.price = 1500
course.level = "beginner"
course.duration_minutes = 900
course.thumbnail_url = "https://upload.wikimedia.org/wikipedia/commons/6/61/HTML5_logo_and_wordmark.svg"
course.category = category
course.author = author
course.published = true
course.save!

puts "✅ Created course: #{course.title}"

raise "Course creation failed!" unless course.persisted?

sections_data = [
  {
    title: "Introduction to HTML5 & CSS3",
    description: "Understand what HTML5 & CSS3 are and why they matter.",
    duration: 60,
    lessons: [
      {
        title: "History of HTML & CSS",
        duration: 20,
        topics: [
          { title: "Evolution of HTML", content: "Learn how HTML evolved over time.", slug: "evolution-html" },
          { title: "CSS milestones", content: "Key updates in CSS history.", slug: "css-milestones" }
        ]
      },
      {
        title: "HTML5 Overview",
        duration: 20,
        topics: [
          { title: "HTML5 features", content: "New elements and APIs introduced in HTML5.", slug: "html5-features" },
          { title: "Semantic tags", content: "Understanding the importance of semantic HTML.", slug: "semantic-tags" }
        ]
      },
      {
        title: "CSS3 Overview",
        duration: 20,
        topics: [
          { title: "CSS3 modules", content: "Introduction to CSS3 modules.", slug: "css3-modules" },
          { title: "Browser support", content: "How modern browsers support CSS3.", slug: "browser-support" }
        ]
      }
    ]
  },
  {
    title: "HTML5 Fundamentals",
    description: "Learn to structure content with modern HTML.",
    duration: 120,
    lessons: [
      {
        title: "Basic Structure",
        duration: 30,
        topics: [
          { title: "Document structure", content: "DOCTYPE, head, body tags.", slug: "document-structure" },
          { title: "Meta tags", content: "SEO and responsive design meta tags.", slug: "meta-tags" }
        ]
      },
      {
        title: "Forms & Inputs",
        duration: 30,
        topics: [
          { title: "Form elements", content: "Inputs, labels, and buttons.", slug: "form-elements" },
          { title: "Validation", content: "Client-side form validation techniques.", slug: "form-validation" }
        ]
      },
      {
        title: "Media Elements",
        duration: 30,
        topics: [
          { title: "Audio & Video", content: "Embedding multimedia in HTML5.", slug: "audio-video" },
          { title: "Canvas & SVG", content: "Graphics and drawings with canvas and SVG.", slug: "canvas-svg" }
        ]
      }
    ]
  },
  {
    title: "CSS3 Fundamentals",
    description: "Style and layout your pages beautifully.",
    duration: 120,
    lessons: [
      {
        title: "Selectors & Properties",
        duration: 40,
        topics: [
          { title: "Basic selectors", content: "Targeting elements effectively.", slug: "basic-selectors" },
          { title: "Pseudo-classes", content: "Enhancing interactions with pseudo-classes.", slug: "pseudo-classes" }
        ]
      },
      {
        title: "Box Model & Layouts",
        duration: 40,
        topics: [
          { title: "Box model", content: "Margins, borders, padding, and content.", slug: "box-model" },
          { title: "Flexbox & Grid", content: "Modern layout techniques.", slug: "flexbox-grid" }
        ]
      },
      {
        title: "Typography & Colors",
        duration: 40,
        topics: [
          { title: "Web fonts", content: "Using custom fonts on the web.", slug: "web-fonts" },
          { title: "Color schemes", content: "Creating harmonious color palettes.", slug: "color-schemes" }
        ]
      }
    ]
  },
  {
    title: "Advanced CSS Techniques",
    description: "Take your designs to the next level with advanced effects.",
    duration: 150,
    lessons: [
      {
        title: "Transitions & Animations",
        duration: 50,
        topics: [
          { title: "CSS transitions", content: "Smooth changes on hover and interaction.", slug: "css-transitions" },
          { title: "Keyframe animations", content: "Complex animations using keyframes.", slug: "keyframe-animations" }
        ]
      },
      {
        title: "Responsive Design",
        duration: 50,
        topics: [
          { title: "Media queries", content: "Adapting layouts for different devices.", slug: "media-queries" },
          { title: "Mobile-first design", content: "Designing for smaller screens first.", slug: "mobile-first" }
        ]
      },
      {
        title: "CSS Variables & Custom Properties",
        duration: 50,
        topics: [
          { title: "Using CSS variables", content: "Simplify theme management.", slug: "css-variables" },
          { title: "Practical examples", content: "Implementing reusable styles.", slug: "practical-examples" }
        ]
      }
    ]
  },
  {
    title: "Final Project",
    description: "Put your skills into practice.",
    duration: 120,
    lessons: [
      {
        title: "Designing a Landing Page",
        duration: 60,
        topics: [
          { title: "Planning & wireframing", content: "Creating a project blueprint.", slug: "planning-wireframing" },
          { title: "Implementation", content: "Building the final design using HTML & CSS.", slug: "final-implementation" }
        ]
      },
      {
        title: "Deployment & Optimization",
        duration: 60,
        topics: [
          { title: "Deploying to Netlify", content: "Make your site live.", slug: "deploy-netlify" },
          { title: "Performance optimization", content: "Speed up your website.", slug: "performance-optimization" }
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

puts "✅ Successfully seeded full HTML5 & CSS3 course structure!"
