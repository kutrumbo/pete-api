require 'test_helper'

class StravaServiceTest < ActiveSupport::TestCase

  test "token_exchange_success" do
    response = VCR.use_cassette('strava_token_exchange_success') do
      StravaService.token_exchange('29c30c8f260ad9e95b2c5268a91598bfc1f5acd4')
    end

    assert_equal(18159370, response[:athlete_id])
    assert_equal(Time.at(1586565191), response[:expires_at])
    assert_equal('fcd6710cc4559c4a95b8eb479975f91385670e47', response[:access_token])
    assert_equal('0473ac3061aab6a9cc14dccd9da870499a70f5ea', response[:refresh_token])
  end

  test "token_exchange_fails" do
    response = VCR.use_cassette('strava_token_exchange_failure') do
      StravaService.token_exchange('29c30c8f260ad9e95b2c5268a91598bfc1f5acd4')
    end

    assert_equal([{"resource" => "AuthorizationCode", "field" => "", "code" => "expired"}], response[:errors])
  end

  test "token_refresh_success" do
    user = build(:user, refresh_token: '1c00ee96528edfa1445c79228857731eb36018d9')

    response = VCR.use_cassette('strava_token_refresh_success') do
      StravaService.refresh_token(user)
    end

    assert_equal(Time.at(1586669414), response[:expires_at])
    assert_equal('8abc9d72ffff14743bd6ca8a00d4b3fa6117f0cc', response[:access_token])
    assert_equal('1c00ee96528edfa1445c79228857731eb36018d9', response[:refresh_token])
  end

  test "token_refresh_fails" do
    user = build(:user, refresh_token: '8abc9d72ffff14743bd6ca8a00d4b3fa6117f0cc')

    response = VCR.use_cassette('strava_token_refresh_failure') do
      StravaService.refresh_token(user)
    end

    assert_equal([{"resource" => "RefreshToken", "field" => "refresh_token", "code" => "invalid"}], response[:errors])
  end

  test "fetch_activities!" do
    user = build(:user, refresh_token: '9e7a98c6e5e2c9a5a5706f665eb825fa0866a6a3')

    response = VCR.use_cassette('strava_fetch_activities') do
      StravaService.fetch_activities!(user, 1586049499)
    end

    event = Event.order(:time).first
    assert_equal('strava', event.source)
    assert_equal(3260850976, event.source_id)
    assert_equal('running', event.name)
    assert_equal(DateTime.parse('2020-04-06T00:32:01Z'), event.time)
    assert_equal(2929.0, event.details['distance'])
  end

end
