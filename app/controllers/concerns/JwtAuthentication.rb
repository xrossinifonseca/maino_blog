
module JwtAuthentication



  def authenticate(cookies)
      token = cookies.signed[:auth_session]

    if token.blank?
      render_forbidden("Unauthorized")
      return nil
    end

    decoded_token = decode_token(token)

    if decoded_token.nil?
      render_unauthorized("Unauthorized")
      return nil
    end

    decoded_token
  end



  private
  def render_unauthorized(message)
    render json: { error: message }, status: :unauthorized
  end

  def render_forbidden(message)
    render json: { error: message }, status: :forbidden
  end

end
