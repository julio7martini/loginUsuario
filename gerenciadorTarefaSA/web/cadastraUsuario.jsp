<%-- 
    Document   : cadastraUsuario
    Created on : 9 de set. de 2024, 08:04:05
    Author     : Marcio Schoenfelder
--%>

<%@page import="loginUser.Usuario"%>
<%
    // Obtém os parâmetros "email" e "senha" da requisição
    String vEmail = request.getParameter("email");
    String vSenha = request.getParameter("senha");
    
    // Cria uma instância de Usuario e configura o email e senha
    Usuario usu = new Usuario();
    usu.setEmail(vEmail);
    usu.setSenha(vSenha);
    
    // Chama o método para incluir um novo usuário
    if (usu.incluirUsuario()) {
        // Se o usuário for incluído com sucesso, redireciona para a página "index.html"
        response.sendRedirect("index.html");
    }
%>
