class PaintingKindsController < ApplicationController
  before_action :set_painting_kind, only: [:show, :edit, :update, :destroy]

  # GET /painting_kinds
  # GET /painting_kinds.json
  def index
    @painting_kinds = PaintingKind.all

    respond_to do |format|
      format.html { render 'index'  }
      format.xlsx { render xlsx: 'index', filename: 'painting_kinds.xlsx' }
    end
  end

  # GET /painting_kinds/1
  # GET /painting_kinds/1.json
  def show
  end

  # GET /painting_kinds/new
  def new
    @painting_kind = PaintingKind.new
  end

  # GET /painting_kinds/1/edit
  def edit
  end

  # POST /painting_kinds
  # POST /painting_kinds.json
  def create
    @painting_kind = PaintingKind.new(painting_kind_params)

    respond_to do |format|
      if @painting_kind.save
        format.html { redirect_to @painting_kind, notice: 'Вид картины был успешно создан.' }
        format.json { render :show, status: :created, location: @painting_kind }
      else
        format.html { render :new }
        format.json { render json: @painting_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /painting_kinds/1
  # PATCH/PUT /painting_kinds/1.json
  def update
    respond_to do |format|
      if @painting_kind.update(painting_kind_params)
        format.html { redirect_to @painting_kind, notice: 'Вид картины был успешно обновлен.' }
        format.json { render :show, status: :ok, location: @painting_kind }
      else
        format.html { render :edit }
        format.json { render json: @painting_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /painting_kinds/1
  # DELETE /painting_kinds/1.json
  def destroy
    @painting_kind.destroy
    respond_to do |format|
      format.html { redirect_to painting_kinds_url, notice: 'Вид картины был успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_painting_kind
      @painting_kind = PaintingKind.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def painting_kind_params
      params.require(:painting_kind).permit(:title)
    end
end
