package org.uqbar.project.wollok.codeGenerator.model

import java.text.NumberFormat
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.model.types.NumericType

@Accessors
class NumberLiteral implements Expression {

	val Number value;
	val Expression parent
	
	new(Expression parent, String value) {
		this.value = NumberFormat.instance.parse(value)
		this.parent = parent
	}
	
	override getType() {
		new NumericType(value)
	}
	
	override getContext() {
		parent.context
	}
}