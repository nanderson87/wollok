package org.uqbar.project.wollok.codeGenerator

import org.eclipse.emf.ecore.EObject

import org.uqbar.project.wollok.codeGenerator.model.Expression
import org.uqbar.project.wollok.codeGenerator.model.MessageSend
import org.uqbar.project.wollok.codeGenerator.model.Method
import org.uqbar.project.wollok.codeGenerator.model.NamedObject
import org.uqbar.project.wollok.codeGenerator.model.NumberLiteral
import org.uqbar.project.wollok.codeGenerator.model.Program
import org.uqbar.project.wollok.codeGenerator.model.Return
import org.uqbar.project.wollok.codeGenerator.model.Variable
import org.uqbar.project.wollok.codeGenerator.model.VariableRef
import org.uqbar.project.wollok.wollokDsl.WBinaryOperation
import org.uqbar.project.wollok.wollokDsl.WBlockExpression
import org.uqbar.project.wollok.wollokDsl.WFile
import org.uqbar.project.wollok.wollokDsl.WMemberFeatureCall
import org.uqbar.project.wollok.wollokDsl.WMethodDeclaration
import org.uqbar.project.wollok.wollokDsl.WNamedObject
import org.uqbar.project.wollok.wollokDsl.WNumberLiteral
import org.uqbar.project.wollok.wollokDsl.WProgram
import org.uqbar.project.wollok.wollokDsl.WReturnExpression
import org.uqbar.project.wollok.wollokDsl.WVariableDeclaration
import org.uqbar.project.wollok.wollokDsl.WVariableReference
import org.uqbar.project.wollok.codeGenerator.model.Context

import static extension org.uqbar.project.wollok.codeGenerator.ModelExtensions.*
import org.uqbar.project.wollok.wollokDsl.WAssignment
import org.uqbar.project.wollok.codeGenerator.model.Assignment

class CodeAnalyzer {
	val rootContext = new Program
	
	def dispatch Expression analyze(WProgram program, Expression parent) {
		program.eContents.forEach [
			rootContext.operations.add(it.analyze(rootContext))
		]
		rootContext
	}

	def dispatch Expression analyze(EObject o, Expression parent) {
		throw new RuntimeException("This should be implemented: " + o?.class.name)
	}

	def dispatch Expression analyze(WNumberLiteral o, Expression parent) { new NumberLiteral(parent, o.value) }

	def dispatch Expression analyze(WNamedObject o, Context parent){
		new NamedObject(o.name, parent) => [
			o.members.forEach[ e | e.analyze(it) ]	
			parent.putVariableNamed(o.name, new Variable(parent, o.name) =>[ v | v.initialValue = it ])
		]
	}

	def dispatch Expression analyze(WVariableDeclaration vd, Context parent) {
		new Variable(parent, vd.variable.name) => [
			initialValue = vd.right?.analyze(it)
			parent.putVariableNamed(name, it)
		]
	}

	def dispatch Expression analyze(WMemberFeatureCall mfc, Expression parent) {
		new MessageSend(parent) => [ ms |
			ms.receiver = mfc.memberCallTarget.analyze(ms)
			ms.selector = mfc.feature
			ms.parameters = mfc.memberCallArguments.map[analyze(ms)]
		]
	}

	def dispatch Expression analyze(WVariableReference vr, Expression parent) {
		new VariableRef(parent, vr.ref.name);
	}

	def dispatch Expression analyze(WReturnExpression wReturn, Expression parent) {
		new Return(parent) => [
			expression = wReturn.expression.analyze(it)
			parent.findContext.returnVariable.assignations.add(it)
		]
	}
	
	def dispatch Expression analyze(WBinaryOperation b, Expression parent) {
		new MessageSend(parent) =>[
			receiver = b.leftOperand.analyze(it)
			selector = b.feature
			parameters =  #[b.rightOperand.analyze(it)]
		]
	}
	
	def dispatch Expression analyze(WMethodDeclaration m, NamedObject parent){
		new Method(parent) => [
			it.operations.addAll(m.parameters.map[ e | e.analyze(it)])
			m.expression.analyze(it)
			parent.putMethodNamed(m.name, it)
		]
	}
	
	def dispatch Expression analyze(WAssignment wa, Expression parent){
		new Assignment(parent) => [
			variableName = wa.feature.ref.name
			expression = wa.value.analyze(it)
			parent.findContext.getVariableNamed(variableName).assignations.add(expression)
		]
	}
	
	def dispatch Expression analyze(WBlockExpression b, Method parent){
		b.expressions.forEach[ e | e.analyze(parent)]
		parent
	}	
	
	def performAnalysis(WFile file) {
		file.elements.forEach[it.analyze(rootContext)]
		file.main.analyze(rootContext)
		rootContext
	}

}
