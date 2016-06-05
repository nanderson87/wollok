package org.uqbar.project.wollok.codeGenerator.model.types

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

class UnionType extends Type {

	@Accessors
	val Set<Type> types

	new(Set<Type> types) {
		this.types = types
	}
	
	override combineWith(Type other) {
		types.add(other)
		this
	}
		
	def dispatch doEquals(Object obj) {
		true
	}
	
	def dispatch doEquals(UnionType obj){
		types.equals(obj.types)
	}
	
	override doHashCode() {
		types.hashCode
	}
	
}
