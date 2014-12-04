/**
 * Created by AlexanderSla on 04.12.2014.
 */
package org.igniterealtime.xiff.setmanagement {
	import org.igniterealtime.xiff.data.rsm.RSMSet;

	public class IndexedSetLooper extends ASetLooper{

		override public function get next():RSMSet {
			var result:RSMSet = new RSMSet();
			if(current) {
				result.index = Math.min(current.firstIndex + bufferSize, current.count);
			}
			result.max = bufferSize;
			return result;
		}

		override public function get previous():RSMSet {
			var result:RSMSet = new RSMSet();
			if(current) {
				var prevIndex:int = current.first == null ? current.count : current.count;
				result.index = Math.max(prevIndex - bufferSize, 0);
			}
			result.max = bufferSize;
			return result;
		}
	}
}
