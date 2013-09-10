require 'money'

module Plagiarism
  class Balance < Request


    class << self

      # Return the amount (in cents) of your remaining Copyscape account balance
      #
      def amount
        response = Request.new(:get, o: 'balance').response
        if response.success?
          Money.parse(response.doc.css('value').text).cents
        else
          raise "An error occurred while attempting to retrieve your account balance"
        end
      end


      # Return search credits remaining for your Copyscape account
      #
      def credits
        response = Request.new(:get, o: 'balance').response
        if response.success?
          response.doc.css('total').text.to_i
        else
          raise "An error occurred while attempting to retrieve your account balance"
        end
      end

    end

  end
end