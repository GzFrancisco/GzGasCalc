package com.riactive.flash2dev.gz.interfaces
{
	import com.riactive.flash2dev.gz.valueobjects.CompraGasVO;
	
	import mx.collections.ArrayCollection;

	public interface IComprasGasDAO
	{
		function obtenerTodos():ArrayCollection;
		function obtenerPorId(id:uint):CompraGasVO;
		function actualizar(value:CompraGasVO):void;
		function salvar(value:CompraGasVO):void;
		function borrar(value:CompraGasVO):void;
	}
}