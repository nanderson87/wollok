package org.uqbar.project.wollok.codeGenerator.model

import org.uqbar.project.wollok.codeGenerator.model.types.Type

interface Expression {
	def Type getType()
	def Expression getParent()
	def Context getContext()
}