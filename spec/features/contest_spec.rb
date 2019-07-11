require "rails_helper"

describe "ContestEntry" do
  describe "Eligible User" do
    let(:mocked_user) { mock_user }

    it "tracks and shows the contest modal when contest is running" do
      Timecop.freeze(Time.utc(2019, 7, 15, 23, 59, 59)) do
        expect(ContestEntry).to receive(:create_for)

        allow_any_instance_of(ContestService).to receive(:eligible?).and_return(true)
        visit root_path

        expect(page).to have_selector(".modal__container")
      end
    end

    it "does not tracked or show the contest modal when contest is over" do
      Timecop.freeze(Time.utc(2019, 8, 1, 6, 0, 0)) do
        expect(ContestEntry).to_not receive(:create_for)

        allow_any_instance_of(ContestService).to receive(:eligible?).and_return(true)
        visit root_path

        expect(page).to_not have_selector(".modal__container")
      end
    end
  end

  describe "Ineligible accounts" do
    let(:mocked_user) { mock_user }
    it "does not track the user or display the modal" do
      expect(ContestEntry).to_not receive(:create_for)

      allow_any_instance_of(ContestService).to receive(:eligible?).and_return(false)
      visit root_path

      expect(page).to_not have_selector(".modal__container")
    end
  end
end
