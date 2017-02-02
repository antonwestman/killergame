module RequestSpecHelper
  def get_with_user(user, path, **args)
    headers = (args[:headers] || {}).merge(user.create_new_auth_token)
    get path, params: args[:params],
              headers: headers
  end
end
