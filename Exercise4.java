/*
		Group 3 	
	
	FARHAN AR RAFI
  	SYMUNUR RAHMAN
  	MD. REZWANUL ISLAM
  	MD MILAN MIA

*/

class SurveyData{
	String path;
	private boolean hidden;

	Static ArrayList<SurveyData> dataTypeArray = new ArrayList<>();

	void setSavePath(int t){
		if(dataTypeArray.size()==0)assignPath();
		this.path = dataTypeArray[t].path;
		this.hidden = dataTypeArray[t].hidden; 
	}

	void assignPath(){
		dataTypeArray.add(new SurveyData("c:/application/data/raw.dat",true)); 
		dataTypeArray.add(new SurveyData("c:/application/data/cleanedUp.dat",true));
		dataTypeArray.add(new SurveyData("c:/application/data/processed.dat",true));
		dataTypeArray.add(new SurveyData("c:/application/data/publication.dat",false));
	}

	SurveyData(String path,boolean hidden){
		this.path=path;
		this.hidden=hidden;
	}
}

/**
	ANOTHER SOLUTION
*/

class SurveyData {
	String path;
	boolean hidden;
	public abstract void setSavePath();
}
class Raw extends SurveyData {
	public void setSavePath() {
		this.path = "c:/application/data/raw.dat";
		this.hidden = true;
	}
}
class CleanedUp extends SurveyData {
	public void setSavePath() {
		this.path = "c:/application/data/cleanedUp.dat";
		this.hidden = true;
	}
}
class Processed extends SurveyData {
	public void setSavePath() {
		this.path = "c:/application/data/processed.dat";
		this.hidden = true;
	}
}
class Publishable extends SurveyData {
	public void setSavePath() {
		this.path = "c:/application/data/publication.dat";
		this.hidden = false;
	}
}













