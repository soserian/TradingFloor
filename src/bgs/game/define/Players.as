package bgs.game.define
{
	public class Players
	{
		static public const USER:uint = 0;
		static public const PC1:uint = 1;
		static public const PC2:uint = 2;
		static public const PC3:uint = 3;
		static public const PC_TOTAL:uint = 3;
		
		static public const DEFUALT_MONEY:uint = 2000;
		static public const DEFUALT_STOCK_LIST:Vector.<uint> = new <uint>[2, 2, 2, 2];
		
		static public const PLAYER_ORDER:Vector.<uint> = new <uint>[
			Players.USER, Players.PC1, Players.PC2, Players.PC3
		];
	}
}