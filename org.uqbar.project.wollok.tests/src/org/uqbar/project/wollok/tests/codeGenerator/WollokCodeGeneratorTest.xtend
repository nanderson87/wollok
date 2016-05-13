package org.uqbar.project.wollok.tests.codeGenerator

import org.junit.Test
import org.uqbar.project.wollok.codeGenerator.CodeAnalyzer
import org.uqbar.project.wollok.tests.interpreter.AbstractWollokInterpreterTestCase

class WollokCodeGeneratorTest extends AbstractWollokInterpreterTestCase {
	
	@Test
	def void parsingProgram(){
		val model = 
		'''
			program p {
				var x = 23
				var y = 50
				
				return x + y
			}
		'''.parse
		
		val analyzer = new CodeAnalyzer
		analyzer.analyze(model) 
	}
}