require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'
require './lib/patron'

class MuseumTest < Minitest::Test
  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")
    assert_instance_of Museum, dmns
  end

  def test_it_can_return_name
    dmns = Museum.new("Denver Museum of Nature and Science")
    assert_equal "Denver Museum of Nature and Science", dmns.name
  end

  def test_it_can_be_given_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit("Dead Sea Scrolls", 10)
    dmns.add_exhibit("Gems and Minerals", 0)
    expected = {"Dead Sea Scrolls" => 10, "Gems and Minerals" => 0}
    assert_equal expected, dmns.exhibit_hash
  end

  def test_it_starts_with_no_revenue
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit("Dead Sea Scrolls", 10)
    dmns.add_exhibit("Gems and Minerals", 0)
    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")
    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")
    assert_equal 0, dmns.revenue
  end

  def test_it_can_generate_revenue
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit("Dead Sea Scrolls", 10)
    dmns.add_exhibit("Gems and Minerals", 0)
    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")
    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")
    dmns.admit(bob)
    dmns.admit(sally)
    assert_equal 40, dmns.revenue
  end

  def test_it_patrons_can_be_sorted_by_exhibit
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit("Dead Sea Scrolls", 10)
    dmns.add_exhibit("Gems and Minerals", 0)
    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")
    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")
    dmns.admit(bob)
    dmns.admit(sally)
    assert_equal ["Bob"], dmns.patrons_of_exhibit("Gems and Minerals")
    assert_equal ["Bob", "Sally"], dmns.patrons_of_exhibit("Dead Sea Scrolls")
  end

  def test_it_exhibits_can_be_sorted_by_patrons
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit("Dead Sea Scrolls", 10)
    dmns.add_exhibit("Gems and Minerals", 0)
    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")
    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")
    dmns.admit(bob)
    dmns.admit(sally)
    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], dmns.exhibits_by_attendees
  end

  def test_it_can_remove_unpopular_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit("Dead Sea Scrolls", 10)
    dmns.add_exhibit("Gems and Minerals", 0)
    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")
    sally = Patron.new("Sally")
    sally.add_interest("Dead Sea Scrolls")
    dmns.admit(bob)
    dmns.admit(sally)
    expected = {"Gems and Minerals" => 0}
    assert_equal expected, dmns.remove_unpopular_exhibits(1)
  end

end
