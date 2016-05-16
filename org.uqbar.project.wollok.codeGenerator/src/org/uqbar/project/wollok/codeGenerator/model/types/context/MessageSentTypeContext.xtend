package org.uqbar.project.wollok.codeGenerator.model.types.context

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.Context
import org.uqbar.project.wollok.codeGenerator.model.types.Type

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*

@Accessors
class MessageSentTypeContext implements TypeContext {
	
	var Context method 
	val TypeContext receiver
	val TypeContext parentContext 
	
	new(TypeContext parentContext, Type receiver){
		this.receiver = receiver.asTypeContext(parentContext)
		this.parentContext = parentContext
	}
	
	override typeForVariable(String name) {
		if(method.hasVariable(name))
			return method.getVariableNamed(name).typeFor(this)
			
		receiver.typeForVariable(name)
	}
	
}