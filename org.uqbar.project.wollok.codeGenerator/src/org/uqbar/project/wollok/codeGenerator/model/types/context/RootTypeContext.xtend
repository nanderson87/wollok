package org.uqbar.project.wollok.codeGenerator.model.types.context

import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext
import org.uqbar.project.wollok.codeGenerator.model.Program

class RootTypeContext implements TypeContext {
	
	val Program program
	
	new(Program program) {
		this.program = program
	}
	
	override typeForVariable(String name) {
		program.getVariableNamed(name).typeFor(this)
	}
	
	override getParentContext() {
		this
	}
	
	override getSelfType() {
		throw new UnsupportedOperationException("There is no self in the context of the program")
	}
	
	override resolveClass(String name) {
		program.resolveWollokClass(name)
	}
	
}