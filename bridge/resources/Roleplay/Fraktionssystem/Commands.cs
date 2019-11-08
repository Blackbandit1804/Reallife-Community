using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Text;

namespace Roleplay.Fraktionssystem
{
    class Commands : Script
    {
        #region Leader
        [Command("invite")]
        public void fInvite(Client c, Client p)
        {
            if (!Fraktionssystem.API.HasLeaderRank(c))
                return;

            Fraktionssystem.API.fInvite(c, p);
        }

        [Command("uninvite")]
        public void fUninvite(Client c, Client p)
        {
            if (!Fraktionssystem.API.HasLeaderRank(c))
                return;

            Fraktionssystem.API.fUninvite(c, p);
        }

        [Command("setrank")]
        public void fSetRank(Client c, Client p, int rank)
        {
            if (!Fraktionssystem.API.HasLeaderRank(c))
                return;

            Fraktionssystem.API.fSetRank(c, p, rank);
        }

        [Command("fpark")]
        public void FractionVehPark(Client c)
        {
            if (!c.IsInVehicle)
            {
                c.SendNotification("Du sitzt in keinem Fahrzeug!");
                return;
            }

            if (c.GetData("fraktionrank") == 5)
            {
                if (Fraktionssystem.API.Frakranknames[(c.GetData("fraktion") > Fraktionssystem.API.Frakranknames.Length) ? 0 : c.GetData("fraktion")] == c.Vehicle.GetData("fraktion"))
                {
                    Vehicle v = c.Vehicle;

                    MySqlCommand cmd = new MySqlCommand("UPDATE fvehicles SET " +
                    "p_x = @p_x, p_y = @p_y, p_z = @p_z, r = @r " +
                    "WHERE id = @id");
                    cmd.Parameters.AddWithValue("@p_x", v.Position.X);
                    cmd.Parameters.AddWithValue("@p_y", v.Position.Y);
                    cmd.Parameters.AddWithValue("@p_z", v.Position.Z);
                    cmd.Parameters.AddWithValue("@r", v.Rotation.Z);

                    cmd.Parameters.AddWithValue("@id", v.GetData("fid"));

                    DatabaseAPI.API.executeNonQuery(cmd);

                    c.SendNotification("Fahrzeug wurde erfolgreich umgeparkt!");
                } else
                {
                    c.SendNotification("Dieses Fahrzeug gehört nicht zu deiner Fraktion!");
                }
            } else
            {
                c.SendNotification("Du bist kein Leader!");
            }
        }
        #endregion

        #region LSPD
        [Command("fpunkte")]
        public void FuehrerscheinPunkte(Client c, Client p, int punkte, string reason)
        {
            if (Fraktionssystem.API.WhichFrak(c, 1))
            {
                if (!p.HasData("führerschein"))
                {
                    c.SendNotification("Dieser Spieler besitzt keinen Führerschein!");

                    return;
                }

                c.SendChatMessage($"[~b~LSPD~w~]: Du hast dem Spieler {p.Name} erfolgreich {punkte} Punkte auf sein Führerschein gegeben.");
                p.SendChatMessage($"[~b~LSPD~w~]: Du bekamst von {c.Name} {punkte} Punkte auf dein Führerschein. Grund: {reason}");

                Player.PlayerUpdate.UpdateLicensePoints(p, punkte);
            }
        }


        [Command("setwanted")]
        public void GivePlayerWanteds(Client c, Client p, int wanteds, string reason)
        {
            if (Fraktionssystem.API.WhichFrak(c, 1))
            {
                c.SendChatMessage($"[~b~LSPD~w~]: Du hast dem Spieler {p.Name} erfolgreich {wanteds} aus dem Grund: {reason}, gegeben.");
                p.SendChatMessage($"[~b~LSPD~w~]: Du hast von {c.Name} {wanteds} Wanteds erhalten aus dem Grund: {reason}.");

                Player.PlayerUpdate.UpdatePlayerWanteds(p, true, wanteds);
            }
        }

        [Command("marke")]
        public void pMarke(Client c, Client p)
        {
            if (!Fraktionssystem.API.WhichFrak(c, 1))
                return;

            p.TriggerEvent("dienstmarke", c);

            NAPI.Task.Run(() =>
            {
                p.TriggerEvent("dienstmarked", c);
            }, delayTime: 7000);
        }

        [Flags]
        public enum AnimationFlags
        {
            Loop = 1 << 0,
            StopOnLastFrame = 1 << 1,
            OnlyAnimateUpperBody = 1 << 4,
            AllowPlayerControl = 1 << 5,
            Cancellable = 1 << 7
        }

        [Command("cuff")]
        public void cuff(Client c, Client p)
        {
            if (!Fraktionssystem.API.WhichFrak(c, 1))
                return;

            if (c.Position.DistanceTo2D(p.Position) < 5)
            {
                if (!p.HasData("cuffed"))
                {
                    NAPI.Player.PlayPlayerAnimation(p, (int)(AnimationFlags.Loop | AnimationFlags.OnlyAnimateUpperBody | AnimationFlags.AllowPlayerControl), "mp_arresting", "idle");
                    p.RemoveAllWeapons();
                    p.SetData("cuffed", 1);
                    p.TriggerEvent("cuff");
                    c.SendNotification("Du hast " + p.Name + " festgenommen!");
                    p.SendNotification("Du wurdest von " + c.Name + " in Handschellen gelegt!");
                }
                else
                {
                    p.StopAnimation();
                    p.ResetData("cuffed");
                    p.TriggerEvent("uncuff");
                    c.SendNotification("Du hast " + p.Name + " entfesselt!");
                    p.SendNotification("Du wurdest aus den Handschellen befreit!");
                }
            }
            else
            {
                c.SendNotification("Spieler nicht in Reichweite!");
            }

        }
        #endregion

        #region LSMD
        [Command("heal")]
        public void HealPlayer(Client c, Client p)
        {
            if (!c.IsInVehicle || !p.IsInVehicle)
            {
                c.SendNotification("Der Veletzte und du müssen im RTW sitzen um ihn zu verarzten.");
                return;
            }

            if (c.Position.DistanceTo(p.Position) <= 5)
            {
                p.Health = 100;
                c.SendNotification($"Du hast den Spieler {p.Name} verarztet.");
                c.SendNotification($"Du wurde von {c.Name} verarztet.");
            } else
            {
                c.SendNotification("Der Spieler ist zu weit entfernt!");
            }
        }
        #endregion
    }
}
