package org.uqbar.project.wollok.codeGenerator.model.types.context

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.NamedObject

@Accessors
class NamedObjectTypeContext implements TypeContext {

	val TypeContext parentContext 
	val NamedObject object
	
	new(TypeContext context, NamedObject object) {
		this.parentContext = context
		this.object = object
	}
	
	override typeForVariable(String name) {
		if(object.hasVariable(name))
			object.getVariableNamed(name).typeFor(this)
		else
			parentContext.typeForVariable(name)
	}
	
}