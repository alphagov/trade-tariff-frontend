module TradeTariffFrontend
  module ViewContext
    module Controller
      extend ActiveSupport::Concern

      included do
        before_filter do |controller|
          TradeTariffFrontend::Presenter.view_context = controller.view_context
        end
      end
    end
  end
end
