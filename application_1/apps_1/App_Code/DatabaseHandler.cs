using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;

/// <summary>
/// Summary description for DatabaseHandler
/// </summary>
public class DatabaseHandler
{
    Service client = new Service();
	public DatabaseHandler()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public DataSet ExecuteSelect(string storedProcedureName,string[] parameters)
    {
        try
        {
            DataSet ds = client.ExecuteDataSet(storedProcedureName, parameters);
            return ds;
        }
        catch (Exception ex) 
        {
            throw ex;
        }
    }

    public int ExecuteNonQuery(string storedProcedureName, string[] parameters)
    {
        try
        {
           Result result = client.ExecuteNonQuery(storedProcedureName, parameters);
            return int.Parse(result.PegPayId);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}