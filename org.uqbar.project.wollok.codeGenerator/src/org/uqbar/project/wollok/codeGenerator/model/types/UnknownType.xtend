package org.uqbar.project.wollok.codeGenerator.model.types

class UnknownType extends Type {
	
	override combineWith(Type other) {
		return other
	}
	
	def dispatch doEquals(Object obj) {
		false
	}
	
	def dispatch doEquals(UnknownType obj){
		true
	}
	
	override doHashCode() {
		class.hashCode
	}
	
}