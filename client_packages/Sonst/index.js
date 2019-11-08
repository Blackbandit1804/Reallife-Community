mp.events.add("freezeplayer", () => {
	mp.players.local.freezePosition(true);
});
mp.events.add("unfreezeplayer", () => {
	mp.players.local.freezePosition(false);
});

mp.events.add('render', () =>
{
	if(mp.players.local.isSprinting())
	{
		mp.game.player.restoreStamina(100);
	}
});