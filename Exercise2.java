/*
		Group 3 	
	
	FARHAN AR RAFI
  	SYMUNUR RAHMAN
  	MD. REZWANUL ISLAM
  	MD MILAN MIA

*/

public class Course {
	String courseTitle;
	Module[] modules;
	public Course(String courseTitle, Module[] modules) {
		//foreach(modules )
	}
	
	double getFee() {
		double totalfee;
		for(int i=0; i<modules.length; i++) {
			totalfee += modules[i].getFee();
		}
		return totalFee;
	}
	
	double getDuration() {
		int duration = 0;
		for(int i=0;i<modules.length;i++) {
			duration += modules[i].getDuration();
		}
		return duration;
	}
	
	String getTitle() {
		return courseTitle;
	}
} 
public class Module extends Course {
	Session sessions[];
	double fee;
	public Module(String courseTitle, double fee, Session[] sessions) {
		
	}
	
	double getDuration() {
		int duration = 0;
		for(int i=0;i<sessions.length;i++) {
			duration += sessions[i].getDuration();
		}
		return duration;
	}
	
	double getFee() {
		return fee;
	}
	void setFee(double fee) {
		this.fee = fee;
	}
}

public class Session {
	Date date;
	int starthour;
	int endhour;
	int getDuration() {
		return endHour - starthour;
	}
}

