package bgs.game.model
{
	public class EventCardModel
	{
		private var _holdCards:Vector.<Vector.<uint>>;
		public function EventCardModel()
		{
		}
	
		public function get holdCards():Vector.<Vector.<uint>>
		{
			return _holdCards;
		}
		public function set holdCards($holdCards:Vector.<Vector.<uint>>):void
		{
			_holdCards = $holdCards;
		}
	}
}