using GTANetworkAPI;

namespace Roleplay.Staat
{
    class LAB : Script
    {
        public LAB()
        {
            NAPI.TextLabel.CreateTextLabel("~g~Zulassungsstelle\n~w~Drücke '~g~E~w~' um das Menü zu öffnen.", new Vector3(-1016.432, -413.3861, 39.6161), 12, 1f, 4, new Color(255, 255, 255, 200));

            //BLIPS
            NAPI.Blip.CreateBlip(571, new Vector3(-1016.432, -413.3861, 39.6161), 0.8f, 37, "Zulassungsstelle");
        }
    }
}
