/**
 * Created by kvint on 04.12.14.
 */
package tests {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.igniterealtime.xiff.data.rsm.RSMSet;
	import org.igniterealtime.xiff.setmanagement.ISetLooper;
	import org.igniterealtime.xiff.setmanagement.IndexedSetLooper;

	public class TestRSM {

		public var _looper:ISetLooper;

		[Before]
		public function setUp():void {
			_looper = new IndexedSetLooper();
		}

		[Test]
		public function testGetNext():void {
			var nextSet:RSMSet;
			_looper.bufferSize = 100;

			var rsm:RSMSet = new RSMSet();
			rsm.count = 250;

			rsm.firstIndex = 0;
			_looper.pin(rsm);
			nextSet = _looper.getNext();

			assertEquals(100, nextSet.index);


			rsm.firstIndex = nextSet.index;
			_looper.pin(rsm);
			nextSet = _looper.getNext();

			assertEquals(200, nextSet.index);

			rsm.firstIndex = nextSet.index;
			_looper.pin(rsm);
			nextSet = _looper.getNext();

			assertEquals(250, nextSet.index);

			rsm.firstIndex = nextSet.index;
			_looper.pin(rsm);
			nextSet = _looper.getNext();

			assertNull(nextSet);
		}


		[Test]
		public function testPrevious():void {
			var prevSet:RSMSet;
			_looper.bufferSize = 100;

			var rsm:RSMSet = new RSMSet();
			rsm.count = 250;
			prevSet = _looper.getPrevious();
			assertNotNull(prevSet);

			_looper.pin(rsm);
			prevSet = _looper.getPrevious();
			assertEquals(150, prevSet.index);

			rsm.firstIndex = prevSet.index;
			_looper.pin(rsm);
			prevSet = _looper.getPrevious();
			assertEquals(50, prevSet.index);

			rsm.firstIndex = prevSet.index;
			_looper.pin(rsm);
			prevSet = _looper.getPrevious();
			assertEquals(0, prevSet.index);

			rsm.firstIndex = prevSet.index;
			_looper.pin(rsm);
			prevSet = _looper.getPrevious();

			assertNull(prevSet);
		}
	}
}
