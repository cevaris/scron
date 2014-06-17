module Api::V1
  class EventsController < ApiController

    skip_before_filter :verify_authenticity_token, :only => [:create, :show, :index]

    # GET /v1/events
    def index
      @events = Event.all
      respond_to do |format|
        format.xml  { render xml:  @events }
        format.json { render json: @events }
      end
    end

    # POST /v1/events
    def show
      @event = Event.find(params[:id])
      respond_to do |format|
        format.xml  { render xml:  @event }
        format.json { render json: @event }
      end
    end

    # POST /v1/events
    def create
      @event = Event.new(event_params)
      respond_to do |format|
        if @event.save
          format.xml  { render xml:  @event }
          format.json { render json: @event }
        else
          format.xml  { render xml:  @event.errors }
          format.json { render json: @event.errors }
        end
        
      end
    end

    # POST /v1/events
    def destroy
      respond_to do |format|
        format.xml  { head :ok }
        format.json { head :ok }
      end
    end

    private 


    def event_params
      print "TEST #{params}"
      params.require(:event).permit(:repeat, :execute_at, :fqdn, :command)
    end

  end
end