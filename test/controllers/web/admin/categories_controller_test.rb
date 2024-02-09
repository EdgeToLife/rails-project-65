# # frozen_string_literal: true

# require 'test_helper'

# module Posts
#   class CommentsControllerTest < ActionDispatch::IntegrationTest
#     include Devise::Test::IntegrationHelpers
#     setup do
#       @user = users(:one)
#       @post = posts(:one)
#       sign_in @user
#       @comment_attributes = { content: Faker::ChuckNorris.fact }
#     end

#     test 'should create comment' do
#       assert_difference('PostComment.count') do
#         post post_comments_url(@post), params: { post_comment: @comment_attributes }
#       end
#       created_comment = PostComment.last
#       assert_equal @comment_attributes[:content], created_comment.content
#       assert_redirected_to post_url(@post)
#     end
#   end
# end
