package org.uqbar.project.wollok.codeGenerator.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.NamedObjectType
import org.uqbar.project.wollok.codeGenerator.model.types.NumericType
import org.uqbar.project.wollok.codeGenerator.model.types.Type
import org.uqbar.project.wollok.codeGenerator.model.types.context.MessageSentTypeContext
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*

@Accessors
class MessageSend implements Expression {
	static val possibleStrategies = #[new NumbersOperationsStrategy, new NamedObjectReceiverStrategy]

	var Expression receiver
	var String selector
	var List<Expression> parameters
	val Expression parent
	var MessageSendStrategy strategy

	new(Expression parent) {
		this.parent = parent
	}

	override typeFor(TypeContext tc) {
		val newContext = new MessageSentTypeContext(tc, receiver.typeFor(tc))

		checkIfDetectedStrategy(newContext)
		strategy.type(this, newContext)
	}

	def checkIfDetectedStrategy(MessageSentTypeContext tc) {
		if (strategy == null) {
			strategy = possibleStrategies.findFirst[canApply(this, tc)]
			if (strategy == null)
				throw new RuntimeException("There is not possible messageSendStrategy to apply")
		}
	}

}

interface MessageSendStrategy {
	def Type type(MessageSend send, MessageSentTypeContext tc)

	def boolean canApply(MessageSend send, MessageSentTypeContext tc)
}

class NumbersOperationsStrategy implements MessageSendStrategy {
	override type(MessageSend send, MessageSentTypeContext tc) {
		val originalTC = tc.parentContext
		val receiverType = send.receiver.typeFor(originalTC).nativeType
		val parameterType = send.parameters.get(0).typeFor(originalTC).nativeType

		// By now, let's make it close, if I operate to int I get an int, and if I mix, I coerce to the more general type.
		new NumericType(receiverType.max(parameterType))
	}

	override canApply(MessageSend send, MessageSentTypeContext tc) {
		val originalTC = tc.parentContext
		send.receiver.typeFor(originalTC).isNumericType && send.parameters.size == 1 &&
			send.parameters.get(0).typeFor(originalTC).isNumericType
	}

}

class NamedObjectReceiverStrategy implements MessageSendStrategy {

	override type(MessageSend send, MessageSentTypeContext tc) {
		val type = send.receiver.typeFor(tc.parentContext) as NamedObjectType
		val obj = type.object
		val method = obj.getMethodNamed(send.selector)

		tc.method = method
		method.typeFor(tc)
	}

	override canApply(MessageSend send, MessageSentTypeContext tc) {
		send.receiver.typeFor(tc.parentContext).isNamedObject
	}
}
