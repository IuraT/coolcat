Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  FragmentsController::FRAGMENTS.each_key do |token|
    get "/#{token}", to: "fragments#show", defaults: { token: token }
  end
end
