require_relative "../lib/garage"
require_relative "../lib/van"
require_relative "../lib/docking_station"

describe Garage do
  let(:garage) {Garage.new(:capacity => 100)}
  let(:station) {DockingStation.new(:capacity => 20)}
  let(:van) {Van.new(:capacity => 50)}

  def test_bikes
    @working_bike, @broken_bike = Bike.new, Bike.new
    @broken_bike.break
  end

  it "should allow setting default capacity on initialising" do
    expect(garage.capacity).to eq(100)
  end

  it "should only dock broken bikes into garage from van" do
    test_bikes
    van.dock(@working_bike)
    van.dock(@broken_bike)
    garage.put_in(van.broken_bikes)
    van.take_out(garage.broken_bikes)
    expect(garage.bikes).to eq([@broken_bike])
    expect(van.bikes.count).to eq(1)
  end
end
