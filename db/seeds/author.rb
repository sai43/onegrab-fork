def find_or_create_author
  User.find_or_create_by!(email: ENV['AUTHOR_EMAIL']) do |user|
    user.first_name = ENV['AUTHOR_FIRST_NAME']
    user.last_name = ENV['AUTHOR_LAST_NAME']
    user.username = ENV['AUTHOR_USERNAME']
    user.phone = ENV['AUTHOR_PHONE']
    user.password = ENV['AUTHOR_PASSWORD']
    user.role = ENV['AUTHOR_ROLE']
  end
end
