package org.uqbar.project.wollok.codeGenerator.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.NumericType
import org.uqbar.project.wollok.codeGenerator.model.types.Type

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*

@Accessors
class MessageSend implements Expression {	
	static val possibleStrategies = #[new NumbersOperationsStrategy]
	 
	var Expression receiver
	var String selector
	var List<Expression> parameters
	val Expression parent
	var MessageSendStrategy strategy
	
	new(Expression parent) {
		this.parent = parent
	}
	
	override getType() {
		checkIfDetectedStrategy()
		strategy.type(this)
	}
	
	def checkIfDetectedStrategy() {
		if(strategy == null){
			strategy = possibleStrategies.findFirst[ canApply(this) ]
			if(strategy == null)
				throw new RuntimeException("There is not possible messageSendStrategy to apply")
		}
	}
	
	override getContext() {
		parent.context
	}
	
}

interface MessageSendStrategy{
	def Type type(MessageSend send)
	def boolean canApply(MessageSend send)
}

class NumbersOperationsStrategy implements MessageSendStrategy {
	override type(MessageSend send) {
		val receiverType = send.receiver.type.nativeType
		val parameterType = send.parameters.get(0).type.nativeType
		
		// By now, let's make it close, if I operate to int I get an int, and if I mix, I coerce to the more general type.
		new NumericType(receiverType.max(parameterType))
	}
	
	override canApply(MessageSend send) {
		send.receiver.type.isNumericType && send.parameters.size == 1 && send.parameters.get(0).type.isNumericType 
	}
	
}


