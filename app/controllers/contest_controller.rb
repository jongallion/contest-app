class ContestController < ApplicationController
  def rules; end

  def entries
    # redirect_to root_url unless authorize! :manage, ContestEntry
    @entries = contest_entries
    respond_to do |format|
      format.html
      format.csv { send_data @entries.to_csv, filename: "entries-#{contest_date.presence || 'all'}" }
      format.xls
    end
  end

private

  def contest_date
    return unless contest_params[:contest_date].present?

    contest_params[:contest_date].to_date
  end
  helper_method :contest_date

  def contest_entries
    ContestEntry.entries_for report_range
  end

  def report_range
    contest_date.present? ? contest_date.all_day : ContestService.contest_data[:date_range]
  end

  def contest_params
    params.permit(:contest_date)
  end
end
