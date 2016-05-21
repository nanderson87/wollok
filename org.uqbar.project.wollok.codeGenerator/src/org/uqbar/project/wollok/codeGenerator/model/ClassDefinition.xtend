package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

@Accessors
class ClassDefinition extends AbstractMethodContext {

	val Program parent 
	val String name
	val ClassDefinition superClass
	
	val methods = <String,Method>newHashMap
	
	new(Program parent, String name, ClassDefinition superClass){
		this.parent = parent
		this.name = name
		this.superClass = superClass
	}
	
	override typeFor(TypeContext tc) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def Method getMethodNamed(String name) {
		if(methods.containsKey(name)){
			return methods.get(name)
		}
		
		if(superClass != null)
			superClass.getMethodNamed(name)
		else
			throw new RuntimeException("Unknown method:" + name)
	}
	
	def putMethodNamed(String name, Method method) {
		methods.put(name, method)
	}
	
}