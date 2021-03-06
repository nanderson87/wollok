package org.uqbar.project.wollok.launch.tests.json

import com.google.gson.Gson
import com.google.gson.stream.JsonWriter
import java.io.PrintWriter
import java.util.List
import org.eclipse.emf.common.util.URI
import org.uqbar.project.wollok.interpreter.core.WollokProgramExceptionWrapper
import org.uqbar.project.wollok.launch.Wollok
import org.uqbar.project.wollok.launch.tests.WollokTestsReporter
import org.uqbar.project.wollok.wollokDsl.WFile
import org.uqbar.project.wollok.wollokDsl.WTest
import wollok.lib.AssertionException

import static extension org.uqbar.project.wollok.ui.utils.XTendUtilExtensions.*

/**
 * A test reporter that prints to console in JSON format.
 * Used by mumuki, for example.
 * 
 * @author jfernandes
 */
//TODO: it could be rendering the elapsed time for each test
class WollokJSONTestsReporter implements WollokTestsReporter {
	var testPassed = 0
	var testFailures = 0
	var testErrors = 0

	var JsonWriter _writer

	override testsToRun(WFile file, List<WTest> tests) {
		writer.beginObject => [
			name("version").value(Wollok.VERSION)
			name("tests").beginArray
		]
	}

	override finished() {
		writer => [
			endArray
			writeSummary
			close
		]
	}

	def writeSummary(JsonWriter it) {
		name("summary").beginObject => [
			name("passed").value(testPassed)
			name("failures").value(testFailures)
			name("errors").value(testErrors)
		]
		endObject
	}

	override testStart(WTest test) {}

	def static operator_doubleArrow(JsonWriter writer, Pair<String, Object> pair) {
		pair.value.interpret(writer.name(pair.key))
	}

	def static dispatch interpret(String it, JsonWriter w) { w.value(it) }

	def static dispatch interpret(Number it, JsonWriter w) { w.value(it) }

	def static dispatch interpret((JsonWriter)=>JsonWriter it, JsonWriter w) {
		apply(w.beginObject).endObject
	}

	def static operator_doubleGreaterThan(WollokJSONTestsReporter it, (JsonWriter)=>JsonWriter closure) {
		closure.apply(writer.beginObject).endObject
	}

	override reportTestAssertError(WTest test, AssertionException assertionError, int lineNumber, URI resource) {
		writer => [
			beginObject
				name("name").value(test.name)
				name("state").value("failed")
				name("error").beginObject
					name("message").value(assertionError.message)
					name("file").value(resource.trimFragment.toString)
					name("lineNumber").value(lineNumber)
					name("stackTrace").value(assertionError.stackTraceAsString)
				endObject
			endObject
		]
		testFailures++
	}

	override reportTestOk(WTest test) {
		writer => [
			beginObject 
				name("name").value(test.name) 
				name("state").value("passed") 
			endObject
		]
		testPassed++
	}

	override reportTestError(WTest test, Exception exception, int lineNumber, URI resource) {
		writer => [
			beginObject
				name("name").value(test.name)
				name("state").value("error")
				name("error").beginObject
					name("message").value(exception.theWollokMessage)
					// name("file").value(resource.trimFragment.toString)
					name("lineNumber").value(lineNumber)
					name("stackTrace").value(exception.wollokStackTraceAsString)
				endObject
			endObject
		]
		testErrors++
	}

	// ************************************************************************
	// ** Util
	// ************************************************************************

	def dispatch String getTheWollokMessage(Exception exception) { exception.message }

	def dispatch String getTheWollokMessage(WollokProgramExceptionWrapper exception) { exception.wollokMessage }

	def dispatch String getWollokStackTraceAsString(Exception exception) { exception.stackTraceAsString }

	def dispatch String getWollokStackTraceAsString(WollokProgramExceptionWrapper exception) {
		exception.wollokStackTrace
	}

	// ************************************************************************
	// ** Accessors
	// ************************************************************************

	def getWriter() {
		if (_writer == null) {
			_writer = (new Gson).newJsonWriter(new PrintWriter(System.out))
		}
		_writer
	}
	
	def setWriter(JsonWriter writer) {
		_writer = writer
	}

}
