package org.uqbar.project.wollok.codeGenerator.model

import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext
import org.uqbar.project.wollok.codeGenerator.model.types.NullType

class Block extends AbstractCompositeContext {
	val Expression parent
	
	new(Expression parent){
		this.parent = parent
	}

	override getParent() {
		parent
	}

	override typeFor(TypeContext tc) {
		if(operations.empty)
			new NullType
		else
			operations.last.typeFor(tc)
	}
		
}