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
			if(bd.sqlConexion.connected){
				var sentencia:String = "SELECT * FROM comprasGas;";
				bd.ejecutarSentencia(sentencia);
			}else{
				bd.conectar();
			}
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
			var dia:int = value.fecha.date;
			var mes:int = value.fecha.month+1;
			var hora:int = value.fecha.hours;
			var minutos:int = value.fecha.minutes;
			var segundos:int = value.fecha.seconds;
			var milisegundos:int = value.fecha.milliseconds;
			
			var f:String = value.fecha.fullYear + "-"+ padZero(mes, 2) + "-" + padZero(dia, 2) + " " 
			+ padZero(hora, 2) + ":" + padZero(minutos, 2) + ":" + padZero(segundos, 2) + "." + padZero(milisegundos, 3);
			var sentencia:String = "INSERT INTO comprasGas (fecha, litros, odometro) values('" + f + "', " + value.litros + ", " + value.odometro + ");";
			bd.ejecutarSentencia(sentencia);
		}
		
		public function borrar(value:CompraGasVO):void
		{
		}
		
		public function padZero (num:Number, digits:int):String {
			var ret:String = num.toString();
			while (ret.length < digits)
				ret = "0" + ret;
			return ret;
		}
	}
}