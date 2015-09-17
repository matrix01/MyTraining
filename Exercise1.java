/*
		Group 3 	
	
	FARHAN AR RAFI
  	SYMUNUR RAHMAN
  	MD. REZWANUL ISLAM
  	MD MILAN MIA

*/

public class Currency{
	public abstract String format(int amount);
}

public class USD extends Currency {
	public String format(int amount) {
		return "$" + String.parseInt(amount);
	}
}

public class RMB extends Currency {
	public String format(int amount) {
		return "RMB" + String.parseInt(amount);
	}
}

public class ESCUDO extends Currency {
	public String format(int amount) {
		return"$" + String.parseInt(amount);
	}
}

/**
	ANOTHER SOLUTION
*/

public class Currency{
	public String format(int amount) {
		return currencySign + String.parseInt(amount);
	}
}

public class USD extends Currency {
	public String currencySign = "$";

}

public class RMB extends Currency {
	public String currencySign = "RMB";

}

public class ESCUDO extends Currency {
	public String currencySign = "$";

}



