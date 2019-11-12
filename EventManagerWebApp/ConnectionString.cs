namespace EventManagerWebApp
{
    public class ConnectionString
    {
        //. is default, phill  @"Data Source=DESKTOP-MROQOOL\SQLEXPRESS
        public static string connectionString { get { return @"Data Source=.;Initial Catalog=EventManager;Integrated Security=True"; } }
    }
}