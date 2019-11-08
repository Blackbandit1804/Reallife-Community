using GTANetworkAPI;
using System;
using System.Collections.Generic;
using System.Text;

namespace Roleplay.Fraktionssystem
{
    public class LabelMarker : Script
    {
        public LabelMarker()
        {

            NAPI.TextLabel.CreateTextLabel("Benutze '~b~E~w~' um den Computer zu verwenden.", new Vector3(440.7106, -975.6343, 30.68961), 8, 1f, 4, new Color(255, 255, 255, 255));

            NAPI.TextLabel.CreateTextLabel("Benutze '~g~E~w~' um in den Dienst zu gehen.", new Vector3(461.416, -981.1726, 30.6896), 8, 1f, 4, new Color(255, 255, 255, 255));

            //LSMS
            NAPI.TextLabel.CreateTextLabel("Benutze '~g~E~w~' um in den Dienst zu gehen.", new Vector3(1124.566, -1523.731, 34.84324), 8, 1f, 4, new Color(255, 255, 255, 255));
        }
    }
}
