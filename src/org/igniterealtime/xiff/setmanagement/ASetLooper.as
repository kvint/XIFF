/**
 * Created by AlexanderSla on 04.12.2014.
 */
package org.igniterealtime.xiff.setmanagement {
	import org.igniterealtime.xiff.data.rsm.RSMSet;

	public class ASetLooper implements ISetLooper{

		private const DEFAULT_BUFFER_SIZE:int = 100;

		private var _bufferSize:int = DEFAULT_BUFFER_SIZE;

		protected var current:RSMSet;

		public function get bufferSize():int {
			return _bufferSize;
		}

		public function set bufferSize(value:int):void {
			_bufferSize = value;
		}

		public function get next():RSMSet {
			return null;
		}

		public function get previous():RSMSet {
			return null;
		}

		public function pin(value:RSMSet):void {
			current = value;
		}
	}
}
