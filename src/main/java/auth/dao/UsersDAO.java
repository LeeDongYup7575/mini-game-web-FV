package auth.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import auth.dto.UsersDTO;

public class UsersDAO {

	// Singleton pattern 적용
	private static UsersDAO instance;

	public synchronized static UsersDAO getInstance() {
		System.out.println("dao 생성");
		if (instance == null) {
			instance = new UsersDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	// 로그인 기능 구현 : 사용자의 아이디와 패스워드를 받아 사용자 인스턴스를 반환
		public UsersDTO login(String id, String pw) throws Exception {
			String sql = "SELECT id, name, nickname, phone, email, warningcount, isadmin, rnum FROM users WHERE id = ? AND pw = ?";

			try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

				pstat.setString(1, id);
				pstat.setString(2, pw);

				try (ResultSet rs = pstat.executeQuery()) {
					if (rs.next()) {
						return new UsersDTO(rs.getString("id"), null, // pw는 반환하지 않음
								rs.getString("nickname"), rs.getString("name"), rs.getString("phone"),
								rs.getString("email"), rs.getString("rnum"), null, rs.getInt("warningcount"), 0, 0,
								rs.getInt("isadmin"), null

						);
					}
				}
			}
			return null;
		}


	// 중복 검사 메서드
	// field - db 칼럼 , value - db 칼럼 값
	public boolean isDuplicate(String field, String value) {
		String query = "SELECT COUNT(*) FROM USERS WHERE " + field + " = ?";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
			pstmt.setString(1, value);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 회원가입 메서드
	public int signup(UsersDTO dto) throws Exception {
		 if (dto.getId().startsWith("google_") && dto.getPw() == null) {
		        dto.setPw("GOOGLE_USER"); // 기본값 설정
		    }
		String sql = "INSERT INTO users(id, pw, nickname, name, phone, email, rnum, joindate, warningcount, withdraw, status, isadmin, lastLogin) "
				+ "VALUES(?, ?, ?, ?, ?, ?, ?, sysdate, 0, 0, 0, 0, sysdate)";

		try (Connection conn = getConnection(); PreparedStatement pstat = conn.prepareStatement(sql)) {

			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPw());
			pstat.setString(3, dto.getNickname());
			pstat.setString(4, dto.getName());
			pstat.setString(5, dto.getPhone());
			pstat.setString(6, dto.getEmail());
			pstat.setString(7, dto.getRnum());

			return pstat.executeUpdate();
		}
	}

	// selectAll
	public List<UsersDTO> userList() throws Exception {
		List<UsersDTO> userList = new ArrayList<>();
		String sql = "SELECT * FROM users";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					UsersDTO user = new UsersDTO(rs.getString("id"), rs.getString("pw"), rs.getString("name"),
							rs.getString("nickname"), rs.getString("phone"), rs.getString("email"),
							rs.getString("rnum"), rs.getTimestamp("joinDate"), rs.getInt("warningCount"),
							rs.getInt("withdraw"), rs.getInt("status"), rs.getInt("isAdmin"),
							rs.getTimestamp("lastLogin"));

					userList.add(user);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return userList;
	}

	public boolean checkPassword(String id, String pw) throws Exception {
		String sql = "SELECT pw FROM users WHERE id = ?";

		UsersDTO dto = null;
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);

			try (ResultSet rs = pstat.executeQuery()) {
				if (rs.next()) {
					String dbPassword = rs.getString("password");
					return dbPassword.equals(pw); // 해싱된 비밀번호 비교할 경우 BCrypt 사용
				}
			}
		}
		return false;
	}

	// 마이페이지
	public UsersDTO myPage(String id) throws Exception {
		String sql = "SELECT * FROM users WHERE id=?";

		UsersDTO dto = null;
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);

			try (ResultSet rs = pstat.executeQuery()) {
				if (rs.next()) {
					dto = new UsersDTO(rs.getString("id"), null, // 비밀번호는 반환하지 않음
							rs.getString("name"), rs.getString("nickname"), rs.getString("phone"),
							rs.getString("email"), null, null, 0, 0, 0, 0, null);
				}
			}
		}
		return dto;
	}

	// 개인정보 수정페이지
	public boolean updateUserDB(UsersDTO updateUser) throws Exception {
		String sql = "UPDATE users SET name=?, email=?, nickname=?, phone=?, rnum=? WHERE id=?";

		boolean success = false;
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setString(1, updateUser.getName());
			pstat.setString(2, updateUser.getEmail());
			pstat.setString(3, updateUser.getNickname());
			pstat.setString(4, updateUser.getPhone());
			pstat.setString(5, updateUser.getRnum());
			pstat.setString(6, updateUser.getId());

			int result = pstat.executeUpdate();

			// 1개 이상의 행이 업데이트되었으면 성공
			if (result > 0) {
				success = true;

			}
		}
		return success;
	}

	public int withdraw(String id) throws Exception { // 탈퇴
		String sql = "delete from users where id = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);
			int result = pstat.executeUpdate();
			return result;
		}
	}

	public String isExistID(String name, String email) throws Exception { // 아이디 찾기
		String sql = "select * from users where name=? and email=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			String id = "";
			pstat.setString(1, name);
			pstat.setString(2, email);
			try (ResultSet rs = pstat.executeQuery();) {
				while (rs.next()) {
					id = rs.getString("id");
				}
				return id;
			}
		}
	}

	public boolean isExistPW(String id, String email) throws Exception { // 비밀번호 찾기
		String sql = "select * from users where id=? and email=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setString(1, id);
			pstat.setString(2, email);

			try (ResultSet rs = pstat.executeQuery();) {
				return rs.next();
			}
		}
	}

	public boolean updatePassword(String id, String email, String newPassword) throws Exception { // 비밀번호 찾기 후 수정

		String sql = "update users set pw = ? where id = ? and email = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, newPassword);
			pstat.setString(2, id);
			pstat.setString(3, email);

			int result = pstat.executeUpdate();
			return result > 0;
		}
	}

	public String getPassword(String id) throws Exception {

		String sql = "select pw from users where id = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);

			try (ResultSet rs = pstat.executeQuery();) {
				if (rs.next()) {
					return rs.getString("pw");
				}
			}
		}
		return null;
	}

	public void insertLastLogin(String id) throws Exception {
		String sql = "update users set lastlogin = sysdate where id = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);
			pstat.executeUpdate();
		}
	}
	
	public UsersDTO findUserByEmail(String email) throws Exception{
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
        	pstat.setString(1, email);
        	try (ResultSet rs = pstat.executeQuery();) {
            if (rs.next()) {
                return new UsersDTO(
                    rs.getString("id"), null, rs.getString("nickname"), rs.getString("name"),
                    rs.getString("phone"), rs.getString("email"), rs.getString("rnum"),
                    rs.getTimestamp("joinDate"), rs.getInt("warningCount"), rs.getInt("withdraw"),
                    rs.getInt("status"), rs.getInt("isAdmin"), rs.getTimestamp("lastLogin")
                );
            }
        	}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

	

    public boolean isNicknameExist(String nickname) throws Exception {
        String sql = "SELECT COUNT(*) FROM users WHERE nickname = ?";
        try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
        	pstat.setString(1, nickname);
        	
            try(ResultSet rs = pstat.executeQuery();){
            	if (rs.next()) {
            		return rs.getInt(1) > 0;
            	}
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public UsersDTO findUserById(String id) throws Exception{

        UsersDTO user = null;
        
        String sql = "SELECT * FROM USERS WHERE ID = ?";
        try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);){
        	
            pstat.setString(1, id);
            
            try (ResultSet rs = pstat.executeQuery();) {
            if (rs.next()) {
                user = new UsersDTO(
                    rs.getString("ID"),
                    rs.getString("PW"),
                    rs.getString("NICKNAME"),
                    rs.getString("NAME"),
                    rs.getString("PHONE"),
                    rs.getString("EMAIL"),
                    rs.getString("RNUM"),
                    rs.getInt("WARNING_COUNT"),
                    rs.getInt("WITHDRAW"),
                    rs.getInt("STATUS"),
                    rs.getInt("ISADMIN")
                );
            }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user;
    }
}
