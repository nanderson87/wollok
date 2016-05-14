package org.uqbar.project.wollok.codeGenerator.model.types

class TypeExtensions {
	static def dispatch isNumericType(NumericType t) { true }
	static def dispatch isNumericType(Type t) { false }
	
	static def dispatch nativeType(NativeType t){ t.nativeType }
	static def dispatch nativeType(Type t) { throw new RuntimeException("There is no native type in " + t.toString ) }
}