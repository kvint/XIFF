/**
 * Created by AlexanderSla on 04.12.2014.
 */
package org.igniterealtime.xiff.setmanagement {
	import org.igniterealtime.xiff.data.rsm.RSMSet;

	public class SetLooper extends ASetLooper {

		override public function get getNext():RSMSet {
			var result:RSMSet = new RSMSet();
			if(current) {
				result.after = current.last;
			}else{
				result.after = "";
			}
			result.max = bufferSize;
			return result;

		}

		override public function get getPrevious():RSMSet {
			var result:RSMSet = new RSMSet();
			if(current) {
				result.before = current.first;
			}else{
				result.before = "";
			}
			result.max = bufferSize;
			return result;
		}
	}
}
