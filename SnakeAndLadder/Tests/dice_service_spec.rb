require_relative '../Services/dice_service.rb'

describe DiceService do
    let(:dice) {DiceService.new}

    it "returns a rand number between 1 and 6" do
        expect(dice.roll).to be_between(1, 6)
    end
end
