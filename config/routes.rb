Rails.application.routes.draw do
  root to: "home#index"

  get "contest/rules", to: "contest#rules"
  get "contest/entries(/:contest_date)", to: "contest#entries", as: "contest_entries", constraints: { format: /html|csv|xls/ }
end
