module PasswordProtectedHelpers
  def authenticate headers
    error!({:error => {
      :code => 'bad_password', 
      :message => 'bad password'}}
    ) unless headers['Password'] == ENV['HEADER_PASSWORD']
  end

  # extend all endpoints to include this
  Grape::Endpoint.send :include, self
end
