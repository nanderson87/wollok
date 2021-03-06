package org.uqbar.project.wollok.ui.wizard.tests;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

import org.eclipse.ui.INewWizard;
import org.uqbar.project.wollok.ui.wizard.abstractWizards.AbstractNewWollokFileWizard;

/**
 * New Wollok Objects and Classes Wizard
 * 
 * @author tesonep
 */
public class NewWollokTestWizard extends AbstractNewWollokFileWizard implements INewWizard {
	public static final String ID = "org.uqbar.project.wollok.ui.wizard.tests.NewWollokTestWizard";
	
	public void addPages() {
		page = new NewWollokTestWizardPage(selection);
		addPage(page);
	}
	
	@Override
	protected InputStream openContentStream() {
		String contents =
			System.lineSeparator() + 
			"test \"testX\" {" +
				System.lineSeparator() +
				System.lineSeparator() +
				"\tassert.that(true)" +
				System.lineSeparator() +
				System.lineSeparator() +
			"}";
		return new ByteArrayInputStream(contents.getBytes());
	}
}