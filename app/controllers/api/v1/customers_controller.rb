module Api
  module V1
    class CustomersController < ApiController

      api :GET, 'customers.json', 'Fetch Customers'
      param :name, String, desc: 'To Search by Name', required: false
      param :street, String, desc: 'To Search by Street', required: false
      param :page_no, String, desc: 'For Pagination', required: false
      description 'Authorization required'
      example '
        Response:
        {
          "customers": [
                        {
                         "name": "James",
                         "address": {
                                      "street": "Street no 1",
                                      "city": "New York",
                                      "zip_code": "33243"
                                      }
                        }
                       ],
          "meta": {
              "current_page": 1,
              "next_page": null,
              "prev_page": null,
              "total_pages": 1,
              "total_count": 3
            }
        }'

      def index
        customers = Customer.with_address
        filtering_params.each do |key, value|
          customers = customers.public_send("search_by_#{key}", value) if value.present?
        end

        render_success_with_pagination customers.page(params[:page_no])
      end


      api :POST, 'customers.json', 'Create new Customer'
      example '
      Request
        {
         "customer":{
                     "name": "James",
                     "address_attributes": {
                                  "street": "Street no 1",
                                  "city": "New York",
                                  "zip_code": "33243"
                                  }
                    }
        }
      Response 201'

      def create
        customer = Customer.new(customer_params)
        if customer.save
          head :created
        else
          render_error(:bad_request, customer.errors.full_messages.join(' '))
        end
      end


      api :DELETE, 'customers/:id.json', 'Delete Customer'
      example 'Response 204'

      def destroy
        customer = Customer.find params[:id]
        if customer.destroy
          head :no_content
        else
          render_error(:bad_request, customer.errors.full_messages.join(' '))
        end
      end

      protected

      def filtering_params
        params.slice(:name, :street)
      end

      def customer_params
        params.require(:customer).permit(:name, address_attributes: [:street, :city, :zip_code])
      end
    end
  end
end
