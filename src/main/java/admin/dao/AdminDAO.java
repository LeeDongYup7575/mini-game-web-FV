package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import auth.dto.UsersDTO;
import ban.dto.BanDTO;

public class AdminDAO {
	private AdminDAO() {

	};

	private static AdminDAO instance;

	public static synchronized AdminDAO getInstance() {
		if (instance == null) {
			instance = new AdminDAO();

		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	public List<String> getLineChartData() throws Exception {
		List<String> lineChartData = new ArrayList<>();

		String sql = "SELECT m.month, COALESCE((SELECT COUNT(*) FROM users WHERE TRUNC(joindate, 'MM') = TO_DATE(m.month, 'YYYY-MM')), 0) AS newusers FROM (SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE, 'MM'), LEVEL-5), 'YYYY-MM') AS month FROM DUAL CONNECT BY LEVEL <= 5) m ORDER BY m.month";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			while (rs.next()) {
				lineChartData.add(rs.getString(2));
			}
			return lineChartData;

		}
	}

	public List<String> getDoughnutChartData() throws Exception {
		List<String> doughnutChartData = new ArrayList<>();

		String sql = "SELECT NVL(COUNT(U.AGE), 0) FROM (SELECT LEVEL*10 AS AGE_GROUP FROM DUAL CONNECT BY LEVEL <= 5) AG LEFT JOIN (SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-(CASE WHEN TO_NUMBER(SUBSTR(RNUM,1,2))<=TO_NUMBER(TO_CHAR(SYSDATE,'YY')) THEN 2000+TO_NUMBER(SUBSTR(RNUM,1,2)) ELSE 1900+TO_NUMBER(SUBSTR(RNUM,1,2)) END) AS AGE FROM USERS) U ON (U.AGE BETWEEN AG.AGE_GROUP AND AG.AGE_GROUP+9 OR (AG.AGE_GROUP=50 AND U.AGE>=50)) GROUP BY AG.AGE_GROUP ORDER BY AG.AGE_GROUP";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			while (rs.next()) {
				doughnutChartData.add(rs.getString(1));
			}
			return doughnutChartData;
		}

	}

	public List<String> getBarChartData() throws Exception {
		List<String> barChartData = new ArrayList<>();

		String sql = "SELECT g.seq, COALESCE(COUNT(r.gameid), 0) FROM GAMES g LEFT JOIN GAMERECORD r ON g.seq = r.gameid GROUP BY g.seq ORDER BY g.seq";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {

			while (rs.next()) {
				barChartData.add(rs.getString(2));
			}
			return barChartData;
		}
	}

	public int getTodayVisit() throws Exception {
		String sql = "SELECT COALESCE((SELECT COUNT(*) FROM USERS WHERE TRUNC(lastlogin, 'DD') = TRUNC(SYSDATE, 'DD')), 0) FROM DUAL";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}

	}

	public int getTodayPost() throws Exception {
		String sql = "SELECT COALESCE((SELECT COUNT(*) FROM board WHERE TRUNC(writedate, 'DD') = TRUNC(SYSDATE, 'DD')), 0) FROM DUAL";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	public int getTodayPlayGame() throws Exception {
		String sql = "SELECT COALESCE((SELECT COUNT(*) FROM GAMERECORD WHERE TRUNC(playtime, 'DD') = TRUNC(SYSDATE, 'DD')), 0) FROM DUAL";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	public int getOnlineUser() throws Exception {
		String sql = "SELECT COALESCE((SELECT COUNT(*) FROM users WHERE status = 0), 0) FROM DUAL";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	public List<UsersDTO> getNewUserList() throws Exception {
		String sql = "select * from (select * from users order by joindate desc) where rownum <=3";
		List<UsersDTO> newUserList = new ArrayList<>();

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			while (rs.next()) {
				UsersDTO user = new UsersDTO(rs.getString("id"), rs.getString("pw"), rs.getString("name"),
						rs.getString("nickname"), rs.getString("phone"), rs.getString("email"), rs.getString("rnum"),
						rs.getTimestamp("joinDate"), rs.getInt("warningCount"), rs.getInt("withdraw"),
						rs.getInt("status"), rs.getInt("isAdmin"), rs.getTimestamp("lastLogin"));
				newUserList.add(user);
			}
			return newUserList;
		}
	}

	public List<UsersDTO> selectFromTotalUsersList(int start, int end) throws Exception {
		String sql = "select * from (select users.*,row_number() over(order by users.joindate desc) AS rownumber from users) where rownumber between ? and ? order by joindate desc";
		List<UsersDTO> totalUserList = new ArrayList<>();
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, start);
			pstat.setInt(2, end);
			try (ResultSet rs = pstat.executeQuery();) {

				while (rs.next()) {
					UsersDTO user = new UsersDTO(rs.getString("id"), rs.getString("pw"), rs.getString("nickname"),
							rs.getString("name"), rs.getString("phone"), rs.getString("email"), rs.getString("rnum"),
							rs.getTimestamp("joinDate"), rs.getInt("warningCount"), rs.getInt("withdraw"),
							rs.getInt("status"), rs.getInt("isAdmin"), rs.getTimestamp("lastLogin"));
					totalUserList.add(user);
				}
				return totalUserList;
			}
		}
	}

	public int getRecordUserListCount() throws Exception {
		String sql = "select count(*) from users";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	public UsersDTO searchByNickName(String nickName) throws Exception {
		String sql = "select * from users where nickname = ? ";
		UsersDTO user = new UsersDTO(sql, sql, sql, sql, sql, sql, sql, null, 0, 0, 0, 0, null);
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, nickName);
			try (ResultSet rs = pstat.executeQuery();) {
				while (rs.next()) {

					user = new UsersDTO(rs.getString("id"), rs.getString("pw"), rs.getString("name"),
							rs.getString("nickname"), rs.getString("phone"), rs.getString("email"),
							rs.getString("rnum"), rs.getTimestamp("joinDate"), rs.getInt("warningCount"),
							rs.getInt("withdraw"), rs.getInt("status"), rs.getInt("isAdmin"),
							rs.getTimestamp("lastLogin"));
				}
				return user;
			}
		}
	}
}
