<!DOCTYPE html>  
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bem Vindo!</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Arial', sans-serif;
      color: #333;
    }

    .navbar {
      background-color: #0056b3;
    }

    .navbar-brand {
      font-size: 24px;
      font-weight: bold;
    }

    #sidebar-wrapper {
      background-color: #343a40;
      padding: 15px;
      min-height: 100vh;
    }

    .sidebar-nav li {
      list-style: none;
      margin: 10px 0;
    }

    .sidebar-nav li a {
      color: #ccc;
      font-size: 16px;
      text-decoration: none;
      display: block;
      padding: 10px;
      border-radius: 5px;
    }

    .sidebar-nav li a:hover {
      background-color: #007bff;
      color: #fff;
    }

    #page-content-wrapper {
      padding: 20px;
      margin-left: 15px;
    }

    h1 {
      font-size: 32px;
      color: #0056b3;
    }

    p {
      font-size: 18px;
      color: #555;
    }

    .container-fluid {
      text-align: center;
    }
  </style>
</head>
<body>
<header>
    <% 
        String email = (String) session.getAttribute("usuario");
        if (email == null){
            response.sendRedirect("usuarioNaoLogado.html");
        }
    %>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a href="#" class="navbar-brand">Gestão de Departamentos</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample02" aria-controls="navbarsExample02" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarsExample02">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Sair</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<div id="wrapper" class="d-flex">
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <li><a href="CadastroHTML.jsp">Nossos Serviços</a></li>
        </ul>
    </div> 
    <div id="page-content-wrapper">
        <div class="container-fluid">
            <h1>Bem Vindo!</h1>
            <p>Utilize nossas ferramentas para auxiliar sua empresa!</p>
        </div>
    </div> 
</div>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>

</body>
</html>
