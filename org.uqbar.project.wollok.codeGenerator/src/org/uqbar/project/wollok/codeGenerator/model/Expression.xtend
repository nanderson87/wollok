package org.uqbar.project.wollok.codeGenerator.model

import org.uqbar.project.wollok.codeGenerator.model.types.Type
import org.uqbar.project.wollok.codeGenerator.model.types.context.TypeContext

interface Expression {
	def Type typeFor(TypeContext tc)
	def Expression getParent()
}