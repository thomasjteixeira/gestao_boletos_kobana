require 'rails_helper'
require 'pry'

RSpec.describe BankBillet, type: :request do
  describe 'POST /bank_billets' do
    let(:bank_billet_params) { FactoryBot.attributes_for(:bank_billet) }

    context 'when the request is valid and the API call is successful' do
      before do
        allow(BoletoSimples::BankBillet).to receive(:create).and_return(double('BankBillet', persisted?: true))
      end

      it 'creates a new BankBillet and redirects to the bank billets index with a notice' do
        post bank_billets_path, params: { bank_billet: bank_billet_params }
        expect(response).to redirect_to(bank_billets_url)
        follow_redirect!
        expect(flash[:notice]).to eq('Boleto criado com sucesso.')
      end
    end

    context 'when the request is valid but the API call fails' do
      before do
        allow(BoletoSimples::BankBillet).to receive(:create).and_return(double('BankBillet', persisted?: false))
      end

      it 'does not create a new BankBillet and redirects to the new bank billet path with an alert' do
        post bank_billets_path, params: { bank_billet: bank_billet_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('Erro ao criar o Boleto na API.')
      end
    end
  end
end
