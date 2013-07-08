class RequestsController < ApplicationController
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new

    @current_partner_id = session[:current_partner_id] || Partner.where(:app_id => 'html5_vm').first.id 
    @partners = Partner.all
    @request = Request.new

    @request.partner_id = session[:partner_id] if session[:partner_id]
    @request.url        = session[:url]        if session[:url]       
    @request.parametres = session[:parametres] if session[:parametres]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
  end




  # POST /requests
  # POST /requests.json
  def create




    #params[:request] = {"partner_id"=>"1", "url"=>"", "parametres"=>""}
    @request = Request.new(params[:request])
    @full_request = @request.get_full_request
    respond_to do |format|
      if @request.save

        session[:partner_id]=params[:request][:partner_id]
        session[:url]       =params[:request][:url]
        session[:parametres]=params[:request][:parametres]

        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.js {render :new}
        format.json { render json: @request, status: :created, location: @request }
      else

        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end

  def get_out_request
    require "cgi"    
    url_request = CGI::unescape(params[:url_request_param])
    if url_request
      uri = URI.parse(url_request) 
      @responce_after_get_out_request=Net::HTTP.get(uri)
    else
      @responce_after_get_out_request = "get uncorrect url"
    end  



    respond_to do |format|
      format.json {render :json => @responce_after_get_out_request}
      format.js {render :get_out_request}
    end  
  end  
end
