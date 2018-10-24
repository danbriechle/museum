require 'pry'
class Museum
  attr_reader :name, :exhibit_hash, :revenue
  def initialize(name)
    @name = name
    @exhibit_hash ={}
    @revenue = 0
    @patrons = []
  end

  def add_exhibit(exhibit, cost)
    @exhibit_hash[exhibit] = cost
  end

  def admit(person)
    @patrons << person
    @revenue += 10
    @exhibit_hash.each do |exhibit, cost|
    @revenue += cost if person.interests.include?(exhibit)
  end
  end

  def patrons_of_exhibit(exhibit)
    exhibit_array = []
    @patrons.each do |person|
    exhibit_array <<  person.name if person.interests.include?(exhibit)
    end
    exhibit_array
  end

  def exhibits_by_attendees
    popular_exhibits = @exhibit_hash.sort_by do |exhibit, cost|
      patrons_of_exhibit(exhibit)
    end
    popular_exhibits.flatten.reverse.reject do |numbers|
      numbers.class == Integer
    end
  end




end
