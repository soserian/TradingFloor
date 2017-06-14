package bgs.game.control
{
	import bgs.game.view.ChangeTileView;

	public class ViewControl
	{
		static private var _viewControl:ViewControl;
		private var _changeTileView:ChangeTileView;
		public function ViewControl()
		{
		}
		
		static public function getInstance():ViewControl
		{
			if (!_viewControl){
				_viewControl = new ViewControl;
			}
			return _viewControl;
		}
		
		public function set changeTileView(view:ChangeTileView):void
		{
			_changeTileView = view;
		}
		public function get changeTileView():ChangeTileView
		{
			return _changeTileView;
		}
	}
}