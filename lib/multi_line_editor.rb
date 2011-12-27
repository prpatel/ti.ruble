class MultiInputDialog < org.eclipse.jface.dialogs.InputDialog
  def getInputTextStyle
    org.eclipse.swt.SWT::MULTI | org.eclipse.swt.SWT::BORDER | org.eclipse.swt.SWT::V_SCROLL
  end
  def createDialogArea(parent)
    control = super(parent)
    getText.getLayoutData.heightHint = 100;
    control
  end
end