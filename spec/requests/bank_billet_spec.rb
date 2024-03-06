require 'rails_helper'
require 'pry'

RSpec.describe BankBillet, type: :request do
  describe 'POST /bank_billets' do
    let(:bank_billet_params) { FactoryBot.attributes_for(:bank_billet) }

    context 'when API call is successful' do
      before do
        allow(BoletoSimples::BankBillet).to receive(:create).and_return(
          double('BankBillet', persisted?: true, attributes: bank_billet_params)
        )

        allow(BoletoSimples::BankBillet).to receive(:all).and_return([])
      end

      it 'creates a new BankBillet and redirects to the bank billets index with a notice' do
        post bank_billets_path, params: { bank_billet: bank_billet_params }
        expect(response).to redirect_to(bank_billets_url)
        follow_redirect!
        expect(flash[:notice]).to eq('Boleto criado com sucesso.')
      end
    end

    context 'when API call fails' do
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

  describe 'CANCEL /bank_billets/:id' do
    let(:bank_billet) { FactoryBot.create(:bank_billet) }

    context 'when API call is successful' do
      before do
        allow(BoletoSimples::BankBillet).to receive(:cancel).and_return(
          double('BankBillet', response_errors: [])
        )
      end

      it 'cancels the BankBillet and redirects to the bank billets index with a notice' do
        post cancel_bank_billet_path(bank_billet.id)
        expect(response).to redirect_to(bank_billets_url)
        expect(flash[:notice]).to eq('Boleto cancelado com sucesso.')
      end
    end

    context 'when API call fails' do
      before do
        allow(BoletoSimples::BankBillet).to receive(:cancel).and_return(
          double('BankBillet', response_errors: ['error'])
        )
      end

      it 'does not cancel the BankBillet and redirects to the bank billets index with an alert' do
        post cancel_bank_billet_path(bank_billet.id)
        expect(response).to redirect_to(bank_billets_url)
        expect(flash[:alert]).to eq('Erro ao cancelar o Boleto na API.')
      end
    end
  end

  describe 'PAY /bank_billets/:id' do
    let(:bank_billet) { FactoryBot.create(:bank_billet) }

    context 'when API call is successful' do
      before do
        allow(BoletoSimples::BankBillet).to receive(:find).and_return(bank_billet)
        allow(BoletoSimples::BankBillet).to receive(:pay).and_return(
          double('BankBillet', response_errors: [])
        )
      end

      it 'paid the BankBillet and redirects to the bank billets index with a notice' do
        post pay_bank_billet_path(bank_billet.id)
        expect(response).to redirect_to(bank_billets_url)
        expect(flash[:notice]).to eq('Boleto pago com sucesso.')
      end
    end

    context 'when API call fails' do
      before do
        allow(BoletoSimples::BankBillet).to receive(:find).and_return(bank_billet)
        allow(BoletoSimples::BankBillet).to receive(:pay).and_return(
          double('BankBillet', response_errors: ['error'])
        )
      end

      it 'does not pay the BankBillet and redirects to the bank billets index with an alert' do
        post pay_bank_billet_path(bank_billet.id)
        expect(response).to redirect_to(bank_billets_url)
        expect(flash[:alert]).to eq('Erro ao pagar o boleto na API.')
      end
    end
  end

  describe 'PATCH /bank_billets/:id' do
    let(:bank_billet) { FactoryBot.create(:bank_billet) }
    let(:valid_attributes) { { boleto_simples_bank_billet: FactoryBot.attributes_for(:bank_billet) } }
    let(:invalid_attributes) { { boleto_simples_bank_billet: { amount: nil, description: '', expire_at: '' } } }

    before do
      allow(BoletoSimples::BankBillet).to receive(:find).and_return(bank_billet)
    end

    context 'when API call is successful' do
      before do
        allow(bank_billet).to receive(:save).and_return(double('BankBillet', persisted?: true))

        allow(BoletoSimples::BankBillet).to receive(:all).and_return([])
      end

      it 'updates the bank billet and redirects to the bank billets index with a notice' do
        patch bank_billet_path(bank_billet), params: valid_attributes
        expect(response).to redirect_to(bank_billets_url)
        follow_redirect!
        expect(flash[:notice]).to eq('Boleto alterado com sucesso.')
      end
    end

    context 'when API call fails' do
      before do
        allow(bank_billet).to receive(:update).and_return(double('BankBillet', persisted?: false))
      end

      it 'does not update the bank billet and re-renders the edit template with an alert' do
        patch bank_billet_path(bank_billet), params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('Erro ao alterar o Boleto na API.')
      end
    end
  end

  describe 'GET #show' do
    let(:bank_billet) { FactoryBot.create(:bank_billet) }

    before do
      allow(BoletoSimples::BankBillet).to receive(:find).with(bank_billet.id.to_s).and_return(bank_billet)
    end

    context 'when API call is successful' do
      it 'renders the show template with bank billet details' do
        get bank_billet_path(bank_billet), params: { id: bank_billet.id }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(bank_billet.amount.to_s)
      end
    end
  end
end
