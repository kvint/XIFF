/*
 * Copyright (C) 2003-2012 Igniterealtime Community Contributors
 *
 *     Daniel Henninger
 *     Derrick Grigg <dgrigg@rogers.com>
 *     Juga Paazmaya <olavic@gmail.com>
 *     Nick Velloff <nick.velloff@gmail.com>
 *     Sean Treadway <seant@oncotype.dk>
 *     Sean Voisen <sean@voisen.org>
 *     Mark Walters <mark@yourpalmark.com>
 *     Michael McCarthy <mikeycmccarthy@gmail.com>
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.igniterealtime.xiff.data
{
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.data.id.IIDGenerator;
	import org.igniterealtime.xiff.data.id.IncrementalGenerator;
	import org.igniterealtime.xiff.data.muc.MUCUserExtension;
	import org.igniterealtime.xiff.data.xhtml.XHTMLExtension;
	import org.igniterealtime.xiff.namespaces.xiff_internal;

	/**
	 * Message, nuff said.
	 *
	 * @see http://tools.ietf.org/html/rfc3921#section-2.1.1
	 */
	public class Message extends XMPPStanza implements IMessage
	{
		/**
		 * The message is sent in the context of a one-to-one chat
		 * session. Typically a receiving client will present message of
		 * type "chat" in an interface that enables one-to-one chat between
		 * the two parties, including an appropriate conversation history.
		 * Detailed recommendations regarding one-to-one chat sessions are
		 * provided under Section 5.1. of RFC 3921 (draft version).
		 * @see http://tools.ietf.org/html/draft-ietf-xmpp-3921bis-00#section-5.1
		 */
		public static const TYPE_CHAT:String = "chat";

		/**
		 * The message is generated by an entity that experiences an
		 * error in processing a message received from another entity (for
		 * details regarding stanza error syntax, refer to [xmpp-core]).
		 * A client that receives a message of type "error" SHOULD present an
		 * appropriate interface informing the sender of the nature of the error.
		 */
		public static const TYPE_ERROR:String = "error";

		/**
		 * The message is sent in the context of a multi-user
		 * chat environment (similar to that of [IRC]). Typically a
		 * receiving client will present a message of type "groupchat" in an
		 * interface that enables many-to-many chat between the parties,
		 * including a roster of parties in the chatroom and an appropriate
		 * conversation history. For detailed information about XMPP-based
		 * groupchat, refer to [XEP-0045].
		 * @see http://xmpp.org/extensions/xep-0045.html
		 */
		public static const TYPE_GROUPCHAT:String = "groupchat";

		/**
		 * The message provides an alert, a notification, or
		 * other information to which no reply is expected (e.g., news
		 * headlines, sports updates, near-real-time market data, and
		 * syndicated content). Because no reply to the message is expected,
		 * typically a receiving client will present a message of type
		 * "headline" in an interface that appropriately differentiates the
		 * message from standalone messages, chat messages, or groupchat
		 * messages (e.g., by not providing the recipient with the ability to
		 * reply). The receiving server SHOULD deliver the message to all of
		 * the recipient’s available resources.
		 */
		public static const TYPE_HEADLINE:String = "headline";

		/**
		 * The message is a standalone message that is sent outside
		 * the context of a one-to-one conversation or groupchat, and to
		 * which it is expected that the recipient will reply. Typically a
		 * receiving client will present a message of type "normal" in an
		 * interface that enables the recipient to reply, but without a
		 * conversation history. The default value of the ’type’ attribute
		 * is "normal".
		 */
		public static const TYPE_NORMAL:String = "normal";

		/**
		 * User is actively participating in the chat session.
		 */
		public static const STATE_ACTIVE:String = "active";

		/**
		 * User is composing a message.
		 */
		public static const STATE_COMPOSING:String = "composing";

		/**
		 * User had been composing but now has stopped.
		 * Suggested delay after last activity some 30 seconds.
		 */
		public static const STATE_PAUSED:String = "paused";

		/**
		 * User has not been actively participating in the chat session.
		 * Suggested delay after last activity some 2 minutes.
		 */
		public static const STATE_INACTIVE:String = "inactive";

		/**
		 * User has effectively ended their participation in the chat session.
		 * Suggested delay after last activity some 10 minutes.
		 */
		public static const STATE_GONE:String = "gone";

		/**
		 * The name space used in the Chat state node.
		 * @see http://xmpp.org/extensions/xep-0085.html
		 */
		public static const NS_STATE:String = "http://jabber.org/protocol/chatstates";

		/**
		 * Included by a sending entity that wishes to know if
		 * the message has been received.
		 *
		 * @see http://xmpp.org/extensions/xep-0184.html
		 */
		public static const RECEIPT_REQUEST:String = "request";

		/**
		 * Included by a receiving entity that wishes to inform the
		 * sending entity that the message has been received.
		 *
		 * <p>The <strong>received</strong> element SHOULD be the only child of
		 * the <strong>message</strong> stanza and MUST mirror the 'id' of the sent message.</p>
		 *
		 * @see http://xmpp.org/extensions/xep-0184.html
		 */
		public static const RECEIPT_RECEIVED:String = "received";

		/**
		 * The namespace used in the message delivery node.
		 *
		 * @see http://xmpp.org/extensions/xep-0184.html
		 */
		public static const NS_RECEIPT:String = "urn:xmpp:receipts";

		/**
		 * The namespace used in the message delivery node.
		 *
		 * @see http://xmpp.org/extensions/xep-0224.html
		 */
		public static const NS_ATTENTION:String = "urn:xmpp:attention:0";

		/**
		 * The namespace used in the XEP-0308: Last Message Correction.
		 *
		 * @see http://xmpp.org/extensions/xep-0308.html
		 */
		public static const NS_CORRECTION:String = "urn:xmpp:message-correct:0";

		private static var _idGenerator:IIDGenerator = new IncrementalGenerator( "m_" );

		/**
		 * A class for abstraction and encapsulation of message data.
		 *
		 * <p>The <strong>message</strong> stanza kind can be seen as a "push" mechanism whereby
		 * one entity pushes information to another entity, similar to the
		 * communications that occur in a system such as email.  All message
		 * stanzas SHOULD possess a 'to' attribute that specifies the intended
		 * recipient of the message; upon receiving such a stanza, a server
		 * SHOULD route or deliver it to the intended recipient (see Server
		 * Rules for Handling XML Stanzas (Section 10) for general routing and
		 * delivery rules related to XML stanzas).</p>
		 *
		 * @param	recipient The JID of the message recipient
		 * @param	sender The JID of the message sender - the server should report an error if this is falsified
		 * @param	msgID The message ID
		 * @param	msgBody The message body in plain-text format
		 * @param	msgHTMLBody The message body in XHTML format
		 * @param	msgType The message type
		 * @param	msgSubject (Optional) The message subject
		 * @param	chatState (Optional) The chat state
		 */
		public function Message( recipient:EscapedJID = null, msgID:String = null, msgBody:String = null, msgHTMLBody:String = null, msgType:String = null, msgSubject:String = null, chatState:String = null )
		{
			// Flash gives a warning if superconstructor is not first, hence the inline id check
			var id:String = (msgID != null) ? msgID : Message.generateID();

			super( recipient, null, msgType, id, XMPPStanza.ELEMENT_MESSAGE );

			body = msgBody;
			htmlBody = msgHTMLBody;
			subject = msgSubject;
			state = chatState;
		}

		/**
		 * Generates a unique ID for the stanza. ID generation is handled using
		 * a variety of mechanisms, but the default for the library uses the IncrementalGenerator.
		 *
		 * @param	prefix The prefix for the ID to be generated
		 * @return	The generated ID
		 */
		public static function generateID( prefix:String=null ):String
		{
			return XMPPStanza.xiff_internal::generateID( _idGenerator, prefix );
		}

		/**
		 * The ID generator for this stanza type. ID generators must implement
		 * the IIDGenerator interface. The XIFF library comes with a few default
		 * ID generators that have already been implemented (see org.igniterealtime.xiff.data.id.*).
		 *
		 * Setting the ID generator by stanza type is useful if you'd like to use
		 * different ID generation schemes for each type. For instance, messages could
		 * use the incremental ID generation scheme provided by the IncrementalGenerator class, while
		 * IQs could use the shared object ID generation scheme provided by the SOIncrementalGenerator class.
		 *
		 * @param	generator The ID generator class
		 * @example	The following sets the ID generator for the Message stanza type to an IncrementalGenerator
		 * found in org.igniterealtime.xiff.data.id.IncrementalGenerator:
		 * <pre>Message.idGenerator = new IncrementalGenerator();</pre>
		 */
		public static function get idGenerator():IIDGenerator
		{
			return _idGenerator;
		}
		public static function set idGenerator( value:IIDGenerator ):void
		{
			_idGenerator = value;
		}

		/**
		 * The message body in plain-text format. If a client cannot render HTML-formatted
		 * text, this text is typically used instead.
		 *
		 * <p>Use <code>null</code> to remove.</p>
		 */
		public function get body():String
		{
			return getField("body");
		}
		public function set body( value:String ):void
		{
			setField("body", value);
		}

		/**
		 * The message body in XHTML format. Internally, this uses the XHTML data extension.
		 *
		 * TODO: Use extension registery to solve if the proper extension is enabled...
		 *
		 * <p>Use <code>null</code> to remove.</p>
		 *
		 * @see http://xmpp.org/extensions/xep-0071.html
		 * @see	org.igniterealtime.xiff.data.xhtml.XHTMLExtension
		 */
		public function get htmlBody():String
		{
			try
			{
				var ext:XHTMLExtension = getAllExtensionsByNS(XHTMLExtension.NS)[0];
				return ext.body;
			}
			catch (error:Error)
			{
				trace("Error : null trapped. Resuming.");
			}
			return null;
		}
		public function set htmlBody( value:String ):void
		{
			// Removes any existing HTML body text first
			removeAllExtensions(XHTMLExtension.NS);

			if (value != null)
			{
				var ext:XHTMLExtension = new XHTMLExtension(xml);
				ext.body = value;
				addExtension(ext);
			}
		}

		/**
		 * The message subject. Typically chat and groupchat-type messages do not use
		 * subjects. Rather, this is reserved for normal and headline-type messages.
		 *
		 * <p>Use <code>null</code> to remove.</p>
		 */
		public function get subject():String
		{
			return getField("subject");
		}
		public function set subject( value:String ):void
		{
			setField("subject", value);
		}

		/**
		 * The message thread ID. Threading is used to group messages of the same discussion together.
		 * The library does not perform message grouping, rather it is up to any client authors to
		 * properly perform this task.
		 *
		 * <p>Use <code>null</code> to remove.</p>
		 */
		public function get thread():String
		{
			return getField("thread");
		}
		public function set thread( value:String ):void
		{
			setField("thread", value);
		}

		/**
		 * Time of the message in case of a delay. Used only for messages
		 * which were sent while user was offline.
		 *
		 * <p>Can be set only via XML as the value should come from the server.</p>
		 *
		 * <p>There are two ways that might be possible coming from the server,
		 * XEP-0203 or XEP-0091, of which the latter is legacy.</p>
		 *
		 * <p>XEP-0203: <code>CCYY-MM-DDThh:mm:ss[.sss]TZD</code></p>
		 * <p>XEP-0091: <code>CCYYMMDDThh:mm:ss</code></p>
		 *
		 * @see http://xmpp.org/extensions/xep-0203.html
		 * @see http://xmpp.org/extensions/xep-0091.html
		 */
		public function get time():Date
		{
			return delayedDelivery;
		}

		/**
		 * The chat state if any. Possible values are:
		 * <ul>
		 * <li>Message.STATE_ACTIVE</li>
		 * <li>Message.STATE_COMPOSING</li>
		 * <li>Message.STATE_PAUSED</li>
		 * <li>Message.STATE_INACTIVE</li>
		 * <li>Message.STATE_GONE</li>
		 * </ul>
		 * <p>Use <code>null</code> to remove.</p>
		 *
		 * <p>TODO: XEP states that this protocol SHOULD NOT be used
		 * with message types other than "chat" or "groupchat".</p>
		 *
		 * @see http://xmpp.org/extensions/xep-0085.html
		 */
		public function get state():String
		{
			var list:Array = [
				Message.STATE_ACTIVE,
				Message.STATE_COMPOSING,
				Message.STATE_PAUSED,
				Message.STATE_INACTIVE,
				Message.STATE_GONE
			];
			var len:uint = list.length;
			for (var i:uint = 0; i < len; ++i)
			{
				var value:String = list[i];
				if (xml.children().(localName() == value).length() > 0)
				{
					return value;
				}
			}
			return null;
		}
		public function set state( value:String ):void
		{
			if (value != Message.STATE_ACTIVE
				&& value != Message.STATE_COMPOSING
				&& value != Message.STATE_PAUSED
				&& value != Message.STATE_INACTIVE
				&& value != Message.STATE_GONE
				&& value != null)
			{
				throw new Error("Invalid 'state' value: " + value + " for ChatState");
			}

			/*
			5.5 Use in Groupchat:
				A client MAY send chat state notifications even if not all room occupants do so.
				A client SHOULD NOT generate <gone/> notifications.
				A client SHOULD ignore <gone/> notifications received from other room occupants.
			*/

			if ( value == null )
			{
				delete xml[Message.STATE_ACTIVE];
				delete xml[Message.STATE_COMPOSING];
				delete xml[Message.STATE_PAUSED];
				delete xml[Message.STATE_INACTIVE];
				delete xml[Message.STATE_GONE];
			}
			else
			{
				xml[value].@xmlns = Message.NS_STATE;
			}
		}

		/**
		 * XEP-0184: Message Delivery Receipts
		 *
		 * <p>This XMPP protocol extension for message delivery receipts,
		 * whereby the sender of a message can request notification that the
		 * message has been delivered to a client controlled by the intended
		 * recipient.</p>
		 *
		 * @see http://xmpp.org/extensions/xep-0184.html
		 */
		public function get receipt():String
		{
			var list:Array = [
				Message.RECEIPT_REQUEST,
				Message.RECEIPT_RECEIVED
			];
			var len:uint = list.length;
			for (var i:uint = 0; i < len; ++i)
			{
				var value:String = list[i];
				if (xml.children().(localName() == value).length() > 0)
				{
					return value;
				}
			}
			return null;
		}
		public function set receipt( value:String ):void
		{
			if (value != Message.RECEIPT_REQUEST
				&& value != Message.RECEIPT_RECEIVED
				&& value != null)
			{
				throw new Error("Invalid 'receipt' value: " + value + " for DeliveryReceipt");
			}

			if ( value == null )
			{
				delete xml[Message.RECEIPT_REQUEST];
				delete xml[Message.RECEIPT_RECEIVED];
			}
			else
			{
				xml[value].@xmlns = Message.NS_RECEIPT;
			}
		}

		/**
		 * Message ID of the message that had receipt request.
		 * Can be set only when the 'receipt' is Message.RECEIPT_RECEIVED.
		 *
		 * <p>While sending 'received', this property must be set to
		 * the message id that contained the 'request'.</p>
		 *
		 * @see http://xmpp.org/extensions/xep-0184.html
		 */
		public function get receiptId():String
		{
			return getChildAttribute(Message.RECEIPT_RECEIVED, "id");
		}
		public function set receiptId( value:String ):void
		{
			setChildAttribute(Message.RECEIPT_RECEIVED, "id", value);
		}

		/**
		 * Messages containing an attention extension SHOULD use the headline message
		 * type to avoid offline storage. In case the <code>attention</code> property is used,
		 * <code>type</code> is set to "headline" automatically.
		 *
		 * <p>However there is no check for the type when removing the attention, by setting it to false.</p>
		 *
		 * @see http://xmpp.org/extensions/xep-0224.html
		 */
		public function get attention():Boolean
		{
			return getField("attention") != null;
		}
		public function set attention(value:Boolean):void
		{
			if (value)
			{
				xml.attention = "";
				xml.attention.setNamespace( Message.NS_ATTENTION );

				// avoid offline storage
				type = Message.TYPE_HEADLINE;
			}
			else
			{
				delete xml.attention;
			}
		}

		/**
		 * When sending a message, people often introduce typing errors and send a follow-up message to correct them.
		 * This property allows the sending client to flag the second message as correcting the first.
		 *
		 * @see http://xmpp.org/extensions/xep-0308.html
		 */
		public function get correction():Boolean
		{
			return getField("replace") != null;
		}
		public function set correction( value:Boolean ):void
		{
			if (value)
			{
				xml["replace"].setNamespace( Message.NS_CORRECTION );
			}
			else
			{
				delete xml["replace"];
			}
		}

		/**
		 * Message ID of the message that is to be corrected.
		 *
		 * @see http://xmpp.org/extensions/xep-0308.html
		 */
		public function get correctionId():String
		{
			return getChildAttribute("replace", "id");
		}
		public function set correctionId( value:String ):void
		{
			setChildAttribute("replace", "id", value);
		}
	}
}