/**
 * Created by AlexanderSla on 04.12.2014.
 */
package org.igniterealtime.xiff.setmanagement {
	import org.igniterealtime.xiff.data.rsm.RSMSet;

	public interface ISetLooper {

		function get bufferSize():int;
		function set bufferSize(value:int):void;

		function get next():RSMSet;
		function get previous():RSMSet;
		function pin(value:RSMSet):void;
		function reset():void;
	}
}
