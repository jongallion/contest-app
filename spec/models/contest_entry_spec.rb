require "rails_helper"

describe ContestEntry do
  let(:mocked_user) { mock_user }

  describe :create_for do
    it "creates an entry if the user does not have an entry for that day" do
      entry = ContestEntry.create_for mocked_user
      expect(entry.user_id).to eql mocked_user.id
      expect(entry.email).to eql mocked_user.email
      expect(entry.first_name).to eql mocked_user.first_name
      expect(entry.last_name).to eql mocked_user.last_name
    end

    it "doesn't create an entry if the user has an entry for that day" do
      factory_entry = create(:contest_entry, user_id: mocked_user.id,
                                             email: mocked_user.email,
                                             first_name: mocked_user.first_name,
                                             last_name: mocked_user.last_name)
      entry = ContestEntry.create_for mocked_user
      expect(entry.user_id).to eql factory_entry.user_id
    end

    it "creates an entry if the user has previous entries but not an entry for the current day" do
      factory_entry = create(:contest_entry, user_id: mocked_user.id,
                                             email: mocked_user.email,
                                             first_name: mocked_user.first_name,
                                             last_name: mocked_user.last_name,
                                             created_at: 1.day.ago)
      entry = ContestEntry.create_for mocked_user
      expect(entry.created_at).to_not eql factory_entry.created_at
    end
  end
end
