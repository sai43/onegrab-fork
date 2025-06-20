require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get new_course_url
    assert_response :success
  end

  test "should create course" do
    assert_difference("Course.count") do
      post courses_url, params: { course: { category_id: @course.category_id, description: @course.description, duration_minutes: @course.duration_minutes, level: @course.level, price: @course.price, published: @course.published, published_at: @course.published_at, short_description: @course.short_description, thumbnail_url: @course.thumbnail_url, title: @course.title } }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { category_id: @course.category_id, description: @course.description, duration_minutes: @course.duration_minutes, level: @course.level, price: @course.price, published: @course.published, published_at: @course.published_at, short_description: @course.short_description, thumbnail_url: @course.thumbnail_url, title: @course.title } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference("Course.count", -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
