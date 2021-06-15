module LoginMacros
  def login_admin
    admin = Admin.create!(email: 'admin@paynow.com.br',
                          password: '123456')

    login_as admin, scope: :admin
  end

  def login_user
    user = User.create!(email: 'user@codeplay.com.br',
                        password: '123456')

    login_as user, scope: :user
  end

  def login_company_user
    company = Company.create!(corporate_name: 'CodeSaga S.A',
                              cnpj: '55477618000176',
                              billing_address: 'Passagem Pacaembu',
                              billing_email: 'faturamento@codesaga.com.br',
                              token: SecureRandom.base58(20))

    company_user = User.create!(email: 'user@codesaga.com.br',
                                password: '123456', company: company)

    login_as company_user, scope: :user
  end
end
