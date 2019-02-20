module Api
  module V1
    class AddressSerializer < ActiveModel::Serializer
      attributes :street, :city, :zip_code
    end
  end
end

