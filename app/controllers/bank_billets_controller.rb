# frozen_string_literal: true

require 'pry'
class BankBilletsController < ApplicationController
  before_action :set_bank_billet, only: %i[show edit update destroy]

  # GET /bank_billets or /bank_billets.json
  def index
    current_hour = Time.now.beginning_of_hour
    @bank_billets = Rails.cache.fetch(['bank_billets', current_hour], expires_in: 1.hour) do
      Rails.logger.info 'Fetching bank billets from API'
      BoletoSimples::BankBillet.all(page: 1, per_page: 50)
    end
  end

  # GET /bank_billets/1 or /bank_billets/1.json
  def show; end

  # GET /bank_billets/new
  def new
    @bank_billet = BankBillet.new
  end

  # GET /bank_billets/1/edit
  def edit; end

  # GET /bank_billets/mock_data
  def mock_data
    @bank_billet = FactoryBot.build(:bank_billet)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('bank_billet_form', partial: 'form',
                                                                      locals: { bank_billet: @bank_billet })
      end
      format.html { render :new }
    end
  end

  # POST /bank_billets or /bank_billets.json
  def create
    @bank_billet_api = BoletoSimples::BankBillet.create(bank_billet_params)

    respond_to do |format|
      if @bank_billet_api.persisted?
        format.html { redirect_to bank_billets_url, notice: 'Boleto criado com sucesso.' }
        format.json { render :show, status: :created, location: @bank_billet }
      else
        flash.now[:alert] = 'Erro ao criar o Boleto na API.'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bank_billet_api.response_errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_billets/1 or /bank_billets/1.json
  def update
    respond_to do |format|
      if @bank_billet.update(bank_billet_params)
        format.html { redirect_to bank_billet_url(@bank_billet), notice: 'Bank billet was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank_billet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bank_billet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_billets/1 or /bank_billets/1.json
  def destroy
    @bank_billet.destroy!

    respond_to do |format|
      format.html { redirect_to bank_billets_url, notice: 'Bank billet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bank_billet
    @bank_billet = BankBillet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bank_billet_params
    params.require(:bank_billet).permit(:amount, :description, :expire_at, :customer_address,
                                        :customer_address_complement, :customer_address_number, :customer_city_name, :customer_cnpj_cpf, :customer_email, :customer_neighborhood, :customer_person_name, :customer_person_type, :customer_phone_number, :customer_state, :customer_zipcode)
  end
end
