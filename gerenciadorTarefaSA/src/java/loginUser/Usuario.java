package loginUser; 

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Conexao;

public class Usuario {
    private String email;
    private String senha;
    private int id;
    private String permissao;
    private int tentativas;   // Quantidade de tentativas de login
    private boolean bloqueado; // Estado de bloqueio do usuário
    
    // Inclusão de Usuario
    public boolean incluirUsuario() throws ClassNotFoundException {
        String sql = "INSERT INTO usuario (email, senha, tentativas, bloqueado) VALUES (?, ?, 0, false)";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.getEmail());
            stm.setString(2, this.getSenha());
            stm.execute();
        } catch (SQLException e) {
            System.out.println("Erro na inclusão do usuário: " + e.getMessage());
            return false;
        }
        return true;
    }
    
    // Autenticação do usuário
    public boolean autenticarUsuario(String senha) throws ClassNotFoundException {
        Connection con = Conexao.conectar();
        String sql = "SELECT senha, tentativas, bloqueado FROM usuario WHERE email = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.getEmail());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String senhaBanco = rs.getString("senha");
                // Compara a senha fornecida com a armazenada no banco
                if (senhaBanco.equals(senha)) {
                    this.setTentativas(0); // Resetar tentativas em caso de sucesso
                    this.setBloqueado(false); // Desbloquear o usuário
                    return true; // Senha correta
                } else {
                    // Se a senha estiver incorreta, incrementa tentativas
                    this.setTentativas(rs.getInt("tentativas") + 1);
                    // Bloqueia o usuário se as tentativas forem 3 ou mais
                    if (this.getTentativas() >= 3) {
                        this.setBloqueado(true);
                    }
                    return false; // Senha incorreta
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro na autenticação do usuário: " + e.getMessage());
            return false;
        }
        return false; // Usuário não encontrado
    }
    
    // Atualiza o número de tentativas de login e bloqueio
    public void atualizarTentativas() throws ClassNotFoundException {
        Connection con = Conexao.conectar();
        String sql = "UPDATE usuario SET tentativas = ?, bloqueado = ? WHERE email = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.getTentativas());
            stm.setBoolean(2, this.isBloqueado());
            stm.setString(3, this.getEmail());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erro ao atualizar tentativas: " + e.getMessage());
        }
    }
    
    // Redefinir a senha
    public boolean redefinirSenha(String novaSenha, String confirmacaoSenha) throws ClassNotFoundException {
        if (!novaSenha.equals(confirmacaoSenha)) {
            System.out.println("As senhas não coincidem.");
            return false;
        }
        
        Connection con = Conexao.conectar();
        String sql = "UPDATE usuario SET senha = ? WHERE email = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, novaSenha);
            stm.setString(2, this.getEmail());
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Erro ao redefinir senha: " + e.getMessage());
            return false;
        }
    }
    
    // Getters e Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public int getTentativas() {
        return tentativas;
    }

    public void setTentativas(int tentativas) {
        this.tentativas = tentativas;
    }

    public boolean isBloqueado() {
        return bloqueado;
    }

    public void setBloqueado(boolean bloqueado) {
        this.bloqueado = bloqueado;
    }
}
