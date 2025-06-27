class HealthController < ApplicationController
  def up
    respond_to do |format|
      format.html { render plain: "OK", status: :ok }
      format.json { render json: { status: "ok", time: Time.current.utc.iso8601 }, status: :ok }
    end
  end
end
