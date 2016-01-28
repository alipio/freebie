class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :find_post
  before_action :authenticate_user!

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = @post.requests.build
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
   # @request = Request.new(request_params)
    @request = @post.requests.build(request_params)
    @request.user_id = current_user.id
    subject = I18n.t("email.request_subject", {user_name: current_user.display_name, post_name: @post.title})
    @request.mailboxer_conversation_id = current_user.send_message(@post.user, request_params[:content], subject).conversation.id

    if @request.save
        render plain: @post.requests.count
    else
        render plain: @request.errors
    end
  end

  def accept
    @request = Request.find(params[:request_id])
    @request.status = true
    if @request.save
      respond_to do |format|
        format.js { render "request_list.js.erb" }
      end
    else
        render plain: @request.errors
    end
  end

  def cancel
    @request = Request.find(params[:request_id])
    @request.status = false
    if @request.save
      respond_to do |format|
        format.js { render "request_list.js.erb" }
      end
    else
        render plain: @request.errors
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    def find_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:content, :post_id, :user_id)
    end
end
