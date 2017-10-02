package Databases;

import javax.naming.NamingException;
import java.sql.*;
import java.util.ArrayList;

public class SQLiteClass {
    public static Connection conn;
    public static Statement stat;
    public static ResultSet rs;

    public static void Conn() throws ClassNotFoundException, SQLException, NamingException {

        conn = null;
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection("jdbc:sqlite:MyDB.s3db");
        System.out.println("Connection started Привет!");

        stat = conn.createStatement();
        stat.execute("CREATE TABLE if not exists 'relative' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'name' text, 'parent' text);");


        //stat = conn.createStatement();
        ResultSet myrs = stat.executeQuery("SELECT * FROM relative where parent=\'"+"Root"+"\'");
        while (myrs.next())
            System.out.println(myrs.getString("name")+" вот такая строка");
        stat.close();
        System.out.println("вот такая вот строка");

    }

    public static void addName(String name) throws ClassNotFoundException, SQLException {
        try {
            Conn();
            stat = conn.createStatement();
            PreparedStatement statement = conn.prepareStatement("INSERT INTO names (name) VALUES (?)");
            statement.setString(1, name);
            statement.execute();
            statement.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        finally {
            stat.close();
            CloseDB();
        }
    }

    public static ArrayList<String> getAllNames() throws ClassNotFoundException, SQLException, NamingException
    {
        ArrayList<String> names = new ArrayList<String>();

        Conn();
        stat = conn.createStatement();
        ResultSet rs = stat.executeQuery("select name from names");

        while (rs.next()) {
            names.add(rs.getString("name"));
        }

        rs.close();
        stat.close();
        CloseDB();

        return names;
    }


    public static ArrayList<String> getChildren(String parentname) throws ClassNotFoundException, SQLException, NamingException
    {
        ArrayList<String> names = new ArrayList<String>();

        Conn();
        stat = conn.createStatement();
        ResultSet rs = stat.executeQuery("select name from relative where parent=\'"+parentname+"\'");

        while (rs.next()) {
            names.add(rs.getString("name"));
            System.out.println(rs.getString("name")+" вот такая стркоа");

        }
        System.out.println(names.toString()+" вот такая строчкааааа");

        rs.close();
        stat.close();
        CloseDB();

        return names;
    }

    public static void CloseDB() throws ClassNotFoundException, SQLException {
        conn.close();
    }
}

