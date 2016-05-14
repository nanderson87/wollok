package org.uqbar.project.wollok.codeGenerator.model.types

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class NumericType implements NativeType {
	val NativeTypesEnum nativeType
	
	new(Number value){
		this.nativeType = typeName(value)
	}

	new(NativeTypesEnum nativeType){
		this.nativeType = nativeType
	}
	
	override toString(){
		nativeType.toString
	}
	
	def dispatch typeName(Double e) { NativeTypesEnum.DOUBLE }
	def dispatch typeName(Float e) { NativeTypesEnum.DOUBLE }

	def dispatch typeName(Integer e) { NativeTypesEnum.INT }
	def dispatch typeName(Long e) { NativeTypesEnum.INT }
	def dispatch typeName(Short e) { NativeTypesEnum.INT }
}

