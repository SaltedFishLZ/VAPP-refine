function computeCoreModel(thisModel)
    % COMPUTECOREMODEL
    thisModel.network.resetToSavedState();
    thisModel.resetTwigChord();
    thisModel.generatePotentialFlowDependencies();
    thisModel.determineExpOutIntUnk();
    thisModel.assignInOutIdx();
end