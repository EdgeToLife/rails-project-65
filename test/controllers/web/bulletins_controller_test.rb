# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:user)
      @images = ['image1.jpg', 'image2.jpg', 'image3.jpg']
      @bulletin = bulletins(:draft)
      @published_bulletin = bulletins(:published)
      @creator = @bulletin.user
    end

    test 'should get bulletin index' do
      get bulletins_url
      assert_response :success
      assert_select 'h4', text: @published_bulletin.title
    end

    test 'should get new bulletin page' do
      sign_in @user
      get new_bulletin_url
      assert_response :success
    end

    test 'should create bulletin draft' do
      sign_in @user
      categories(:one)
      attrs = {
        title: Faker::Lorem.word,
        description: Faker::ChuckNorris.fact,
        category_id: categories(:one).id,
        state: 'draft',
        image: fixture_file_upload(Rails.root.join("test/fixtures/files/#{@images.sample}").to_s, 'image/jpeg')
      }

      assert_difference('Bulletin.count') do
        post bulletins_url, params: { bulletin: attrs }
      end
      bulletin = Bulletin.find_by(attrs.except(:image))
      assert { bulletin }
      assert bulletin.draft?
      assert_redirected_to bulletin_path(bulletin)
      assert_response :redirect
    end

    test 'should show own bulletin' do
      sign_in @creator
      get bulletin_url(@bulletin)
      assert_response :success
    end

    test 'should show edit bulletin page' do
      sign_in @creator
      get edit_bulletin_url(@bulletin)
      assert_response :success
    end

    test 'should update bulletin' do
      sign_in @creator

      attrs = {
        title: Faker::Lorem.word,
        description: Faker::ChuckNorris.fact,
        category_id: categories(:two).id,
        state: 'draft',
        image: fixture_file_upload(Rails.root.join("test/fixtures/files/#{@images.sample}").to_s, 'image/jpeg')
      }

      patch bulletin_url(@bulletin), params: { bulletin: attrs }
      assert_redirected_to bulletin_path(@bulletin)

      @bulletin.reload
      assert_equal attrs[:title], @bulletin.title
      assert_equal attrs[:description], @bulletin.description
      assert_equal attrs[:category_id], @bulletin.category_id
    end

    test 'should move bulletin to moderation' do
      sign_in @creator
      patch to_moderate_bulletin_url(@bulletin)
      @bulletin.reload
      assert @bulletin.under_moderation?
      assert_redirected_to profile_path
    end

    test 'should archive bulletin' do
      sign_in @creator
      patch archive_bulletin_path(@bulletin)
      @bulletin.reload
      assert @bulletin.archived?
      assert_redirected_to profile_path
    end

    test 'non-owner should be forbidden to archive bulletin' do
      original_state = @bulletin.state
      patch archive_bulletin_path(@bulletin)
      assert_equal original_state, @bulletin.reload.state
      assert_redirected_to root_path
    end
  end
end
