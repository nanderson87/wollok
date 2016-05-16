package org.uqbar.project.wollok.tests.codeGenerator

import org.junit.Test
import org.uqbar.project.wollok.codeGenerator.CodeAnalyzer
import org.uqbar.project.wollok.codeGenerator.model.types.NativeTypesEnum
import org.uqbar.project.wollok.tests.interpreter.AbstractWollokInterpreterTestCase

import static extension org.uqbar.project.wollok.codeGenerator.model.types.TypeExtensions.*
import org.uqbar.project.wollok.codeGenerator.model.types.context.RootTypeContext

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
		val typeContext = new RootTypeContext(pgm)
		
		assertEquals(NativeTypesEnum.INT, pgm.variables.get('x').typeFor(typeContext).nativeType)
		assertEquals(NativeTypesEnum.INT, pgm.returnVariable.typeFor(typeContext).nativeType) 
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
		val typeContext = new RootTypeContext(pgm)
		
		assertEquals(NativeTypesEnum.INT, pgm.variables.get('x').typeFor(typeContext).nativeType)
		assertEquals(NativeTypesEnum.INT, pgm.returnVariable.typeFor(typeContext).nativeType) 
	}


	@Test
	def void smallSumProgramWithWKO(){
		val model = 
		'''
			object obj {
				method suma(){
					return 23 + 24
				}
			}
			program p {
				return obj.suma()
			}
		'''.parse
		
		val analyzer = new CodeAnalyzer
		val pgm = analyzer.performAnalysis(model)
		val typeContext = new RootTypeContext(pgm)

		assertEquals(NativeTypesEnum.INT, pgm.returnVariable.typeFor(typeContext).nativeType) 
	}


	@Test
	def void smallSumProgramWithWKOUsingVariables(){
		val model = 
		'''
			object obj {
				const a = 17
				
				method suma(){
					return 23 + a
				}
			}
			program p {
				return obj.suma(17)
			}
		'''.parse
		
		val analyzer = new CodeAnalyzer
		val pgm = analyzer.performAnalysis(model)
		val typeContext = new RootTypeContext(pgm)
		
		assertEquals(NativeTypesEnum.INT, pgm.returnVariable.typeFor(typeContext).nativeType) 
	}


	@Test
	def void smallSumProgramWithWKOUsingVariablesShadowing(){
		val model = 
		'''
			object obj {
				const a = 17
				
				method suma(){
					return 23 + a
				}
			}
			program p {
				var a
				a = obj
				return a.suma(17)
			}
		'''.parse
		
		val analyzer = new CodeAnalyzer
		val pgm = analyzer.performAnalysis(model)
		val typeContext = new RootTypeContext(pgm)
		
		assertEquals(NativeTypesEnum.INT, pgm.returnVariable.typeFor(typeContext).nativeType) 
	}

}