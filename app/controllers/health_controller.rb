class HealthController < ApplicationController
  skip_before_action :authenticate_member!

  def up
    respond_to do |format|
      format.html { render plain: "OK", status: :ok }
      format.json { render json: { status: "ok", time: Time.current.utc.iso8601 }, status: :ok }
    end
  end

  def redis_up
    begin
      test_key = "health:test"
      Rails.cache.write(test_key, "ok", expires_in: 1.minute)
      value = Rails.cache.read(test_key)

      if value == "ok"
        render json: { status: "success", message: "Redis cache is working!" }
      else
        render json: { status: "error", message: "Failed to read back from Redis cache." }, status: 500
      end
    rescue => e
      render json: { status: "error", message: e.message }, status: 500
    end
  end
end
