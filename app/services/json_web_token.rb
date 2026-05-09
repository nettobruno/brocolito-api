class JsonWebToken
  # A chave secreta é usada para assinar e verificar os tokens JWT. É importante mantê-la segura e não expô-la publicamente. Neste exemplo, estamos usando a chave secreta do Rails, que é uma prática comum.
  # Com ela, podemos garantir que os tokens gerados pela nossa aplicação sejam confiáveis e não possam ser facilmente falsificados por terceiros. Se alguém tentar criar um token falso, ele não passará na verificação, pois não terá a assinatura correta.
  SECRET_KEY = Rails.application.secret_key_base

  # O método encode é responsável por criar um token JWT a partir de um payload (dados que queremos incluir no token). Ele usa a biblioteca JWT para codificar o payload com a chave secreta. O resultado é uma string que representa o token JWT, que pode ser enviado para o cliente e usado para autenticação em futuras requisições.
  # utilizamos self.encode para definir um método de classe, o que significa que podemos chamar JsonWebToken.encode(payload) sem precisar instanciar a classe. O payload geralmente inclui informações como o ID do usuário e a data de expiração do token, mas pode conter qualquer dado que seja relevante para a autenticação.
  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  # O método decode é responsável por decodificar um token JWT e verificar sua validade. Ele recebe o token como argumento, tenta decodificá-lo usando a chave secreta e retorna o payload decodificado em um formato de hash com acesso indiferente a símbolos ou strings. Se o token for inválido ou tiver sido adulterado, ele captura a exceção JWT::DecodeError e retorna nil, indicando que a autenticação falhou.
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY).first
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError
    nil
  end
end