package Model;

public class ELevel {
	public enum Level {
		INFO, ALERT, WARNING, DANGER;
	}
	public static Level getLevelLog (String levelString) {
		switch (levelString) {
		case "INFO": {
			return Level.INFO;
		}
		case "ALERT": {
			return Level.ALERT;
		}
		case "WARNING": {
			return Level.WARNING;
		}
		case "DANGER": {
			return Level.DANGER;
		}
		default :
			return null;
		
	}
		
		
	}
}
