require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'

class PatronTest < MiniTest::Test

  def test_it_exists
  bob = Patron.new("Bob")
   assert_instance_of Patron,bob
  end

  def test_it_can_return_name
  bob = Patron.new("Bob")
   assert_equal "Bob", bob.name
  end

  def test_it_starts_with_no_interests
  bob = Patron.new("Bob")
   assert_equal [], bob.interests
  end

  def test_it_can_be_given_interests
  bob = Patron.new("Bob")
  bob.add_interest("Dead Sea Scrolls")
  bob.add_interest("Gems and Minerals")
   assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], bob.interests
  end
end
