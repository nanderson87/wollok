package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.Type
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

interface Context extends Expression {
	def Variable getVariableNamed(String name)
	def boolean hasVariable(String name)
	def void putVariableNamed(String name, Variable v)
}

@Accessors
abstract class AbstractContext implements Context{
	val variables = <String, Variable>newLinkedHashMap()
	
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

interface MethodContext extends Context {
	def Variable getReturnVariable()
	def Type returnTypeFor(TypeContext tc)
}

@Accessors
abstract class AbstractCompositeContext extends AbstractContext implements MethodContext {
	val operations = <Expression>newArrayList();
	val returnVariable = new Variable(this, "_return");

	override typeFor(TypeContext tc) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override returnTypeFor(TypeContext tc){
		returnVariable.typeFor(tc)
	}
}
