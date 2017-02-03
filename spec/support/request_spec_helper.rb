module RequestSpecHelper
  def get_with_user(user, path, **args)
    headers = (args[:headers] || {}).merge(auth_header(user))
    get path, params: args[:params],
              headers: headers
  end

  def put_with_user(user, path, **args)
    headers = (args[:headers] || {}).merge(auth_header(user))
    put path, params: args[:params],
              headers: headers
  end

  private

  def auth_header(user)
    user.create_new_auth_token
  end
end
