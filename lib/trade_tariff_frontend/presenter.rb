module TradeTariffFrontend
  class Presenter
    delegate :view_context, to: self

    class << self
      def view_context
        Thread.current[:_view_context]
      end

      def view_context=(view_context)
        Thread.current[:_view_context] = view_context
      end
    end
  end
end
