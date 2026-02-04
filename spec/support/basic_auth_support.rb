module BasicAuthSupport
  def basic_auth(path)
    return visit(path) if Rails.env.test?

    username = ENV['BASIC_AUTH_USER']
    password = ENV['BASIC_AUTH_PASSWORD']
    visit "http://#{username}:#{password}@#{path}"
  end
end