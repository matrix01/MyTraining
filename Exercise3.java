/*
		Group 3 	
	
	FARHAN AR RAFI
  	SYMUNUR RAHMAN
  	MD. REZWANUL ISLAM
  	MD MILAN MIA

*/

class FoodSalesReport {
	
	ArrayList<Food> foodList = new ArrayList<Food>; 
	
	void LoadData(Connection connection, Food food) {
		PreparedStatement st = connection.prepareStatement(
		getQueryString(food);
		
		try {
			ResultSet rs = st.executeQuery();
			try{
				rs.next();
				i=0;
				while(rs.hasNext) {
					foodList[i].quantity = rs.getInt("total"+foodList[i++].getType());
				}
			} finally {
				rs.close();
			}
		} finally {
			st.close;
		} 
	}
	
	private String getQueryString() {
		String resultString = "SELECT ";
		i=0;
		while(i<foodList.size()) {
			result +="SUM "+ foodList[i].getType() +
			" as total"+foodList[i++].getType();
		}
		result += " FROM foodSalesTable GROUP BY foodType;";
		return resultString;
	}
}

class Food {
	public abstract String getFoodType();
}

class Rice extends Food {
	int quantity;
	public String getType() {
		return "rice";
	}
}

class Noodle extends Food {
	int quantity;
	public String getType() {
		return "noodle";
	}
}

class Drink extends Food {
	int quantity;
	public String getType() {
		return "drink";
	}
}

class Dessert extends Food {
	int quantity;
	public String getType() {
		return "dessert";
	}
}

