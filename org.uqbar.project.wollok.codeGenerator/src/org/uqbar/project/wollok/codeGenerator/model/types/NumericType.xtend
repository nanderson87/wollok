package org.uqbar.project.wollok.codeGenerator.model.types

import org.uqbar.project.wollok.codeGenerator.model.types.Type

class NumericType implements Type {
	val NumericTypesEnum realType
	
	new(Number value){
		this.realType = typeName(value)
	}
	
	def dispatch typeName(Double e) { NumericTypesEnum.DOUBLE }
	def dispatch typeName(Float e) { NumericTypesEnum.DOUBLE }

	def dispatch typeName(Integer e) { NumericTypesEnum.INT }
	def dispatch typeName(Long e) { NumericTypesEnum.INT }
	def dispatch typeName(Short e) { NumericTypesEnum.INT }
}

enum NumericTypesEnum {
	DOUBLE, INT
}