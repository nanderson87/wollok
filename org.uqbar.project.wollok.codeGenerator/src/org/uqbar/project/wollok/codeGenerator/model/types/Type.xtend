package org.uqbar.project.wollok.codeGenerator.model.types

interface Type {
}

interface NativeType extends Type {
	def NativeTypesEnum getNativeType()
}