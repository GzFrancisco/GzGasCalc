package com.riactive.flash2dev.gz.model
{
	import com.riactive.flash2dev.gz.helpers.BDConnection;
	import com.riactive.flash2dev.gz.interfaces.IComprasGasDAO;
	import com.riactive.flash2dev.gz.valueobjects.CompraGasVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class ComprasGasDAO extends EventDispatcher implements IComprasGasDAO
	{
		public var bd:BDConnection;
		
		public function ComprasGasDAO(target:IEventDispatcher=null)
		{
			super(target);
			bd = new BDConnection();
			bd.conectar();
		}
		
		public function obtenerTodos():ArrayCollection
		{
			var sentencia:String = "SELECT * FROM comprasGas;";
			bd.ejecutarSentencia(sentencia);
			return null;
		}
		
		public function obtenerPorId(id:uint):CompraGasVO
		{
			return null;
		}
		
		public function actualizar(value:CompraGasVO):void
		{
		}
		
		public function salvar(value:CompraGasVO):void
		{
			var f:String = value.fecha.fullYear + "-0"+ (value.fecha.month+1) + "-0" + value.fecha.date + " " 
			+ value.fecha.hours + ":" + value.fecha.minutes + ":" + value.fecha.seconds + "." + value.fecha.milliseconds;
			var sentencia:String = "INSERT INTO comprasGas (fecha, litros, odometro) values('" + f + "', " + value.litros + ", " + value.odometro + ");";
			bd.ejecutarSentencia(sentencia);
		}
		
		public function borrar(value:CompraGasVO):void
		{
		}
	}
}