package com.riactive.flash2dev.gz.helpers
{
	import com.riactive.flash2dev.gz.events.ComprasGasEvent;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	public class BDConnection extends EventDispatcher
	{
		public var sqlConexion:SQLConnection;
		public var sqlArchivo:File;
		public var sqlSentencia:SQLStatement;
		
		public function BDConnection()
		{
		}
		public function conectar():void
		{
			if(sqlConexion == null){
				sqlConexion = new SQLConnection();
				asignarListeners();
				sqlArchivo = File.applicationDirectory.resolvePath("GzGasCalc.db");
				sqlConexion.openAsync(sqlArchivo);
			}
			else{
				sqlConexion.close();
				sqlConexion.openAsync(sqlArchivo);
			}
		}
		
		private function asignarListeners():void
		{
			sqlConexion.addEventListener(SQLEvent.OPEN, baseDatosOpen);
			sqlConexion.addEventListener(SQLErrorEvent.ERROR, baseDatosError);
		}
		
		protected function baseDatosOpen(event:SQLEvent):void
		{
			if(sqlSentencia == null){
				sqlSentencia = new SQLStatement();
			}
			sqlSentencia.sqlConnection = sqlConexion;
			sqlSentencia.addEventListener(SQLEvent.RESULT, sentenciaCreacionResultHandle);
			sqlSentencia.addEventListener(SQLErrorEvent.ERROR, sentenciaErrorHandle);
			var sql:String = "CREATE TABLE IF NOT EXISTS comprasGas (compra_id INTEGER PRIMARY KEY AUTOINCREMENT,  fecha DATETIME,  litros DECIMAL(6,3) , odometro NUMERIC);";
			sqlSentencia.text = sql;
			sqlSentencia.execute();
		}
		
		protected function baseDatosError(event:SQLErrorEvent):void
		{
			trace("Error detalle:", event.error.details);
			trace("Details:", event.error.message);
		}
		
		protected function sentenciaCreacionResultHandle(event:SQLEvent):void
		{
			sqlSentencia.removeEventListener(SQLEvent.RESULT, sentenciaCreacionResultHandle);
			var sqlResultado:SQLResult = sqlSentencia.getResult();
		}
		
		protected function sentenciaErrorHandle(event:SQLErrorEvent):void
		{
			trace("Error detalle:", event.error.details);
			trace("Details:", event.error.message);
		}
		
		public function ejecutarSentencia(query:String):void
		{
			sqlSentencia.text = query;
			sqlSentencia.execute();
			sqlSentencia.addEventListener(SQLEvent.RESULT, sentenciaInsertResultHandle);
		}
		
		protected function sentenciaInsertResultHandle(event:SQLEvent):void
		{
			sqlSentencia.removeEventListener(SQLEvent.RESULT, sentenciaInsertResultHandle);
			var sqlResultado:SQLResult = sqlSentencia.getResult();
			var evento:ComprasGasEvent = new ComprasGasEvent(ComprasGasEvent.OCURRIO, true);
			evento.model = new ArrayCollection(sqlResultado.data);
			dispatchEvent(evento);
			sqlConexion.close();
		}
		
		
	}
}