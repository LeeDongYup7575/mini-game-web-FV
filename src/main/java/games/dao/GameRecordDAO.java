package games.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import games.dto.GameRankingDTO;
import games.dto.GameRecordDTO;
import games.dto.GameRecordRankingDTO;

public class GameRecordDAO {
	// 1. 싱글톤 패턴
	private static GameRecordDAO instance;

	// 2. 싱글톤 패턴
	public synchronized static GameRecordDAO getInstance() {
		if (instance == null) {
			instance = new GameRecordDAO();
		}
		return instance;
	}

	// Tomcat 서버의 DBCP를 사용하여 커넥션을 가져오는 코드(DB 연결 생성)
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); //
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	// 인기게임 순위
	public List<GameRankingDTO> getPopularGames() throws Exception {
		String sql = "SELECT GAMENAME, 플레이횟수, ROW_NUMBER() OVER (ORDER BY 플레이횟수 DESC) AS 순위 FROM (SELECT g.GAMENAME, gr.플레이횟수 FROM games g JOIN (SELECT GAMEID, COUNT(*) AS 플레이횟수 FROM gamerecord GROUP BY GAMEID) gr ON g.SEQ = gr.GAMEID) 게임별플레이횟수";

		List<GameRankingDTO> rankings = new ArrayList<>();

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			while (rs.next()) {
				GameRankingDTO game = new GameRankingDTO(rs.getString("GAMENAME"), rs.getInt("플레이횟수"), rs.getInt("순위"));
				rankings.add(game);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rankings;
	}

	// 게임 기록 정보를 모두 출력하는 함수
	public List<GameRecordDTO> gameRecordList() throws Exception {
		List<GameRecordDTO> gameRecordList = new ArrayList<>();
		String sql = "SELECT * FROM gamerecord";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					GameRecordDTO gameRecord = new GameRecordDTO(rs.getInt("seq"), rs.getString("userid"),
							rs.getInt("gameid"), rs.getInt("record"), rs.getTimestamp("playtime"),
							rs.getTimestamp("duration"));

					gameRecordList.add(gameRecord);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return gameRecordList;
	}
	
	// 게임 기록 정보를 모두 출력하는 함수
		public int getTotalRecord(String nickname) throws Exception {
			
			int totalRecord = 0;
			String sql = "SELECT SUM(record) as total_record FROM gamerecord WHERE userid = ?";

			try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
				pstat.setString(1, nickname);

				try (ResultSet rs = pstat.executeQuery();) {
					while (rs.next()) {
						totalRecord = rs.getInt("total_record");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
			return totalRecord;
		}

	// my page에서 특정 사용자의 게임 리스트를 출력하는 함수
	public GameRecordDTO gameMypage(String userid) throws Exception {

		String sql = "SELECT * FROM gamerecord where userid = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			pstat.setString(1, userid);

			try (ResultSet rs = pstat.executeQuery()) {
				if (!rs.next()) {
					System.out.println("해당 userid에 대한 게임 기록이 없습니다.");
					return null;
				}

				// 결과 처리
				GameRecordDTO gameMypage = new GameRecordDTO(rs.getInt("seq"), rs.getString("userid"),
						rs.getInt("gameid"), rs.getInt("record"), rs.getTimestamp("playtime"),
						rs.getTimestamp("duration"));

				return gameMypage;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// 특정 유저의 점수(최고기록) 반환
	public Map<String, Integer> getHighestScoresByGame(String userId) throws Exception {
		Map<String, Integer> highestScores = new HashMap<>();

		String sql = "SELECT gameId, MAX(record) AS maxScore FROM gamerecord WHERE userid = ? and gameid BETWEEN 4001 AND 4006 GROUP BY gameid";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, userId);

			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) { // 여러 개의 결과 처리 가능하도록 수정
					int gameId = rs.getInt("gameid");
					int maxScore = rs.getInt("maxScore");
					highestScores.put(String.valueOf(gameId), maxScore);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return highestScores;
	}

	/**
	 * 로그인한 사용자의 각 게임별 순위를 반환하는 메소드 (오라클 문법)
	 * 
	 * @param userId 사용자 ID
	 * @return 게임ID(String)를 키로, 해당 게임에서의 순위를 값으로 하는 Map 객체
	 * @throws Exception 데이터베이스 오류 발생 시
	 */
	public Map<String, Integer> getUserRankingsByGames(String userId) throws Exception {
		Map<String, Integer> rankings = new HashMap<>();

		// 기본적으로 모든 게임(4001-4006)에 대해 순위 0으로 초기화
		for (int gameId = 4001; gameId <= 4006; gameId++) {
			rankings.put(String.valueOf(gameId), 0);
		}

		// 오라클에서 사용자 순위 조회 (서브쿼리 활용)
		String sql = "WITH GameMaxScore AS ( " + "    SELECT gameid, MAX(record) AS max_score " + "    FROM gamerecord "
				+ "    WHERE userid = ? " + "      AND gameid BETWEEN 4001 AND 4006 " + "    GROUP BY gameid "
				+ "), UserRanking AS ( " + "    SELECT gameid, userid, "
				+ "           RANK() OVER (PARTITION BY gameid ORDER BY max_score DESC) AS user_rank " + "    FROM ( "
				+ "        SELECT gameid, userid, MAX(record) AS max_score " + "        FROM gamerecord "
				+ "        WHERE gameid BETWEEN 4001 AND 4006 " + "        GROUP BY gameid, userid " + "    ) r2 "
				+ ") " + "SELECT g.gameid, COALESCE(r.user_rank, 1) AS user_rank " + "FROM GameMaxScore g "
				+ "LEFT JOIN UserRanking r " + "    ON g.gameid = r.gameid AND r.userid = ?";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, userId);
			pstat.setString(2, userId);

			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					int gameId = rs.getInt("gameid");
					int userRank = rs.getInt("user_rank");
					rankings.put(String.valueOf(gameId), userRank);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return rankings;
	}

	// 게임 score 기록
	public int insert(GameRecordDTO dto) throws Exception {
		// GAMERECORD USERID - USERS NICKNAME (FK설정)

		// GAME
		// SEQ GAMENAME PLAYTIME CATEGORY

		// GAMERECORD
		// SEQ USERID GAMEID RECORD PLAYTIME DURATION
		String sql = "INSERT INTO GAMERECORD VALUES (SEQ_GAMERECORD.NEXTVAL, ?, ?, ?, SYSDATE, SYSDATE)";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getUserId());
			pstat.setInt(2, dto.getGameId());
			pstat.setInt(3, dto.getRecord());

			return pstat.executeUpdate();
		}
	}

	// 게임별 랭킹 10명 출력하는 함수
	public List<GameRecordRankingDTO> getGameRecordRanking(int gameId) throws Exception {
		String sql = "select * from (select userid,max(record) as record,rank() over(order by max(RECORD) desc) as ranking from gamerecord where gameid=? group by userid) where ranking <=10 order by ranking";
		List<GameRecordRankingDTO> rankingList = new ArrayList<>();

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, gameId);
			try (ResultSet rs = pstat.executeQuery();) {

				for (int i = 1; i <= 10; i++) {
					String id = "아직 기록이 없습니다";
					int record = 0;
					int ranking = i;
					boolean hasNext = rs.next();
					if (hasNext) {
						id = rs.getString("userid");
						record = rs.getInt("record");
						ranking = rs.getInt("ranking");
					}
					GameRecordRankingDTO dto = new GameRecordRankingDTO(id, record, ranking);
					rankingList.add(dto);
				}
				return rankingList;
			}
		}
	}

}
