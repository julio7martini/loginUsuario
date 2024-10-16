<%@ page import="loginUser.Usuario, loginUser.UsuarioDAO" %>
<%
    // Obt�m os par�metros "email" e "senha" da requisi��o
    String vEmail = request.getParameter("email");
    String vSenha = request.getParameter("senha");

    // Cria uma inst�ncia de Usuario e configura o email e senha
    Usuario usu = new Usuario();
    usu.setEmail(vEmail);
    usu.setSenha(vSenha);

    try {
        // Busca o usu�rio no banco de dados atrav�s do DAO
        usu = UsuarioDAO.buscarPorEmail(vEmail);

        // Verifica se o usu�rio existe
        if (usu != null) {
            // Verifica se o usu�rio est� bloqueado
            if (usu.isBloqueado()) {
                // Redireciona para p�gina de usu�rio bloqueado
                response.sendRedirect("usuarioBloqueado.jsp");
            } else {
                // Tenta autenticar o usu�rio
                if (usu.autenticarUsuario(vSenha)) {
                    // Resetar tentativas ap�s sucesso no login
                    usu.setTentativas(0);
                    UsuarioDAO.atualizarTentativas(usu);

                    // Define o email do usu�rio na sess�o
                    session.setAttribute("usuario", vEmail);

                    // Redireciona para a p�gina "menu.jsp"
                    response.sendRedirect("menu.jsp");
                } else {
                    // Incrementa o n�mero de tentativas falhas
                    int tentativas = usu.getTentativas() + 1;
                    usu.setTentativas(tentativas);

                    // Se o n�mero de tentativas for 3 ou mais, bloqueia o usu�rio
                    if (tentativas >= 3) {
                        usu.setBloqueado(true);
                    }

                    // Atualiza o n�mero de tentativas e bloqueio, se aplic�vel
                    UsuarioDAO.atualizarTentativas(usu);

                    // Redireciona de volta para a p�gina de login com erro de senha incorreta
                    response.sendRedirect("login.jsp?erro=senha_incorreta");
                }
            }
        } else {
            // Se o usu�rio n�o for encontrado, redireciona para "usuarioNaoCadastrado.html"
            response.sendRedirect("usuarioNaoCadastrado.html");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Caso ocorra um erro inesperado, redireciona para uma p�gina de erro geral
        response.sendRedirect("erro.jsp");
    }
%>
