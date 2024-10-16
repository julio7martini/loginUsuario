package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
	public static Connection conectar() throws ClassNotFoundException {
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/gerenciador_tarefas";
		String user = "root";
		String password = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user, password);
		} catch (SQLException ex)

		{
			System.out.println("Erro ao conectar com o banco " + ex);

		}
		return con;

	}
}
