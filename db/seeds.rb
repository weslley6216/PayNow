#Paynow Admin Users
Admin.create!(email: 'admin@paynow.com.br', password: '123456')
Admin.create!(email: 'admin2@paynow.com.br', password: '123456')

#Registered means of payment
bank_slip = PaymentMethod.create!(name: 'Boleto Banco Laranja',
                                  tax: 8, max_tax: 40,
                                  status: true, form_of_payment: 1)

credit_card = PaymentMethod.create!(name: 'Cartão de Crédito MestreCard',
                                    tax: 15, max_tax: 50,
                                    status: true, form_of_payment: 2)

pix = PaymentMethod.create!(name: 'Pix Banco Roxinho',
                            tax: 6, max_tax: 25,
                            status: true, form_of_payment: 3)

PaymentMethod.create!(name: 'Boleto Banco Azul',
                      tax: 14.5, max_tax: 68.9,
                      status: false, form_of_payment: 1)

PaymentMethod.create!(name: 'Cartão de Crédito PISA',
                      tax: 7, max_tax: 89.9,
                      status: false, form_of_payment: 2)

# Registered Companies
company1 = Company.create!(corporate_name: 'CodePlay S.A',
                           cnpj: '55477618000139',
                           billing_address: 'Passagem Morumbi',
                           billing_email: 'faturamento@codeplay.com.br',
                           token: SecureRandom.base58(20))

company2 = Company.create!(corporate_name: 'CodeSaga S.A',
                           cnpj: '38201880001939',
                           billing_address: 'Alameda Santos',
                           billing_email: 'faturamento@codesaga.com.br',
                           token: SecureRandom.base58(20))

company3 = Company.create!(corporate_name: 'CodeWars S.A',
                           cnpj: '54201220001939',
                           billing_address: 'Passagem Pacaembu',
                           billing_email: 'faturamento@codewars.com.br',
                           token: SecureRandom.base58(20))

#Paynow customers and their respective companies
User.create!(email: 'user@codeplay.com.br', password: '123456', company: company1)
User.create!(email: 'user@codesaga.com.br', password: '123456', company: company2)
User.create!(email: 'user@codewars.com.br', password: '123456', company: company3)

#Payment methods contracted by customers
BankSlip.create!(bank_number: '341', agency_number: '1690', account_number: '6557827',
                 payment_method: bank_slip, company: company1)

BankSlip.create!(bank_number: '237', agency_number: '0916', account_number: '728827',
                 payment_method: bank_slip, company: company2)

CreditCard.create!(credit_code: 'zaRT648dV545t24591ZU',
                   payment_method: credit_card, company: company3)

CreditCard.create!(credit_code: 'meRT648dV545t24591ZU',
                   payment_method: credit_card, company: company1)

Pix.create!(bank_number: '001', pix_key: 'x67Hu7dV545t24591ZU1',
            payment_method: pix, company: company2)

Pix.create!(bank_number: '001', pix_key: 'a46Hu7dV545t24591ZU1',
            payment_method: pix, company: company3)

#Products registered by customers
Product.create!(name: 'Ruby', price: 210, bank_slip_discount: 4,
                credit_card_discount: 5, pix_discount: 6,
                token: SecureRandom.base58(20), company: company1)


Product.create!(name: 'Ruby on Rails', price: 325, bank_slip_discount: 8,
                credit_card_discount: 9, pix_discount: 10,
                token: SecureRandom.base58(20), company: company1)


Product.create!(name: 'Desafios de Ruby', price: 99, bank_slip_discount: 10,
                credit_card_discount: 5, pix_discount: 8,
                token: SecureRandom.base58(20), company: company2)

Product.create!(name: 'Desafios de RoR', price: 134.9, bank_slip_discount: 7,
                credit_card_discount: 2, pix_discount: 3,
                token: SecureRandom.base58(20), company: company2)


Product.create!(name: 'Código Limpo', price: 174.9, bank_slip_discount: 15,
                credit_card_discount: 5, pix_discount: 10,
                token: SecureRandom.base58(20), company: company3)


Product.create!(name: 'Aprendendo Algorítmos', price: 49.9, bank_slip_discount: 18,
                credit_card_discount: 6, pix_discount: 12,
                token: SecureRandom.base58(20), company: company3)

FinalClient.create!(name: 'João Silva', cpf: '12345678910',
                    token: SecureRandom.base58(20))

Charge.create!(original_value: 49.9, discounted_amount: 40.9, status: :pending,
               payment_method: PaymentMethod.first, company: Company.first,
               final_client: FinalClient.first, product: Product.last)

puts 'Banco de Dados Populado com Sucesso!'
