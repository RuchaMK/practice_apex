public class ParkLocator{
    public static String[] country(String country){
        ParkService.ParksImplPort pks = new ParkService.ParksImplPort();
        String[] result = pks.byCountry(country);
        return result;
    } 

}
/*ParkLocator.country('India');*/