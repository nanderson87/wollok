package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.NullType
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class IfExpression implements Expression {
	val Expression parent
	var Expression condition
	var Expression trueSide
	var Expression falseSide
	
	new(Expression parent){
		this.parent = parent
	}
	
	override typeFor(TypeContext tc) {
		if(falseSide == null){
			return trueSide.typeFor(tc).combineWith(new NullType())
		}
		trueSide.typeFor(tc).combineWith(falseSide.typeFor(tc))
	}
	
}