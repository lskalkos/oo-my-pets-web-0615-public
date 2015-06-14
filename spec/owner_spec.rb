require_relative 'spec_helper.rb'
require 'pry'

describe Owner do

  let(:owner) { Owner.new("human") }
  let(:fish) { Fish.new("Nemo") }
  let(:cat) { Cat.new("Crookshanks") }
  let(:dog) { Dog.new("Fido") }  

  describe 'Class methods' do
    it "keeps track of the owners that have been created" do
      expect(Owner.all).to include(owner)
    end

    it "can reset the owners that have been created" do
      Owner.reset_all
      expect(Owner.count).to eq(0)
    end

    it "can count how many owners have been created" do
      Owner.reset_all
      Owner.new("human")
      expect(Owner.count).to eq(1)
    end
  end 

  it "can initialize an owner" do
    expect(owner).to be_a(Owner)
  end

  it "initializes with a species" do
    expect(owner.species).to eq("human")
  end

  it "can't change its species" do 
    expect { owner.species = "hamster" }.to raise_error
  end

  it "can say its species" do 
    expect(owner.say_species).to eq("I am a human.")
  end 

  it "can have a name" do
    owner.name = "Katie"
    expect(owner.name).to eq("Katie")
  end

  it "is initialized with a pets attribute as a hash with 3 keys" do
    expect(owner.pets).to eq({:fishes => [], :dogs => [], :cats => []})
  end

  it 'can buy a fish' do 
    expect(owner.pets[:fishes].count).to eq(0)
    owner.buy_fish("Bubbles")
    expect(owner.pets[:fishes].count).to eq(1)
  end

  it 'can buy a cat' do 
    expect(owner.pets[:cats].count).to eq(0)
    owner.buy_cat("Crookshanks")
    expect(owner.pets[:cats].count).to eq(1)
  end

  it 'can buy a dog' do
    expect(owner.pets[:dogs].count).to eq(0)
    owner.buy_dog("Snuffles")
    expect(owner.pets[:dogs].count).to eq(1)
  end

  it 'knows about its fishes' do
    owner.buy_fish("Bubbles")
    expect(owner.pets[:fishes][0].name).to eq("Bubbles")
  end

  it 'knows about its cats' do 
    owner.buy_cat("Crookshanks")
    expect(owner.pets[:cats][0].name).to eq("Crookshanks")
  end

  it 'knows about its dogs' do
    owner.buy_dog("Snuffles")
    expect(owner.pets[:dogs][0].name).to eq("Snuffles") 
  end

  it "walks the dogs which makes the dogs' moods happy" do
    dog = Dog.new("Daisy")
    owner.pets[:dogs] << dog
    owner.walk_dogs
    expect(dog.mood).to eq("happy")
  end 

  it "plays with the cats which makes the cats moods happy" do
    cat = Cat.new("Muffin")
    owner.pets[:cats] << cat
    owner.play_with_cats
    expect(cat.mood).to eq("happy")
  end 

  it "feeds the fishes which makes the fishes' moods happy" do
    fish = Fish.new("Nemo")
    owner.pets[:fishes] << fish
    owner.feed_fish
    expect(fish.mood).to eq("happy")
  end 

  it 'can sell all its pets, which make them nervous' do 
    fido = Dog.new("Fido")
    tabby = Cat.new("Tabby")
    nemo = Fish.new("Nemo")
    [fido, tabby, nemo].each {|o| o.mood = "happy" }
    owner.pets = {
      :dogs => [fido, Dog.new("Daisy")], 
      :fishes => [nemo], 
      :cats => [Cat.new("Mittens"), tabby]
    }
    owner.sell_pets
    owner.pets.each {|type, pets| expect(pets.empty?).to eq(true) }
    [fido, tabby, nemo].each { |o| expect(o.mood).to eq("nervous") }
  end

  it 'can list off its pets' do 
    owner.buy_fish("Bubbles")
    owner.buy_fish("Nemo")
    owner.buy_cat("Crookshanks")
    owner.buy_dog("Fido")
    owner.buy_dog("Snuffles")
    owner.buy_dog("Charley")
    expect(owner.list_pets).to eq("I have 2 fish, 3 dog(s), and 1 cat(s).")
  end

end