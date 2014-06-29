require 'test_helper'

class AvatarAdapterTest < ActiveSupport::TestCase

  test "accurately receives image url" do
    user = stub(twitter_handle: "noelrap")
    VCR.use_cassette("adapter_image_url") do
      adapter = AvatarAdapter.new(user)
      url = "http://pbs.twimg.com/profile_images/40008602/head_shot_bigger.jpg"
      assert_equal url, adapter.image_url
    end
  end

end
