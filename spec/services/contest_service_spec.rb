require "rails_helper"

describe ContestService do
  let(:start_date) { I18n.t("contest.date_range").begin }
  let(:end_date) { I18n.t("contest.date_range").end }
  let(:user) { double(user_id: "123456") }

  describe :eligible? do
    it "returns true if user is eligible for contest" do
      # this test has been modified since the code has been modified for the user to always be eligible.
      expect(ContestService.new(user).eligible?).to be_truthy
    end
  end

  describe :content_for_week do
    Timecop.freeze(Time.utc(2019, 8, 14, 23, 59, 59)) do
      it "returns content for the current date if it is during the contest range" do
        expect(ContestService.content_for_week(Date.new(2019, 6, 30))).to be_nil
      end
      it "returns content for the current date if it is during the contest range" do
        expect(ContestService.content_for_week(Date.new(2019, 7, 1))).to \
          include(date_range: Date.new(2019, 7, 1)..Date.new(2019, 7, 7), details: "Week 1 details", title:  "Week 1")
      end
      it "returns content for the current date if it is during the contest range" do
        expect(ContestService.content_for_week(Date.new(2019, 7, 12))).to \
          include(date_range: Date.new(2019, 7, 8)..Date.new(2019, 7, 14), details: "Week 2 details", title:  "Week 2")
      end
      it "returns content for the current date if it is during the contest range" do
        expect(ContestService.content_for_week(Date.new(2019, 7, 23))).to \
          include(date_range: Date.new(2019, 7, 22)..Date.new(2019, 7, 28), details: "Week 4 details", title:  "Week 4")
      end
      it "returns content for the current date if it is during the contest range" do
        expect(ContestService.content_for_week(Date.new(2019, 7, 30))).to \
          include(date_range: Date.new(2019, 7, 29)..Date.new(2019, 7, 31), details: "Week 5 details", title:  "Week 5")
      end
      it "returns nil if the current date is not during the contest range" do
        expect(ContestService.content_for_week(Date.new(2019, 9, 1))).to be_nil
      end
    end
  end

  describe :contest_data do
    it "returns the contest data" do
      expect(ContestService.contest_data).to include(:date_range, :weeks)
    end
  end
end
