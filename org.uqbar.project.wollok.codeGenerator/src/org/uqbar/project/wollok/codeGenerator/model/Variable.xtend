package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.Type
import org.uqbar.project.wollok.codeGenerator.model.types.UnknownType
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class Variable implements Expression{
	
	String name
	val Expression parent
	
	val assignations = <Expression> newArrayList()	
	var Expression initialValue
	
	new(Expression parent, String name) {
		this.name = name
		this.parent = parent
	}
	
	def setInitialValue(Expression e){
		initialValue = e
		if(e != null)
			assignations.add(e)
	}
	
	override typeFor(TypeContext tc) {
		val types = assignations.map[typeFor(tc)]
		types.fold(new UnknownType) [ Type t1, t2 | t1.combineWith(t2)]
	}
	
}