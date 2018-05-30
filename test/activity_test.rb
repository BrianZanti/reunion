require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test

  def setup
    @activity = Activity.new("Camping", 50, 10)
  end

  def test_it_has_attributes
    assert_equal "Camping", @activity.name
    assert_equal 50, @activity.base_cost
    assert_equal 10, @activity.individual_cost
  end

  def test_participants_starts_empty
    assert_equal [], @activity.participants
  end

  def test_add_participants
    @activity.add_participant("Brian", 20)
    @activity.add_participant("Megan", 5)

    participant_1 = {name: "Brian", paid: 20}
    participant_2 = {name: "Megan", paid: 5}
    assert_equal [participant_1, participant_2], @activity.participants
  end

  def test_total_cost
    @activity.add_participant("Brian", 20)
    @activity.add_participant("Megan", 5)

    assert_equal 70.00, @activity.total_cost
  end

  def test_fair_share
    @activity.add_participant("Brian", 20)
    @activity.add_participant("Megan", 5)
    @activity.add_participant("Scott", 1)

    assert_equal 26.67, @activity.fair_share
  end

  def test_amount_owed
    @activity.add_participant("Brian", 30)
    @activity.add_participant("Megan", 5)
    @activity.add_participant("Scott", 1)
    assert_equal -3.33, @activity.amount_owed("Brian")
    assert_equal 21.67, @activity.amount_owed("Megan")
  end

  def test_debts
    @activity.add_participant("Brian", 30)
    @activity.add_participant("Megan", 5)
    @activity.add_participant("Scott", 1)
    expected = {
      "Brian" => -3.33,
      "Megan" => 21.67,
      "Scott" => 25.67
    }
    assert_equal expected, @activity.debts
  end
end
