module Api
  module V1
    class CustomerSerializer < ActiveModel::Serializer
      attributes :id, :name

      belongs_to :address
    end
  end
end

