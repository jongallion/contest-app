class ContestService
  class << self
    def content_for_week(date = Date.current)
      contest_data[:weeks].find { |week| week[:date_range].cover? date }
    end

    def contest_data
      @contest_data ||= I18n.t("contest")
    end
  end

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def eligible?
    return false unless membership.present?

    membership_range.include? self.class.send(:contest_data)[:date_range]
  end

private

  # These methods are modified to work without needing the Membership Service.
  def membership
    # @membership ||= MembershipService.new(@user)
    { start_date: 6.months.ago, end_date: 6.months.from_now }
  end

  def membership_range
    membership[:start_date]..membership[:end_date]
  end
end
