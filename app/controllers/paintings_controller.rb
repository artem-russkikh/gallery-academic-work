class PaintingsController < ApplicationController
  autocomplete :user, :email
  autocomplete :painting_kind, :title

  before_action :set_painting, only: [:show, :edit, :update, :destroy]
  before_action :permission_check, only: [:new, :create, :destroy, :update, :edit]

  # GET /paintings
  # GET /paintings.json
  def index
    @paintings = Painting.all

    respond_to do |format|
      format.html { render 'index'  }
      format.xlsx { render xlsx: 'index', filename: 'paintings.xlsx' }
    end
  end

  # GET /paintings/1
  # GET /paintings/1.json
  def show
  end

  # GET /paintings/new
  def new
    @painting = Painting.new
  end

  # GET /paintings/1/edit
  def edit
  end

  # POST /paintings
  # POST /paintings.json
  def create
    @painting = Painting.new(painting_params)
    @painting = current_user.paintings.new(painting_params) if current_user.painter?

    respond_to do |format|
      if @painting.save
        format.html { redirect_to @painting, notice: 'Картина была успешно создана.' }
        format.json { render :show, status: :created, location: @painting }
      else
        format.html { render :new }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paintings/1
  # PATCH/PUT /paintings/1.json
  def update
    respond_to do |format|
      if @painting.update(painting_params)
        format.html { redirect_to @painting, notice: 'Картина была успешно обновлена.' }
        format.json { render :show, status: :ok, location: @painting }
      else
        format.html { render :edit }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    flash[:error] = "Другой пользователь применил изменения к данной записи, попробуйте еще раз."
    render :edit
  end

  # DELETE /paintings/1
  # DELETE /paintings/1.json
  def destroy
    @painting.destroy
    respond_to do |format|
      format.html { redirect_to paintings_url, notice: 'Картина была успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    def permission_check
      return not_authorized! if guest?
      return true if current_user && current_user.manager?
      return true if current_user && current_user.admin?
      return not_authorized! if ['edit', 'update', 'destroy'].include?(action_name) && @painting.user_id != current_user.id
    end

    def not_authorized!
      flash[:alert] = 'Вы не авторизованы для этого действия'
      redirect_back fallback_location: root_url
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_painting
      @painting = Painting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def painting_params
      params.require(:painting).permit(:lock_version, :title, :painting_kind_id, :user_id, :image)
    end
end
