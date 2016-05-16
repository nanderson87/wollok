package org.uqbar.project.wollok.codeGenerator.model

import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext
import org.eclipse.xtend.lib.annotations.Accessors

interface Context extends Expression {
	def Variable getReturnVariable()

	def Variable getVariableNamed(String name)

	def boolean hasVariable(String name)

	def void putVariableNamed(String name, Variable v)
}

@Accessors
abstract class AbstractMethodContext implements Context {
	val variables = <String, Variable>newLinkedHashMap()
	val operations = <Expression>newArrayList();
	val returnVariable = new Variable(this, "_return");

	override typeFor(TypeContext tc) {
		returnVariable.typeFor(tc)
	}

	override getParent() {
		parent
	}

	override getVariableNamed(String name) {
		if (!this.hasVariable(name)) {
			throw new RuntimeException("Unknown Variable:" + name)
		}
		variables.get(name)
	}

	override putVariableNamed(String name, Variable v) {
		variables.put(name, v)
	}

	override hasVariable(String name) {
		variables.containsKey(name)
	}

}
