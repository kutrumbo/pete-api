require 'test_helper'

class StravaControllerTest < ActionDispatch::IntegrationTest

  test "token_success_no_user_exists" do
    VCR.use_cassette('strava_token_success') do
      assert_difference('User.count') do
        post token_strava_index_url, params: { code: '29c30c8f260ad9e95b2c5268a91598bfc1f5acd4' }, as: :json
      end
      assert_response :success
      assert_equal(18159370, JSON.parse(response.body)['athlete_id'])
      user = User.find_by_athlete_id(18159370)
      assert_equal(Time.at(1586565191), user.expires_at)
      assert_equal('fcd6710cc4559c4a95b8eb479975f91385670e47', user.access_token)
      assert_equal('0473ac3061aab6a9cc14dccd9da870499a70f5ea', user.refresh_token)
    end
  end

  test "token_success_user_exists" do
    create(:user, athlete_id: 18159370)
    VCR.use_cassette('strava_token_success') do
      assert_no_difference('User.count') do
        post token_strava_index_url, params: { code: '29c30c8f260ad9e95b2c5268a91598bfc1f5acd4' }, as: :json
      end
      assert_response :success
      user = User.find_by_athlete_id(18159370)
      assert_equal(Time.at(1586565191), user.expires_at)
      assert_equal('fcd6710cc4559c4a95b8eb479975f91385670e47', user.access_token)
      assert_equal('0473ac3061aab6a9cc14dccd9da870499a70f5ea', user.refresh_token)
    end
  end

  test "token_failure" do
    VCR.use_cassette('strava_token_failure') do
      post token_strava_index_url, params: { code: '29c30c8f260ad9e95b2c5268a91598bfc1f5acd4' }, as: :json
      assert_response :bad_request
    end
  end

end
