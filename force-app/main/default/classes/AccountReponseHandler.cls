public class AccountReponseHandler {

	public class Attributes {
		public String type;
		public String url;
	}

	public Attributes attributes;
	public String Id;
	public String Name;
	public String Rating;

	
	public static List<AccountReponseHandler> parse(String json) {
		return (List<AccountReponseHandler>) System.JSON.deserialize(json, List<AccountReponseHandler>.class);
	}
}