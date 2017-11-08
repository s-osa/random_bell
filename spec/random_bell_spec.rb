require 'spec_helper'

describe RandomBell do
  REPEAT = 10 ** 5
  WITHIN = 0.1

  describe "#standard" do
    before :all do
      @bell = RandomBell.new
    end

    describe "results" do
      before :all do
        @results = []
        REPEAT.times{ @results << @bell.standard }
      end

      it "should be 0 as average" do
        expect(@results.average).to be_within(WITHIN).of(0)
      end

      it "should be 1 as variance" do
        expect(@results.variance).to be_within(WITHIN).of(1)
      end

      it "should be 1 as standard diviation" do
        expect(@results.standard_diviation).to be_within(WITHIN).of(1)
      end

      it "drow histgram", histogram: true do
        puts @bell.to_histogram
      end
    end
  end

  describe "#normal" do
    before :all do
      @mu, @sigma = 1, 0.5
      @bell = RandomBell.new(mu: @mu, sigma: @sigma)
    end

    describe "results" do
      before :all do
        @results = []
        REPEAT.times{ @results << @bell.normal }
      end

      it "should be mu as average" do
        expect(@results.average).to be_within(WITHIN).of(@mu)
      end

      it "should be square sigma as variance" do
        expect(@results.variance).to be_within(WITHIN).of(@sigma ** 2)
      end

      it "should be sigma as normal diviation" do
        expect(@results.standard_diviation).to be_within(WITHIN).of(@sigma)
      end

      it "drow histgram", histogram: true do
        puts @bell.to_histogram
      end
    end
  end

  describe "#rand" do
    context "range not given" do
      before :all do
        @bell = RandomBell.new(mu: 1, sigma: 0.5)
      end

      it "should return float" do
        expect(@bell.rand).to be_an_instance_of Float
      end

      describe "results" do
        before :all do
          @results = []
          REPEAT.times{ @results << @bell.rand }
        end

        it "should be 1 as max" do
          expect(@results.max).to be <= 1
        end

        it "should be 1 as min" do
          expect(@results.min).to be >= 0
        end

        it "drow histgram", histogram: true do
          puts @bell.to_histogram
        end
      end
    end

    context "range given" do
      before :all do
        @mu, @sigma, @range = 50, 20, 40..100
        @bell = RandomBell.new(mu: @mu, sigma: @sigma, range: @range)
      end

      describe "results" do
        before :all do
          @results = []
          REPEAT.times{ @results << @bell.rand }
        end

        it "should be 100 as max" do
          expect(@results.max).to be <= 100
        end

        it "should be 40 as min" do
          expect(@results.min).to be >= 40
        end

        it "drow histgram", histogram: true do
          puts @bell.to_histogram
        end
      end
    end

    context "seed given" do
      before do
        @bell1 = RandomBell.new(seed: 1234)
        @bell2 = RandomBell.new(seed: 1234)
      end

      it "should return same sequence" do
        100.times do
          expect(@bell1.rand).to eq @bell2.rand
        end
      end
    end
  end

  describe "#to_histogram" do
    it "should return histogram string" do
      bell = RandomBell.new(mu: 0.7)
      expect(bell.to_histogram).to match(/\*+/)
    end
  end
end
