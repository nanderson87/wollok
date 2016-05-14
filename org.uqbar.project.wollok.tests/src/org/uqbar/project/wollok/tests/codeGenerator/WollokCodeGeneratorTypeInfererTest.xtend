package org.uqbar.project.wollok.tests.codeGenerator

import org.junit.Test
import org.uqbar.project.wollok.codeGenerator.CodeAnalyzer
import org.uqbar.project.wollok.codeGenerator.model.types.NativeTypesEnum
import org.uqbar.project.wollok.tests.interpreter.AbstractWollokInterpreterTestCase

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*

class WollokCodeGeneratorTypeInfererTest extends AbstractWollokInterpreterTestCase {
	
	@Test
	def void smallSumProgram(){
		val model = 
		'''
			program p {
				var x = 23
				var y = 50
				
				return x + y
			}
		'''.parse
		
		val analyzer = new CodeAnalyzer
		val pgm = analyzer.performAnalysis(model)
		val varX = pgm.variables.get("x")
		
		assertEquals(NativeTypesEnum.INT, pgm.variables.get('x').type.nativeType)
		assertEquals(NativeTypesEnum.INT, pgm.returnVariable.type.nativeType) 
	}

	@Test
	def void smallSumProgramUsingInmediates(){
		val model = 
		'''
			program p {
				var x = 23
				
				return x + 34
			}
		'''.parse
		
		val analyzer = new CodeAnalyzer
		val pgm = analyzer.performAnalysis(model)
		val varX = pgm.variables.get("x")
		
		assertEquals(NativeTypesEnum.INT, pgm.variables.get('x').type.nativeType)
		assertEquals(NativeTypesEnum.INT, pgm.returnVariable.type.nativeType) 
	}

}