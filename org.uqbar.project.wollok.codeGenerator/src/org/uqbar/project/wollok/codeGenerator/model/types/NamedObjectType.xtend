package org.uqbar.project.wollok.codeGenerator.model.types

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.NamedObject

@Accessors
class NamedObjectType extends Type {
	val NamedObject object 
	
	new (NamedObject obj){
		this.object = obj
	}
	
	def dispatch doEquals(Object obj) {
		false
	}
	
	def dispatch doEquals(NamedObjectType other){
		object == other.object
	}
	
	override doHashCode() {
		object.hashCode
	}
}