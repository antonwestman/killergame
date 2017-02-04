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

  def post_with_user(user, path, **args)
    headers = (args[:headers] || {}).merge(auth_header(user))
    post path, params: args[:params],
               headers: headers
  end

  def delete_with_user(user, path, **args)
    headers = (args[:headers] || {}).merge(auth_header(user))
    delete path, params: args[:params],
                 headers: headers
  end

  def response_data
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def auth_header(user)
    # Note: This persists the user
    user.create_new_auth_token
  end
end
