package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class Parameter implements Expression {
	val String name
	val Method parent
	
	new(String name, Method parent){
		this.name = name
		this.parent = parent
	}
	
	override typeFor(TypeContext tc) {
		tc.typeForVariable(name)
	}
	
}