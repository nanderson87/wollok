package org.uqbar.project.wollok.codeGenerator.model

import java.util.List
import java.util.Map

interface Context {
	def List<Expression> getOperations()
	def Map<String, Variable> getVariables()
	def Variable getReturnVariable()
}