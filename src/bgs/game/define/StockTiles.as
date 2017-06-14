package bgs.game.define
{
	public class StockTiles
	{
		static public const TOTAL_CARDS:uint = 12;
		/**
		 * -2 : -2
		 * -1 : -1
		 * 0 : 주가 유지
		 * 1 : +1
		 * 2 : +2
		 * 3 : 배당
		 * 4 : 배당 +1
		 * 5 : 배당 +2
		 */
		static public const CARD_1_1:Vector.<int> = new <int>[0, 1, 2];
		static public const CARD_1_2:Vector.<int> = new <int>[0, 1, 2];
		static public const CARD_1_3:Vector.<int> = new <int>[-2, -1, 0];
		static public const CARD_1_4:Vector.<int> = new <int>[0, 1, 2];
		
		static public const CARD_2_1:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_2_2:Vector.<int> = new <int>[-2, -1, 0];		
		static public const CARD_2_3:Vector.<int> = new <int>[0, 4, 5];		
		static public const CARD_2_4:Vector.<int> = new <int>[0, 1, 2];
		
		static public const CARD_3_1:Vector.<int> = new <int>[-2, -1, 0];		
		static public const CARD_3_2:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_3_3:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_3_4:Vector.<int> = new <int>[0, 2, 5];
		
		static public const CARD_4_1:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_4_2:Vector.<int> = new <int>[-1, -1, 0];		
		static public const CARD_4_3:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_4_4:Vector.<int> = new <int>[0, 1, 2];
		
		static public const CARD_5_1:Vector.<int> = new <int>[0, 3, 5];		
		static public const CARD_5_2:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_5_3:Vector.<int> = new <int>[-2, -1, 0];		
		static public const CARD_5_4:Vector.<int> = new <int>[0, 4, 5];
		
		static public const CARD_6_1:Vector.<int> = new <int>[0, 4, 5];		
		static public const CARD_6_2:Vector.<int> = new <int>[-1, -1, 0];		
		static public const CARD_6_3:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_6_4:Vector.<int> = new <int>[0, 1, 2];
		
		static public const CARD_7_1:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_7_2:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_7_3:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_7_4:Vector.<int> = new <int>[-2, -1, 0];
		
		static public const CARD_8_1:Vector.<int> = new <int>[-2, -1, 0];		
		static public const CARD_8_2:Vector.<int> = new <int>[0, 3, 4];		
		static public const CARD_8_3:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_8_4:Vector.<int> = new <int>[0, 1, 5];
		
		static public const CARD_9_1:Vector.<int> = new <int>[0, 4, 5];		
		static public const CARD_9_2:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_9_3:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_9_4:Vector.<int> = new <int>[-2, -1, 0];
	
		static public const CARD_10_1:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_10_2:Vector.<int> = new <int>[0, 3, 2];		
		static public const CARD_10_3:Vector.<int> = new <int>[-2, -1, 0];		
		static public const CARD_10_4:Vector.<int> = new <int>[0, 4, 2];
		
		static public const CARD_11_1:Vector.<int> = new <int>[-2, -1, 0];		
		static public const CARD_11_2:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_11_3:Vector.<int> = new <int>[0, 4, 5];		
		static public const CARD_11_4:Vector.<int> = new <int>[-2, -1, 0];
		
		static public const CARD_12_1:Vector.<int> = new <int>[0, 1, 5];		
		static public const CARD_12_2:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_12_3:Vector.<int> = new <int>[0, 1, 2];		
		static public const CARD_12_4:Vector.<int> = new <int>[-2, -1, 0];
	}
}