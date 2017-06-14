package bgs.game.control.sequence
{
	import flash.events.IEventDispatcher;

	public interface IGameControl extends IEventDispatcher
	{
		function start():void;
	}
}