package games.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;


public class GamesDTO {
	
	private int gameId;
	private String gameName;
	private Timestamp playTime;
	private String category;
	private String timePlay;
	
	public GamesDTO(int gameId, String gameName, Timestamp playTime, String category) {
		super();
		this.gameId = gameId;
		this.gameName = gameName;
		this.playTime = playTime;
		this.category = category;
	}

	public int getGameId() {
		return gameId;
	}

	public String getGameName() {
		return gameName;
	}

	public Timestamp getPlayTime() {
		return playTime;
	}
	
	public String getCategory() {
		return category;
	}
	
	public String getTimePlay() {
		long conTime = this.playTime.getTime();
		this.timePlay = new SimpleDateFormat("YYYY-MM-dd").format(conTime);
		return timePlay;
	}


}
