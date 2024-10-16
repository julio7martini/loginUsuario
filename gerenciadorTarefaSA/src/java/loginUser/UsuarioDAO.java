package loginUser;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Conexao;

public class UsuarioDAO {

    // Método para buscar um usuário pelo email
    public static Usuario buscarPorEmail(String email) throws ClassNotFoundException {
        Connection con = Conexao.conectar();
        Usuario usu = null;
        String sql = "SELECT * FROM usuario WHERE email = ?";
        
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                usu = new Usuario();
                usu.setEmail(rs.getString("email"));
                usu.setSenha(rs.getString("senha"));
                usu.setTentativas(rs.getInt("tentativas"));
                usu.setBloqueado(rs.getBoolean("bloqueado"));
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar usuário por email.");
        }
        
        return usu;
    }

    // Método para atualizar as tentativas de login e bloqueio do usuário
    public static boolean atualizarTentativas(Usuario usu) throws ClassNotFoundException {
        Connection con = Conexao.conectar();
        String sql = "UPDATE usuario SET tentativas = ?, bloqueado = ? WHERE email = ?";
        
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, usu.getTentativas());
            stm.setBoolean(2, usu.isBloqueado());
            stm.setString(3, usu.getEmail());
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Erro ao atualizar tentativas do usuário.");
            return false;
        }
    }
}
