require 'test_helper'

class StravaControllerTest < ActionDispatch::IntegrationTest

  test "token_success" do
    VCR.use_cassette('strava_token_success') do
      post token_strava_index_url, params: { code: '29c30c8f260ad9e95b2c5268a91598bfc1f5acd4' }, as: :json
      assert_response :success
      assert_equal(18159370, JSON.parse(response.body)['athlete_id'])
    end
  end

  test "token_failure" do
    VCR.use_cassette('strava_token_failure') do
      post token_strava_index_url, params: { code: '29c30c8f260ad9e95b2c5268a91598bfc1f5acd4' }, as: :json
      assert_response 400
    end
  end

end
