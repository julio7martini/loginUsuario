<%-- 
    Document   : cadastraUsuario
    Created on : 9 de set. de 2024, 08:04:05
    Author     : Marcio Schoenfelder
--%>

<%@page import="loginUser.Usuario"%>
<%
    // Obt�m os par�metros "email" e "senha" da requisi��o
    String vEmail = request.getParameter("email");
    String vSenha = request.getParameter("senha");
    
    // Cria uma inst�ncia de Usuario e configura o email e senha
    Usuario usu = new Usuario();
    usu.setEmail(vEmail);
    usu.setSenha(vSenha);
    
    // Chama o m�todo para incluir um novo usu�rio
    if (usu.incluirUsuario()) {
        // Se o usu�rio for inclu�do com sucesso, redireciona para a p�gina "index.html"
        response.sendRedirect("index.html");
    }
%>
