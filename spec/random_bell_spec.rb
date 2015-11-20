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
  end

  describe "#to_histogram" do
    it "should return histogram string" do
      bell = RandomBell.new(mu: 0.7)
      expect(bell.to_histogram).to match(/\*+/)
    end
  end

  describe "accessor" do
    context "appearance probability more than 1%" do
      before :all do
        @bell = RandomBell.new
        @mu, @sigma, @range = 0.6, 0.3, 0.1 .. 1.2
      end

      it "should return set value as mu" do
        @bell.mu = @mu
        expect(@bell.mu).to eq @mu
      end

      it "should return set value as sigma" do
        @bell.sigma = @sigma
        expect(@bell.sigma).to eq @sigma
      end

      it "should return set value as range" do
        @bell.range = @range
        expect(@bell.range).to eq @range
      end
    end

    context "appearance probability less than 1%" do
      before :all do
        @bell = RandomBell.new
        @mu, @sigma, @range = 2, 0.1, 1.5..2.5
      end

      it "should return set value as mu" do
        expect{@bell.mu = @mu}.to raise_error(ArgumentError)
        expect(@bell.mu).to eq 0.5
      end

      it "should return set value as sigma" do
        @bell.mu = 1.5
        expect{@bell.sigma = @sigma}.to raise_error(ArgumentError)
        @bell.mu = 0.5
        expect(@bell.sigma).to eq 0.2
      end

      it "should return set value as range" do
        expect{@bell.range = @range}.to raise_error(ArgumentError)
        expect(@bell.range).to eq 0.0..1.0
      end
    end
  end

  describe "#renew" do
    context "appearance probability more than 1%" do
      before :all do
        @bell = RandomBell.new
        @mu, @sigma, @range = 2, 0.1, 1.5..2.5
      end

      it "should return true" do
        expect(@bell.renew(mu: @mu, sigma: @sigma, range: @range)).to eq true
      end

      it "should return set value as mu" do
        expect(@bell.mu).to eq @mu
      end

      it "should return set value as sigma" do
        expect(@bell.sigma).to eq @sigma
      end

      it "should return set value as range" do
        expect(@bell.range).to eq @range
      end
    end

    context "appearance probability less than 1%" do
      before :all do
        @bell = RandomBell.new
        @mu, @sigma, @range = 0, 0.1, 0.5..1.5
      end

      it "should return true" do
        expect{@bell.renew(mu: @mu, sigma: @sigma, range: @range)}.to raise_error(ArgumentError)
      end

      it "should return set value as mu" do
        expect(@bell.mu).to eq 0.5
      end

      it "should return set value as sigma" do
        expect(@bell.sigma).to eq 0.2
      end

      it "should return set value as range" do
        expect(@bell.range).to eq 0.0..1.0
      end
    end
  end
end
