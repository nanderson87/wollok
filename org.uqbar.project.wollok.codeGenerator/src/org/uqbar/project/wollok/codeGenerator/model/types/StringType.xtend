package org.uqbar.project.wollok.codeGenerator.model.types

import org.uqbar.project.wollok.codeGenerator.model.types.NativeType

class StringType extends NativeType {
	override getNativeType() {
		NativeTypesEnum.STRING
	}
	
	def dispatch doEquals(Object obj) {
		false
	}
	
	def dispatch doEquals(StringType str){
		true
	}
	
	override doHashCode() {
		NativeTypesEnum.STRING.hashCode
	}
	
}