<%@ page import="loginUser.Usuario, loginUser.UsuarioDAO" %>
<%
    // Obtém os parâmetros "email" e "senha" da requisição
    String vEmail = request.getParameter("email");
    String vSenha = request.getParameter("senha");

    // Cria uma instância de Usuario e configura o email e senha
    Usuario usu = new Usuario();
    usu.setEmail(vEmail);
    usu.setSenha(vSenha);

    try {
        // Busca o usuário no banco de dados através do DAO
        usu = UsuarioDAO.buscarPorEmail(vEmail);

        // Verifica se o usuário existe
        if (usu != null) {
            // Verifica se o usuário está bloqueado
            if (usu.isBloqueado()) {
                // Redireciona para página de usuário bloqueado
                response.sendRedirect("usuarioBloqueado.jsp");
            } else {
                // Tenta autenticar o usuário
                if (usu.autenticarUsuario(vSenha)) {
                    // Resetar tentativas após sucesso no login
                    usu.setTentativas(0);
                    UsuarioDAO.atualizarTentativas(usu);

                    // Define o email do usuário na sessão
                    session.setAttribute("usuario", vEmail);

                    // Redireciona para a página "menu.jsp"
                    response.sendRedirect("menu.jsp");
                } else {
                    // Incrementa o número de tentativas falhas
                    int tentativas = usu.getTentativas() + 1;
                    usu.setTentativas(tentativas);

                    // Se o número de tentativas for 3 ou mais, bloqueia o usuário
                    if (tentativas >= 3) {
                        usu.setBloqueado(true);
                    }

                    // Atualiza o número de tentativas e bloqueio, se aplicável
                    UsuarioDAO.atualizarTentativas(usu);

                    // Redireciona de volta para a página de login com erro de senha incorreta
                    response.sendRedirect("login.jsp?erro=senha_incorreta");
                }
            }
        } else {
            // Se o usuário não for encontrado, redireciona para "usuarioNaoCadastrado.html"
            response.sendRedirect("usuarioNaoCadastrado.html");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Caso ocorra um erro inesperado, redireciona para uma página de erro geral
        response.sendRedirect("erro.jsp");
    }
%>
