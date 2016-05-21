package org.uqbar.project.wollok.codeGenerator.model.types.context

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.ClassDefinition

@Accessors
class ClassTypeContext implements TypeContext {

	val TypeContext parentContext 
	val ClassDefinition classDefinition
	
	new(TypeContext context, ClassDefinition classDefinition) {
		this.parentContext = context
		this.classDefinition = classDefinition
	}
	
	override typeForVariable(String name) {
		if(classDefinition.hasVariable(name))
			classDefinition.getVariableNamed(name).typeFor(this)
		else
			parentContext.typeForVariable(name)
	}
	
	override getSelfType() {
		parentContext.selfType
	}
	
	override resolveClass(String name) {
		parentContext.resolveClass(name)
	}
	
}