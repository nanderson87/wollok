package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class Assignment implements Expression {
	
	val Expression parent
	var Expression expression
	var String variableName
	
	new(Expression parent) {
		this.parent = parent
	}
	
	override typeFor(TypeContext tc) {
		expression.typeFor(tc)
	}
	
}