# Script recorded by TexGen v3.12.2
# This code provides voxel meshed RUC to directly simulate in abaqus

weave = CTextileWeave2D(2, 2, 1, 0.2, bool(1), bool(1))
weave.SetGapSize(0)
weave.SetYarnWidths(0.8)
weave.SwapPosition(0, 0)
weave.SwapPosition(1, 1)
weave.SetXYarnWidths(0, 0.8)
weave.SetXYarnHeights(0, 0.1)
weave.SetXYarnSpacings(0, 1)
weave.SetXYarnWidths(1, 0.8)
weave.SetXYarnHeights(1, 0.1)
weave.SetXYarnSpacings(1, 1)
weave.SetYYarnWidths(0, 0.8)
weave.SetYYarnHeights(0, 0.1)
weave.SetYYarnSpacings(0, 1)
weave.SetYYarnWidths(1, 0.8)
weave.SetYYarnHeights(1, 0.1)
weave.SetYYarnSpacings(1, 1)
weave.AssignDefaultDomain()
textilename = AddTextile(weave)

textile = GetTextile('2DWeave(W:2,H:2)')
textile.GetYarn(0).SetFibresPerYarn(0)
textile.GetYarn(0).SetYoungsModulusX(189190, 'MPa')
textile.GetYarn(0).SetYoungsModulusY(13400, 'MPa')
textile.GetYarn(0).SetYoungsModulusZ(13400, 'MPa')
textile.GetYarn(0).SetShearModulusXY(8970, 'MPa')
textile.GetYarn(0).SetShearModulusXZ(8970, 'MPa')
textile.GetYarn(0).SetShearModulusYZ(4740, 'MPa')
textile.GetYarn(0).SetPoissonsRatioX(0.24)
textile.GetYarn(0).SetPoissonsRatioY(0.24)
textile.GetYarn(0).SetPoissonsRatioZ(0.41)
textile.GetYarn(0).SetAlphaX(-2e-07, '/K')
textile.GetYarn(0).SetAlphaY(3e-06, '/K')
textile.GetYarn(0).SetAlphaZ(3e-06, '/K')

textile = GetTextile('2DWeave(W:2,H:2)')
textile.GetYarn(1).SetFibresPerYarn(0)
textile.GetYarn(1).SetYoungsModulusX(189190, 'MPa')
textile.GetYarn(1).SetYoungsModulusY(13400, 'MPa')
textile.GetYarn(1).SetYoungsModulusZ(13400, 'MPa')
textile.GetYarn(1).SetShearModulusXY(8970, 'MPa')
textile.GetYarn(1).SetShearModulusXZ(8970, 'MPa')
textile.GetYarn(1).SetShearModulusYZ(4740, 'MPa')
textile.GetYarn(1).SetPoissonsRatioX(0.24)
textile.GetYarn(1).SetPoissonsRatioY(0.24)
textile.GetYarn(1).SetPoissonsRatioZ(0.41)
textile.GetYarn(1).SetAlphaX(-2e-07, '/K')
textile.GetYarn(1).SetAlphaY(3e-06, '/K')
textile.GetYarn(1).SetAlphaZ(3e-06, '/K')

textile = GetTextile('2DWeave(W:2,H:2)')
textile.GetYarn(2).SetFibresPerYarn(0)
textile.GetYarn(2).SetYoungsModulusX(189190, 'MPa')
textile.GetYarn(2).SetYoungsModulusY(13400, 'MPa')
textile.GetYarn(2).SetYoungsModulusZ(13400, 'MPa')
textile.GetYarn(2).SetShearModulusXY(8970, 'MPa')
textile.GetYarn(2).SetShearModulusXZ(8970, 'MPa')
textile.GetYarn(2).SetShearModulusYZ(4740, 'MPa')
textile.GetYarn(2).SetPoissonsRatioX(0.24)
textile.GetYarn(2).SetPoissonsRatioY(0.24)
textile.GetYarn(2).SetPoissonsRatioZ(0.41)
textile.GetYarn(2).SetAlphaX(-2e-07, '/K')
textile.GetYarn(2).SetAlphaY(3e-06, '/K')
textile.GetYarn(2).SetAlphaZ(3e-06, '/K')

textile = GetTextile('2DWeave(W:2,H:2)')
textile.GetYarn(3).SetFibresPerYarn(0)
textile.GetYarn(3).SetYoungsModulusX(189190, 'MPa')
textile.GetYarn(3).SetYoungsModulusY(13400, 'MPa')
textile.GetYarn(3).SetYoungsModulusZ(13400, 'MPa')
textile.GetYarn(3).SetShearModulusXY(8970, 'MPa')
textile.GetYarn(3).SetShearModulusXZ(8970, 'MPa')
textile.GetYarn(3).SetShearModulusYZ(4740, 'MPa')
textile.GetYarn(3).SetPoissonsRatioX(0.24)
textile.GetYarn(3).SetPoissonsRatioY(0.24)
textile.GetYarn(3).SetPoissonsRatioZ(0.41)
textile.GetYarn(3).SetAlphaX(-2e-07, '/K')
textile.GetYarn(3).SetAlphaY(3e-06, '/K')
textile.GetYarn(3).SetAlphaZ(3e-06, '/K')

textile = GetTextile('2DWeave(W:2,H:2)')
textile.SetMatrixYoungsModulus(3700, 'MPa')
textile.SetMatrixPoissonsRatio(0.4)
textile.SetMatrixAlpha(6.5e-06)

Vox = CRectangularVoxelMesh('CPeriodicBoundaries')
Vox.SaveVoxelMesh(GetTextile('2DWeave(W:2,H:2)'), r'C:\Users\admin\Desktop\RUCC-02012023\new script\plain\PLAIN_new.inp', 50,50,50, bool(1), bool(1),0,0)

