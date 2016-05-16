package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.NamedObjectType
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class NamedObject implements Context {

	val String name
	val variables = <String, Variable>newLinkedHashMap()
	val methods = <String, Method>newLinkedHashMap()
	val Expression parent

	new(String name, Expression parent){
		this.name = name 
		this.parent = parent
	}
	
	override typeFor(TypeContext tc) {
		new NamedObjectType(this)
	}
	
	override getReturnVariable() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getVariableNamed(String name) {
		if(!variables.containsKey(name)) throw new RuntimeException("Unknown Variable:" + name)
		variables.get(name)
	}
	
	override putVariableNamed(String name, Variable v) {
		variables.put(name,v)
	}
	
	def putMethodNamed(String name, Method m) {
		methods.put(name, m)
	}
	
	def getMethodNamed(String name){
		if(!methods.containsKey(name)) 
			throw new RuntimeException("Unknown Method:" + name)
		methods.get(name)
	}
	
	override hasVariable(String name) {
		variables.containsKey(name)
	}

}
