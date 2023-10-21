String getFirebaseErrorString(String errorCode) {
  switch (errorCode) {
    case "user-not-found":
      return "Usuário não encontrado.";
    case "wrong-password":
      return "Senha incorreta.";
    case "invalid-email":
      return "E-mail inválido.";
    case "user-disabled":
      return "Usuário desativado.";
    case "too-many-requests":
      return "Muitas tentativas. Tente novamente mais tarde.";
    case "operation-not-allowed":
      return "Operação não permitida.";
    case "INVALID_LOGIN_CREDENTIALS":
      return "E-mail ou senha inválidos.";
    default:
      return "Ocorreu um erro ao tentar fazer login.";
  }
}
