module Contest
  extend ActiveSupport::Concern

  included do
    after_action :track_entry, unless: :redirected?
    helper_method :display_contest
  end

  def display_contest
    return unless user_eligible? && !previously_viewed?

    render(partial: "contest/contest_modal", locals: { content: content_for_contest }) if content_for_contest.present?
  end

private

  def content_for_contest
    ContestService.content_for_week(request_date)
  end

  def override_params
    params.permit(:contest_date)
  end

  def request_date
    override_params[:contest_date].try(:to_date) || Date.current
  end

  def previously_viewed?
    return false unless viewed_cookie.present?

    content_for_contest.present? && content_for_contest[:date_range].cover?(viewed_cookie.to_date)
  end

  def track_entry
    return unless user_eligible? && contest_active?
    return if tracked_today?

    ContestEntry.create_for user
  end

  def redirected?
    response.redirect?
  end

  def tracked_today?
    viewed_cookie.present? && viewed_cookie.to_date == request_date
  end

  def contest_active?
    ContestService.contest_data[:date_range].cover? request_date
  end

  def user_eligible?
    return false unless user.present? #modified for this example

    eligibility_cookie["value"]
  end

  def eligibility_cookie
    create_eligibility_cookie unless cookies[:contest_eligible].present?

    retrieve_json_from_cookie(:contest_eligible)
  end

  def create_eligibility_cookie
    store_json_cookie :contest_eligible,
                      value: ContestService.new(user).eligible?,
                      expires: ContestService.contest_data[:date_range].end
  end

  def viewed_cookie
    return unless cookies[:contest_viewed].present?

    if (_cookie = retrieve_json_from_cookie(:contest_viewed))
      delete_cookie(:contest_viewed)
      return nil
    end

    cookies[:contest_viewed]
  end

  def delete_cookie(key)
    cookie_jar.delete(key)
  end

  def retrieve_json_from_cookie(key)
    JSON.parse(cookies.signed[key])
  rescue JSON::ParserError, TypeError
    nil
  end

  def store_json_cookie(key, data)
    cookies.signed[key] = data.to_json
  end

  def user
    # This method is added to create a mock user, so the rest of the code is functional.
    @user ||= User.new(id: "123456",
                       first_name: "John",
                       last_name: "Doe",
                       email: "test@example.com")
  end
end
