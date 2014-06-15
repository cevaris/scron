module Api::V1
  class EventsController < ApiController

    skip_before_filter :verify_authenticity_token, :only => [:create]

    # POST /v1/event
    def create
      render json: params.to_json
    end

    # POST /v1/event
    def destroy
      respond_to do |format|
        format.xml  { head :ok }
        format.json { head :ok }
      end
    end

  end
end