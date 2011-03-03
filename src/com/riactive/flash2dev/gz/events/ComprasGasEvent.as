package com.riactive.flash2dev.gz.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class ComprasGasEvent extends Event
	{
		public static const OCURRIO:String = "ocurrio algo";
		
		public var model:ArrayCollection;
		
		public function ComprasGasEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}