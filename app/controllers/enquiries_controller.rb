class EnquiriesController < ApplicationController
  def index
    @enquiries = Enquiry.all
  end

  def show
    @enquiry = Enquiry.find(params.expect(:id))
  end
end
