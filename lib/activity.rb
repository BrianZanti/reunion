class Activity
  attr_reader :name,
              :base_cost,
              :individual_cost,
              :participants

  def initialize(name, base_cost, individual_cost)
    @name = name
    @base_cost = base_cost
    @individual_cost = individual_cost
    @participants = []
  end

  def add_participant(name, cost)
    new_participant = {name: name, paid: cost}
    @participants << new_participant
  end

  def num_participants
    @participants.length
  end

  def total_cost
    @base_cost + num_participants * @individual_cost
  end

  def fair_share
    (total_cost.to_f / num_participants.to_f).round(2)
  end

  def amount_owed(name)
    participant = @participants.find do |participant|
      participant[:name] == name
    end
    (fair_share - participant[:paid]).round(2)
  end

  def debts
    @participants.inject({}) do |debts, participant|
      name = participant[:name]
      require 'pry'; binding.pry
      debts[name] = amount_owed(name)
    end
  end
end
