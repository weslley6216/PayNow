module LoginMacros
  def login_admin
    admin = Admin.create!(email: 'admin@paynow.com',
                          password: '123456')

    login_as admin, scope: :admin

  end
end
