/**
 * Created by AlexanderSla on 04.12.2014.
 */
package org.igniterealtime.xiff.setmanagement {
	import org.igniterealtime.xiff.data.rsm.RSMSet;

	public class IndexedSetLooper extends ASetLooper{

		private var _index:int = -1;

		override public function get next():RSMSet {
			var result:RSMSet = new RSMSet();
			if(current) {
				//TODO: handle EOF case
				result.index = Math.min(current.firstIndex + bufferSize, current.count);
			}
			result.max = bufferSize;
			return result;
		}

		override public function pin(value:RSMSet):void {
			super.pin(value);
			if(current == null){
				_index = -1;
			}else{
				if(_index == -1)
					_index = current.count;

			}
		}

		override public function get previous():RSMSet {
			var result:RSMSet = new RSMSet();
			if(current) {
				if(_index == 0) return null;
				if(current.first != null && current.firstIndex == 0 && current.count <= 1) return null;
				if(_index == -1) _index = current.count;
				_index = Math.max(_index - bufferSize, 0)
				result.index = _index;
			}
			result.max = bufferSize;
			return result;
		}
	}
}
