package org.uqbar.project.wollok.codeGenerator

import org.eclipse.emf.ecore.EObject
import org.uqbar.project.wollok.codeGenerator.model.Expression
import org.uqbar.project.wollok.codeGenerator.model.MessageSend
import org.uqbar.project.wollok.codeGenerator.model.NumberLiteral
import org.uqbar.project.wollok.codeGenerator.model.Program
import org.uqbar.project.wollok.codeGenerator.model.Return
import org.uqbar.project.wollok.codeGenerator.model.Variable
import org.uqbar.project.wollok.codeGenerator.model.VariableRef
import org.uqbar.project.wollok.wollokDsl.WBinaryOperation
import org.uqbar.project.wollok.wollokDsl.WFile
import org.uqbar.project.wollok.wollokDsl.WMemberFeatureCall
import org.uqbar.project.wollok.wollokDsl.WNumberLiteral
import org.uqbar.project.wollok.wollokDsl.WProgram
import org.uqbar.project.wollok.wollokDsl.WReturnExpression
import org.uqbar.project.wollok.wollokDsl.WVariableDeclaration
import org.uqbar.project.wollok.wollokDsl.WVariableReference

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

	def dispatch Expression analyze(WVariableDeclaration vd, Expression parent) {
		val v = new Variable(parent, vd.variable.name)
		v.initialValue = vd.right.analyze(v)
		parent.context.variables.put(v.name, v)
		v
	}

	def dispatch Expression analyze(WFile file, Expression parent) {
		file.elements.forEach[it.analyze(rootContext)]
		file.main.analyze(rootContext)
		rootContext
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
		val ret = new Return(parent);
		ret.expression = wReturn.expression.analyze(ret)
		
		parent.context.returnVariable.assignations.add(ret)
		ret
	}

	def dispatch Expression analyze(WBinaryOperation b, Expression parent) {
		new MessageSend(parent) =>[
			receiver = b.leftOperand.analyze(it)
			selector = b.feature
			parameters =  #[b.rightOperand.analyze(it)]
		]
	}
	
	def performAnalysis(WFile file) {
		file.analyze(null) as Program
	}

}
