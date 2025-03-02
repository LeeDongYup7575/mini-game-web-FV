package auth.dto;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.ResolverStyle;
import java.util.regex.Pattern;

public class UsersDTO {
    
    private String id;
    private String pw;
    private String name;
    private String nickname;
    private String phone;
    private String email;
    private String rnum;
    private Timestamp joinDate;
    private int warningCount;
    private int withdraw;
    private int status;
    private int isAdmin;
    private Timestamp lastLogin;
    
    public UsersDTO() {
    }
    
    public UsersDTO(String id, String pw, String nickname, String name, String phone, String email, String rnum,
            int warningCount, int withdraw, int status, int isAdmin) {
        super();
        this.id = id;
        this.pw = pw;
        this.nickname = nickname;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.rnum = rnum;
        this.warningCount = warningCount;
        this.withdraw = withdraw;
        this.status = status;
        this.isAdmin = isAdmin;
    }

    public UsersDTO(String id, String pw, String nickname, String name, String phone, String email, String rnum,
            Timestamp joinDate, int warningCount, int withdraw, int status, int isAdmin,
            Timestamp lastLogin) {
        super();
        this.id = id;
        this.pw = pw;
        this.name = name;
        this.nickname = nickname;
        this.phone = phone;
        this.email = email;
        this.rnum = rnum;
        this.joinDate = joinDate;
        this.warningCount = warningCount;
        this.withdraw = withdraw;
        this.status = status;
        this.isAdmin = isAdmin;
        this.lastLogin = lastLogin;
    }
    
    public String getId() {
        return id;
    }

    public String getPw() {
        return pw;
    }
    
    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public String getNickname() {
        return nickname;
    }
    
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public String getRnum() {
        return rnum;
    }
    
    public void setRnum(String rnum) {
        this.rnum = rnum;
    }

    public Timestamp getJoinDate() {
        return joinDate;
    }

    public int getWarningCount() {
        return warningCount;
    }

    public int getWithdraw() {
        return withdraw;
    }

    public int getStatus() {
        return status;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public Timestamp getLastLogin() {
        return lastLogin;
    }

    // 유효성 검사 메서드
    public void validate() throws IllegalArgumentException {
        if (!isValidId(this.id)) {
            throw new IllegalArgumentException("아이디는 영문자로 시작하며 6~15자여야 합니다.");
        }
        if (!isValidPassword(this.pw)) {
            throw new IllegalArgumentException("비밀번호는 8자 이상, 대소문자와 특수문자를 포함해야 합니다.");
        }
        if (!isValidName(this.name)) {
            throw new IllegalArgumentException("이름은 한글 2~5자여야 합니다.");
        }
        if (!isValidNickname(this.nickname)) {
            throw new IllegalArgumentException("닉네임은 한글, 영문, 숫자로 1~9자여야 합니다.");
        }
        if (!isValidPhone(this.phone)) {
            throw new IllegalArgumentException("핸드폰 번호는 010-XXXX-YYYY 또는 010XXXXXXXX 형식이어야 합니다.");
        }
        if (!isValidEmail(this.email)) {
            throw new IllegalArgumentException("이메일 형식이 올바르지 않습니다.");
        }
        if (!isValidRnum(this.rnum)) {
            throw new IllegalArgumentException("생년월일이 유효하지 않습니다.");
        }
    }

    // 아이디 유효성 검사 (영문자로 시작하며 6~15자)
    private boolean isValidId(String id) {
        return id != null && id.matches("^[a-zA-Z][a-zA-Z0-9]{5,14}$");
    }

    // 비밀번호 유효성 검사 (대소문자, 숫자, 특수문자 포함 8자 이상)
    private boolean isValidPassword(String pw) {
        // 해시된 비밀번호인 경우 (길이가 64자 = SHA-256)
        if (pw != null && pw.length() == 64 && pw.matches("^[a-fA-F0-9]{64}$")) {
            return true;
        }
        // 일반 비밀번호 검사
        return pw != null && pw.matches("^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$");
    }

    // 이름 유효성 검사 (한글 2~5자)
    private boolean isValidName(String name) {
        return name != null && name.matches("^[가-힣]{2,5}$");
    }

    // 닉네임 유효성 검사 (한글, 영문, 숫자로 1~9자)
    private boolean isValidNickname(String nickname) {
        return nickname != null && nickname.matches("^[\\w가-힣]{1,9}$");
    }
    
    // 핸드폰 번호 유효성 검사
    private boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^01[0|1|6|7|8|9][- ]?\\d{3,4}[- ]?\\d{4}$");
    }

    // 이메일 유효성 검사
    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    }

    public static boolean isValidRnum(String rnum) {
        // 1. null 체크 및 정규식 검사 (6자리 숫자)
        if (rnum == null || !Pattern.compile("^[0-9]{6}$").matcher(rnum).matches()) {
            return false;
        }

        try {
            // YY, MM, DD 파싱
            int yy = Integer.parseInt(rnum.substring(0, 2));
            int mm = Integer.parseInt(rnum.substring(2, 4));
            int dd = Integer.parseInt(rnum.substring(4, 6));
            
            // 월/일 기본 유효성 검사
            if (mm < 1 || mm > 12) {
                return false;
            }
            
            // 각 월의 마지막 날짜 계산
            int lastDay;
            if (mm == 2) {
                // 현재 세기 결정 (00~24: 2000년대, 25~99: 1900년대)
                int year = (yy <= 24) ? 2000 + yy : 1900 + yy;
                boolean isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
                lastDay = isLeap ? 29 : 28;
            } else if (mm == 4 || mm == 6 || mm == 9 || mm == 11) {
                lastDay = 30;
            } else {
                lastDay = 31;
            }
            
            if (dd < 1 || dd > lastDay) {
                return false;
            }
            
            // 현재 세기 결정 (00~24: 2000년대, 25~99: 1900년대)
            int year = (yy <= 24) ? 2000 + yy : 1900 + yy;
            
            // 미래 날짜 방지
            LocalDate today = LocalDate.now();
            LocalDate birthDate = LocalDate.of(year, mm, dd);
            if (birthDate.isAfter(today)) {
                return false;
            }
            
            return true; // 모든 검증 통과
        } catch (Exception e) {
            return false; // 날짜 변환 실패
        }
    }
}