require "test_helper"

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @states = ['draft', 'under_moderation', 'published', 'rejected', 'archived']
    @images = ['image1.jpg', 'image2.jpg', 'image3.jpg']
    @bulletin = bulletins(:one)
    @creator = @bulletin.creator
  end

  test "should get index" do
    get bulletins_url
    assert_response :success
  end

  test "should get new bulletin page" do
    sign_in @user
    get new_bulletin_url
    assert_response :success
  end

  test "should create bulletin draft" do
    sign_in @user
    category = categories(:one)
    attrs = {
      title: Faker::Lorem.word,
      description: Faker::ChuckNorris.fact,
      category_id: categories(:one).id,
      state: 'draft',
      image: fixture_file_upload(File.join(Rails.root, "test/fixtures/files/#{@images.sample}"), 'image/jpeg')
    }

    assert_difference('Bulletin.count') do
      post bulletins_url, params: { bulletin: attrs }
    end
    bulletin = Bulletin.find_by(attrs.except(:image))
    assert { bulletin }
    assert_redirected_to bulletin_path(bulletin)
    assert_response :redirect
  end

  test "should show own bulletin" do
    sign_in @creator
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test "should show edit bulletin page" do
    sign_in @creator
    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test "should update bulletin" do
    sign_in @creator

    attrs = {
      title: Faker::Lorem.word,
      description: Faker::ChuckNorris.fact,
      category_id: categories(:two).id,
      state: 'draft',
      image: fixture_file_upload(File.join(Rails.root, "test/fixtures/files/#{@images.sample}"), 'image/jpeg')
    }

    patch bulletin_url(@bulletin), params: { bulletin: attrs }
    assert_redirected_to bulletin_path(@bulletin)

    @bulletin.reload
    assert_equal attrs[:title], @bulletin.title
    assert_equal attrs[:description], @bulletin.description
    assert_equal attrs[:category_id], @bulletin.category_id
  end

  test "should move bulletin to moderation" do
    sign_in @creator

    assert_no_difference('Bulletin.count') do
      patch to_moderate_bulletin_url(@bulletin)
    end

    @bulletin.reload
    assert_equal 'under_moderation', @bulletin.state
    assert_redirected_to user_profile_path
  end

  test "should archive bulletin" do
    sign_in @creator

    assert_no_difference('Bulletin.count') do
      patch archive_bulletin_path(@bulletin)
    end

    @bulletin.reload
    assert_equal 'archived', @bulletin.state
    assert_redirected_to user_profile_path
  end
end
