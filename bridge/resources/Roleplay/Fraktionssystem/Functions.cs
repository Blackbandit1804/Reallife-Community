using System;
using System.Collections.Generic;
using System.Text;
using GTANetworkAPI;
using MySql.Data.MySqlClient;

namespace Roleplay.Fraktionssystem
{
    class Functions : Script
    {

        [RemoteEvent("Egd")]
        public void fDuty(Client c)
        {
            if (c.Position.DistanceTo2D(new Vector3(461.416, -981.1726, 30.6896)) <= 2)
            {
                if (Fraktionssystem.API.WhichFrak(c, 1))
                {
                    Fraktionssystem.API.LSPDDuty(c);
                }
            }
            else if (c.Position.DistanceTo2D(new Vector3(1124.566, -1523.731, 34.84324)) <= 2)
            {
                if (Fraktionssystem.API.WhichFrak(c, 2))
                {
                    Fraktionssystem.API.LSMSDuty(c);
                }
            }
        }

        [RemoteEvent("OPC")]
        public static void OpenLSPDComputer(Client c)
        {
            if (c.Position.DistanceTo2D(new Vector3(440.7106, -975.6343, 30.68961)) <= 1)
            {
                if (Fraktionssystem.API.WhichFrak(c, 1))
                {
                    c.TriggerEvent("OeffneLSPDComputer");
                }
            }
        }

        [RemoteEvent("SearchPeopleLSPD")]
        public static void SearchThisPeopleWithLSPDComputer(Client c, string firstname, string lastname)
        {
            int money;
            int wanteds;
            int vehicles;
            int fraktion;

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand ccmd = new MySqlCommand("SELECT first_name, last_name, cash, wanteds, vehicles, fraktion FROM characters WHERE first_name = @fn AND last_name = @ln", conn);
            ccmd.Parameters.AddWithValue("@fn", firstname);
            ccmd.Parameters.AddWithValue("@ln", lastname);
            MySqlDataReader reader = ccmd.ExecuteReader();
            bool scCheck = reader.Read();
            if (!scCheck)
            {
                c.SendNotification("Diese Person existiert nicht!");
                reader.Close();
                DatabaseAPI.API.GetInstance().FreeConnection(conn);
                return;
            }
            else
            {
                wanteds = reader.GetInt32("wanteds");
                money = reader.GetInt32("cash");
                vehicles = reader.GetInt16("vehicles");
                fraktion = reader.GetInt16("fraktion");
                reader.Close();
            }

            DatabaseAPI.API.GetInstance().FreeConnection(conn);

            c.TriggerEvent("LSPDcomputerfoundpeople", firstname, lastname, wanteds, money, vehicles, Fraktionssystem.API.Frakranknames[(fraktion > Fraktionssystem.API.Frakranknames.Length) ? 0 : fraktion]);
        }

        [RemoteEvent("SearchNumberplate")]
        public static void SearchNumberplate(Client c, string numberplate)
        {
            int CharID;

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();

            MySqlCommand ccmd = new MySqlCommand("SELECT numberplate, character_id FROM numberplates WHERE numberplate = @np", conn);
            ccmd.Parameters.AddWithValue("@np", numberplate);
            MySqlDataReader reader = ccmd.ExecuteReader();
            bool scCheck = reader.Read();
            if (!scCheck)
            {
                c.SendNotification("Dieses Nummernschild existiert nicht!");
                reader.Close();
                DatabaseAPI.API.GetInstance().FreeConnection(conn);
                return;
            } else
            {
                CharID = reader.GetInt32("character_id");
                reader.Close();
            }

            DatabaseAPI.API.GetInstance().FreeConnection(conn);

            MySqlCommand cmd = new MySqlCommand("SELECT first_name, last_name, wanteds FROM characters WHERE id = @charaid", conn);
            cmd.Parameters.AddWithValue("@charaid", CharID);
            MySqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                c.TriggerEvent("NumberplateFound", r.GetString("first_name"), r.GetString("last_name"), r.GetInt32("wanteds"));
            }
            r.Close();
            DatabaseAPI.API.GetInstance().FreeConnection(conn);

        }

    }
}
