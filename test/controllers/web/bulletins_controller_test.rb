require "test_helper"

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @states = ['draft', 'under_moderation', 'published', 'rejected', 'archived']
    @images = ['image1.jpg', 'image2.jpg', 'image3.jpg']
  end

  test "should get index" do
    get bulletins_index_url
    assert_response :success
  end

  test "should get new" do
    get bulletins_new_url
    assert_response :success
  end

  test "should create bulletin draft" do
    category = categories(:one)
    attrs = {
      title: Faker::Lorem.word,
      description: Faker::ChuckNorris.fact,
      category_id: categories(:one).id,
      state: 'draft',
      image: fixture_file_upload(File.join(Rails.root, "test/fixtures/files/#{@images.sample}"), 'image/jpeg')
    }

    assert_difference('Bulletin.count') do
      post :create, params: { bulletin: attrs }
    end
    bulletin = Bulletin.find_by(attrs)
    assert { bulletin }
    assert_redirected_to bulletin_path(bulletin)
    assert_response :success
  end

  # test "should get show" do
  #   get bulletins_show_url
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get bulletins_edit_url
  #   assert_response :success
  # end
end
