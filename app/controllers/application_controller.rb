class ApplicationController < ActionController::API
  private

  def authenticate_request
    # Pega o token do header Authorization
    header = request.headers["Authorization"]

    # O token geralmente vem no formato "Bearer <token>", então precisamos extrair apenas o token
    # O header&, só irá tentar acessar o split se header não for nil, evitando erros
    # O split(" ") divide a string em partes usando o espaço como separador, e o last pega a última parte, que é o token em si
    # Se o header for nil, token também será nil, e o decode não será tentado, o que é seguro
    token = header&.split(" ")&.last

    decoded = JsonWebToken.decode(token)

    # Se o token for válido e decodificado com sucesso, ele deve conter o ID do usuário (ou outras informações relevantes). Usamos esse ID para encontrar o usuário correspondente no banco de dados e armazená-lo em @current_user, que estará disponível para os métodos das controllers que herdam de ApplicationController.
    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
    end

    # Se @current_user for nil, significa que a autenticação falhou, então retornamos um erro de "Unauthorized" com status 401. Caso contrário, a requisição continua normalmente, e o usuário autenticado estará disponível através do método current_user.
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  def authorize_admin!
    render json: { error: "Forbidden" }, status: :forbidden unless current_user&.admin?
  end

  def authorize_admin_or_self!
    unless current_user&.admin? || current_user&.id == @user.id
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end
end
