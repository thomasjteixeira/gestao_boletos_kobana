# frozen_string_literal: true

require 'pry'
class BankBilletsController < ApplicationController
  before_action :set_bank_billet, only: %i[show edit update]

  # GET /bank_billets or /bank_billets.json
  def index
    @bank_billets = BoletoSimples::BankBillet.all(page: 1, per_page: 50).sort_by(&:created_at).reverse
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
    @bank_billet = BankBillet.new(bank_billet_params)

    if @bank_billet_api.persisted?
      redirect_to bank_billets_url, notice: 'Boleto criado com sucesso.'
    else
      flash.now[:alert] = 'Erro ao criar o Boleto na API.'
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bank_billets/1 or /bank_billets/1.json
  def update
    @bank_billet.assign_attributes(bank_billet_update_params)
    if @bank_billet.save
      redirect_to bank_billets_url, notice: 'Boleto alterado com sucesso.'
    else
      flash.now[:alert] = 'Erro ao alterar o Boleto na API.'
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bank_billets/1 or /bank_billets/1.json
  def destroy; end

  def cancel
    @bank_billet = BoletoSimples::BankBillet.cancel(id: params[:id])

    if @bank_billet.response_errors.empty?
      redirect_to bank_billets_url, notice: 'Boleto cancelado com sucesso.'
    else
      redirect_to bank_billets_url, alert: 'Erro ao cancelar o Boleto na API.'
    end
  end

  def pay
    @bank_billet_to_pay = BoletoSimples::BankBillet.find(params[:id])
    @bank_billet = BoletoSimples::BankBillet.pay(id: params[:id], paid_at: Date.today.to_s,
                                                 paid_amount: @bank_billet_to_pay.amount,
                                                 bank_rate: 1.1, direct_payment: true)

    if @bank_billet.response_errors.empty?
      redirect_to bank_billets_url, notice: 'Boleto pago com sucesso.'
    else
      redirect_to bank_billets_url, alert: 'Erro ao pagar o boleto na API.'
    end
  end

  private

  def set_bank_billet
    @bank_billet = BoletoSimples::BankBillet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bank_billet_params
    params.require(:bank_billet).permit(:amount, :description, :expire_at, :customer_address,
                                        :customer_address_complement, :customer_address_number, :customer_city_name,
                                        :customer_cnpj_cpf, :customer_email, :customer_neighborhood,
                                        :customer_person_name, :customer_person_type, :customer_phone_number,
                                        :customer_state, :customer_zipcode)
  end

  def bank_billet_update_params
    params.require(:boleto_simples_bank_billet).permit(:amount, :expire_at, :description)
  end
end
