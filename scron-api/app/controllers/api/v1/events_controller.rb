module Api::V1
  class EventsController < ApiController

    skip_before_filter :verify_authenticity_token, :only => [:create]

    # POST /v1/event
    def create
      respond_to do |format|
        format.xml  { json: params.to_xml }
        format.json { json: params.to_json}
      end
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