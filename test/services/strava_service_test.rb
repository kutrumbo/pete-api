require 'test_helper'

class StravaServiceTest < ActiveSupport::TestCase

  test "token_exchange_success" do
    VCR.use_cassette('strava_token_exchange_success') do
      response = StravaService.token_exchange('29c30c8f260ad9e95b2c5268a91598bfc1f5acd4')
      assert_equal(18159370, response[:athlete_id])
      assert_equal(Time.at(1586565191), response[:expires_at])
      assert_equal('fcd6710cc4559c4a95b8eb479975f91385670e47', response[:access_token])
      assert_equal('0473ac3061aab6a9cc14dccd9da870499a70f5ea', response[:refresh_token])
    end
  end

  test "token_exchange_fails" do
    VCR.use_cassette('strava_token_exchange_failure') do
      response = StravaService.token_exchange('29c30c8f260ad9e95b2c5268a91598bfc1f5acd4')
      assert_equal([{"resource" => "AuthorizationCode", "field" => "", "code" => "expired"}], response[:errors])
    end
  end

end
