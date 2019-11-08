using System;
using System.Collections.Generic;
using System.Text;
using GTANetworkAPI;

namespace Roleplay
{
    class Chat : Script
    {
        [ServerEvent(Event.ChatMessage)]
        public void EventChatMessage(Client client, string message)
        {

            Client[] clients = NAPI.Pools.GetAllPlayers().FindAll(x => x.Position.DistanceTo2D(client.Position) <= 15).ToArray();

            for (int i = 0; i < clients.Length; i++)
            {
                if (!clients[i].Exists)
                    continue;

                clients[i].SendChatMessage($"{client.Name} sagt: {message}");
            }
        }
    }
}
