# Code written by PV Divakar Raju and Neeraj mishra, IIT Tirupati May 2022
# This is an Abaqus script for modeling and simulating the RVE for one set of input properties and fiber coordinates 
# Important: The coordinates of the fibers are genearted using VIPER tool (https://doi.org/10.1016/J.COMPOSITESA.2016.02.026) 
# This script has to run in abaqus to model the RVE geopmetry, assigning the constituent properties, applying the PBC and 
#evaluating composite properties usign EasyPBC abaqus Plug-in (https://doi.org/10.1007/s00366-018-0616-4)



# Do not delete the following import lines
from abaqus import *
from abaqusConstants import *
import __main__
session.journalOptions.setValues(replayGeometry=COORDINATE, recoverGeometry=COORDINATE)
def MODELCTE():
    import section
    import regionToolset
    import displayGroupMdbToolset as dgm
    import part
    import material
    import assembly
    import step
    import interaction
    import load
    import mesh
    import optimization
    import job
    import sketch
    import visualization
    import xyPlot
    import displayGroupOdbToolset as dgo
    import connectorBehavior
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=140.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=(0.0, 0.0), point2=(58.0, 58.0))
    session.viewports['Viewport: 1'].view.fitView()
    p = mdb.models['Model-1'].Part(name='Part-1', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-1']
    p.BaseSolidExtrude(sketch=s, depth=1.0)
    s.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-1']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']
    p = mdb.models['Model-1'].parts['Part-1']
    f1, e1 = p.faces, p.edges
    t = p.MakeSketchTransform(sketchPlane=f1[4], sketchUpEdge=e1[7], 
        sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0, 0, 
        1.0))
    s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=198.0, gridSpacing=5, transform=t)
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
    s1.setPrimaryObject(option=SUPERIMPOSE)
    p = mdb.models['Model-1'].parts['Part-1']
    p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
    
        ##################Paste your fiber coordinates here ##################################
        
    s1.CircleByCenterPerimeter(center=(	0	    ,	0	    ), point1=(	2.5 	,	0	    ))
    s1.CircleByCenterPerimeter(center=(	0	    ,	58	    ), point1=(	2.5 	,	58	    ))
    s1.CircleByCenterPerimeter(center=(	58	    ,	58	    ), point1=(	60.5	,	58	    ))
    s1.CircleByCenterPerimeter(center=(	58	    ,	0	    ), point1=(	60.5	,	0	    ))
    s1.CircleByCenterPerimeter(center=(	15.4	,	56.325	), point1=(	17.9	,	56.325	))
    s1.CircleByCenterPerimeter(center=(	47.8	,	6.49	), point1=(	50.3	,	6.49	))
    s1.CircleByCenterPerimeter(center=(	46.946	,	53.829	), point1=(	49.446	,	53.829	))
    s1.CircleByCenterPerimeter(center=(	41.699	,	0.291	), point1=(	44.199	,	0.291	))
    s1.CircleByCenterPerimeter(center=(	41.699	,	58.291	), point1=(	44.199	,	58.291	))
    s1.CircleByCenterPerimeter(center=(	14.047	,	33.525	), point1=(	16.547	,	33.525	))
    s1.CircleByCenterPerimeter(center=(	9.53	,	27.245	), point1=(	12.03	,	27.245	))
    s1.CircleByCenterPerimeter(center=(	27.281	,	34.717	), point1=(	29.781	,	34.717	))
    s1.CircleByCenterPerimeter(center=(	38.017	,	34.011	), point1=(	40.517	,	34.011	))
    s1.CircleByCenterPerimeter(center=(	30.952	,	56.445	), point1=(	33.452	,	56.445	))
    s1.CircleByCenterPerimeter(center=(	30.952	,	-1.555	), point1=(	33.452	,	-1.555	))
    s1.CircleByCenterPerimeter(center=(	20.249	,	21.81	), point1=(	22.749	,	21.81	))
    s1.CircleByCenterPerimeter(center=(	53.424	,	33.041	), point1=(	55.924	,	33.041	))
    s1.CircleByCenterPerimeter(center=(	5.328	,	0.367	), point1=(	7.828	,	0.367	))
    s1.CircleByCenterPerimeter(center=(	5.328	,	58.367	), point1=(	7.828	,	58.367	))
    s1.CircleByCenterPerimeter(center=(	6.181	,	20.748	), point1=(	8.68100	,	20.748	))
    s1.CircleByCenterPerimeter(center=(	15.4	,	-1.675	), point1=(	17.9	,	-1.675	))
    s1.CircleByCenterPerimeter(center=(	46.406	,	19.911	), point1=(	48.906	,	19.911	))
    s1.CircleByCenterPerimeter(center=(	53.47	,	38.385	), point1=(	55.97	,	38.385	))
    s1.CircleByCenterPerimeter(center=(	53.405	,	4.817	), point1=(	55.905	,	4.817	))
    s1.CircleByCenterPerimeter(center=(	2.194	,	43.085	), point1=(	4.694	,	43.085	))
    s1.CircleByCenterPerimeter(center=(	60.194	,	43.085	), point1=(	62.694	,	43.085	))
    s1.CircleByCenterPerimeter(center=(	24.817	,	54.971	), point1=(	27.317	,	54.971	))
    s1.CircleByCenterPerimeter(center=(	43.643	,	11.502	), point1=(	46.143	,	11.502	))
    s1.CircleByCenterPerimeter(center=(	3.587	,	13.463	), point1=(	6.087	,	13.463	))
    s1.CircleByCenterPerimeter(center=(	54.97	,	9.923	), point1=(	57.47	,	9.923	))
    s1.CircleByCenterPerimeter(center=(	0.989	,	19.481	), point1=(	3.489	,	19.481	))
    s1.CircleByCenterPerimeter(center=(	58.989	,	19.481	), point1=(	61.489	,	19.481	))
    s1.CircleByCenterPerimeter(center=(	49.842	,	11.429	), point1=(	52.342	,	11.429	))
    s1.CircleByCenterPerimeter(center=(	44.252	,	40.564	), point1=(	46.752	,	40.564	))
    s1.CircleByCenterPerimeter(center=(	44.317	,	45.904	), point1=(	46.817	,	45.904	))
    s1.CircleByCenterPerimeter(center=(	19.627	,	33.491	), point1=(	22.127	,	33.491	))
    s1.CircleByCenterPerimeter(center=(	27.711	,	11.806	), point1=(	30.211	,	11.806	))
    s1.CircleByCenterPerimeter(center=(	9.692	,	39.795	), point1=(	12.192	,	39.795	))
    s1.CircleByCenterPerimeter(center=(	33.257	,	17.531	), point1=(	35.757	,	17.531	))
    s1.CircleByCenterPerimeter(center=(	55.802	,	15.193	), point1=(	58.302	,	15.193	))
    s1.CircleByCenterPerimeter(center=(	-2.198	,	15.193	), point1=(	0.3020	,	15.193	))
    s1.CircleByCenterPerimeter(center=(	37.149	,	13.872	), point1=(	39.649	,	13.872	))
    s1.CircleByCenterPerimeter(center=(	37.56	,	3.662	), point1=(	40.06	,	3.662	))
    s1.CircleByCenterPerimeter(center=(	48.084	,	33.193	), point1=(	50.584	,	33.193	))
    s1.CircleByCenterPerimeter(center=(	43.192	,	35.333	), point1=(	45.692	,	35.333	))
    s1.CircleByCenterPerimeter(center=(	8.915	,	4.328	), point1=(	11.415	,	4.328	))
    s1.CircleByCenterPerimeter(center=(	54.97	,	27.927	), point1=(	57.47	,	27.927	))
    s1.CircleByCenterPerimeter(center=(	29.03	,	51.465	), point1=(	31.53	,	51.465	))
    s1.CircleByCenterPerimeter(center=(	7.606	,	44.711	), point1=(	10.106	,	44.711	))
    s1.CircleByCenterPerimeter(center=(	38.798	,	40.632	), point1=(	41.298	,	40.632	))
    s1.CircleByCenterPerimeter(center=(	42.927	,	30	    ), point1=(	45.427	,	30	    ))
    s1.CircleByCenterPerimeter(center=(	3.439	,	28.335	), point1=(	5.939	,	28.335	))
    s1.CircleByCenterPerimeter(center=(	3.03	,	53.54	), point1=(	5.52999	,	53.54	))
    s1.CircleByCenterPerimeter(center=(	22.622	,	10.189	), point1=(	25.122	,	10.189	))
    s1.CircleByCenterPerimeter(center=(	33.853	,	29.63	), point1=(	36.353	,	29.63	))
    s1.CircleByCenterPerimeter(center=(	25.407	,	29.717	), point1=(	27.907	,	29.717	))
    s1.CircleByCenterPerimeter(center=(	12.093	,	13.246	), point1=(	14.593	,	13.246	))
    s1.CircleByCenterPerimeter(center=(	18.077	,	12.987	), point1=(	20.577	,	12.987	))
    s1.CircleByCenterPerimeter(center=(	50.68	,	16.706	), point1=(	53.18	,	16.706	))
    s1.CircleByCenterPerimeter(center=(	40.35	,	25.321	), point1=(	42.85	,	25.321	))
    s1.CircleByCenterPerimeter(center=(	19.242	,	51.746	), point1=(	21.742	,	51.746	))
        ################################## coordinates end here ##########################

    p = mdb.models['Model-1'].parts['Part-1']
    f, e = p.faces, p.edges
    p.SolidExtrude(sketchPlane=f[4], sketchUpEdge=e[7], sketchPlaneSide=SIDE1, 
        sketchOrientation=RIGHT, sketch=s1, depth=1.0, flipExtrudeDirection=ON, 
        keepInternalBoundaries=ON)
    s1.unsetPrimaryObject()
    del mdb.models['Model-1'].sketches['__profile__']

        ################### CUTTING THE OUTER FIBERS (exist on RVE edges)#################
    p = mdb.models['Model-1'].parts['Part-1']
    p.DatumAxisByPrincipalAxis(principalAxis=YAXIS)
    p.DatumPlaneByPrincipalPlane(offset=1.0, 
    principalPlane=XYPLANE)

    p = mdb.models['Model-1'].parts['Part-1']
    f, e, d2 = p.faces, p.edges, p.datums
    t = p.MakeSketchTransform(sketchPlane=d2[4], sketchUpEdge=d2[3], 
        sketchPlaneSide=SIDE1, sketchOrientation=LEFT, origin=(29, 
        29, 1.0))
    s2 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=197.98, gridSpacing=4.94, transform=t)
    g, v, d, c = s2.geometry, s2.vertices, s2.dimensions, s2.constraints
    s2.setPrimaryObject(option=SUPERIMPOSE)
    p = mdb.models['Model-1'].parts['Part-1']
    p.projectReferencesOntoSketch(sketch=s2, filter=COPLANAR_EDGES)
    s2.rectangle(point1=(-29.0, -29.0), point2=(29.0, 29.0))
    session.viewports['Viewport: 1'].view.setValues(nearPlane=164.925, 
        farPlane=232.055, width=237.383, height=113.342, cameraPosition=(
        22.7923, -13.4448, 198.99), cameraTarget=(22.7923, -13.4448, 1))
    s2.rectangle(point1=(-50.0, -50.0), point2=(50.0, 50.0))
    p = mdb.models['Model-1'].parts['Part-1']
    f1, e1 = p.faces, p.edges
    p.CutExtrude(sketchPlane=d2[4], sketchUpEdge=d2[3], sketchPlaneSide=SIDE1, 
        sketchOrientation=LEFT, sketch=s2, flipExtrudeDirection=OFF)
    s2.unsetPrimaryObject()
    del mdb.models['Model-1'].sketches['__profile__']

        ################### MATERIAL ASSIGNMENT#####################
    session.viewports['Viewport: 1'].partDisplay.setValues(sectionAssignments=ON, 
        engineeringFeatures=ON)
    session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
        referenceRepresentation=OFF)
    mdb.models['Model-1'].Material(name='CF')

    mdb.models['Model-1'].materials['CF'].Elastic(type=ENGINEERING_CONSTANTS, table=((43.8, 43.8, 700, 0.4, 0.025, 0.0125, 16.2, 20.6, 20.6), ))
    mdb.models['Model-1'].materials['CF'].Expansion(type=ORTHOTROPIC, table=((7.2e-06, 7.2e-06, -9e-07), ))
    mdb.models['Model-1'].Material(name='EPOXY')
    mdb.models['Model-1'].materials['EPOXY'].Elastic(table=((3, 0.3), ))
    mdb.models['Model-1'].materials['EPOXY'].Expansion(table=((5.2e-05, ), ))
    
    mdb.models['Model-1'].HomogeneousSolidSection(name='CF', material='CF', 
        thickness=None)
    mdb.models['Model-1'].HomogeneousSolidSection(name='EPOXY', material='EPOXY', 
        thickness=None)
    
        ##################SECTION ASSIGNMENT AND ASSEMBLY#####################

    mdb.models['Model-1'].parts['Part-1'].Set(cells=mdb.models['Model-1'].parts['Part-1'].cells.findAt(((0, 0, 0.0), ), ((0, 58, 0.0), ), ((58, 58, 0.0), ), ((58, 0, 0.0), ), ((15.4, 56.325, 0.0), ), ((47.8, 6.49, 0.0), ), ((46.946, 53.829, 0.0), ), ((41.699, 0.291, 0.0), ), ((41.699, 58, 0.0), ), ((14.047, 33.525, 0.0), ), ((9.53, 27.245, 0.0), ), ((27.281, 34.717, 0.0), ), ((38.017, 34.011, 0.0), ), ((30.952, 56.445, 0.0), ), ((30.952, 0, 0.0), ), ((20.249, 21.81, 0.0), ), ((53.424, 33.041, 0.0), ), ((5.328, 0.367, 0.0), ), ((5.328, 58, 0.0), ), ((6.181, 20.748, 0.0), ), ((15.4, 0, 0.0), ), ((46.406, 19.911, 0.0), ), ((53.47, 38.385, 0.0), ), ((53.405, 4.817, 0.0), ), ((2.194, 43.085, 0.0), ), ((58, 43.085, 0.0), ), ((24.817, 54.971, 0.0), ), ((43.643, 11.502, 0.0), ), ((3.587, 13.463, 0.0), ), ((54.97, 9.923, 0.0), ), ((0.989, 19.481, 0.0), ), ((58, 19.481, 0.0), ), ((49.842, 11.429, 0.0), ), ((44.252, 40.564, 0.0), ), ((44.317, 45.904, 0.0), ), ((19.627, 33.491, 0.0), ), ((27.711, 11.806, 0.0), ), ((9.692, 39.795, 0.0), ), ((33.257, 17.531, 0.0), ), ((55.802, 15.193, 0.0), ), ((0, 15.193, 0.0), ), ((37.149, 13.872, 0.0), ), ((37.56, 3.662, 0.0), ), ((48.084, 33.193, 0.0), ), ((43.192, 35.333, 0.0), ), ((8.915, 4.328, 0.0), ), ((54.97, 27.927, 0.0), ), ((29.03, 51.465, 0.0), ), ((7.606, 44.711, 0.0), ), ((38.798, 40.632, 0.0), ), ((42.927, 30, 0.0), ), ((3.439, 28.335, 0.0), ), ((3.03, 53.54, 0.0), ), ((22.622, 10.189, 0.0), ), ((33.853, 29.63, 0.0), ), ((25.407, 29.717, 0.0), ), ((12.093, 13.246, 0.0), ), ((18.077, 12.987, 0.0), ), ((50.68, 16.706, 0.0), ), ((40.35, 25.321, 0.0), ), ((19.242, 51.746, 0.0), ), ), name='Set-1')
    mdb.models['Model-1'].parts['Part-1'].SectionAssignment(offset=0.0, offsetField='', offsetType=MIDDLE_SURFACE, region=mdb.models['Model-1'].parts['Part-1'].sets['Set-1'], sectionName='CF', thicknessAssignment=FROM_SECTION)     
    mdb.models['Model-1'].parts['Part-1'].Set(cells=
        mdb.models['Model-1'].parts['Part-1'].cells.findAt(((0.0, 55.4, 0.0), )), name='Set-2')
    mdb.models['Model-1'].parts['Part-1'].SectionAssignment(offset=0.0, 
        offsetField='', offsetType=MIDDLE_SURFACE, region=
        mdb.models['Model-1'].parts['Part-1'].sets['Set-2'], sectionName='EPOXY', 
        thicknessAssignment=FROM_SECTION)
    
        ###################MATERIAL ORIENTATION######################
    mdb.models['Model-1'].parts['Part-1'].DatumCsysByThreePoints(coordSysType=
        CARTESIAN, name='Datum csys-1', origin=
        mdb.models['Model-1'].parts['Part-1'].vertices.findAt((0.0, 0.0, 0.0), ), 
        point1=mdb.models['Model-1'].parts['Part-1'].vertices.findAt((0.0, 0.0, 
        1.0), ), point2=mdb.models['Model-1'].parts['Part-1'].InterestingPoint(
        mdb.models['Model-1'].parts['Part-1'].edges.findAt((0.0, 0.625, 1.0), ), 
        MIDDLE))
    mdb.models['Model-1'].parts['Part-1'].MaterialOrientation(
        additionalRotationField='', additionalRotationType=ROTATION_NONE, angle=0.0
        , axis=AXIS_1, fieldName='', localCsys=None, orientationType=SYSTEM, 
        region=mdb.models['Model-1'].parts['Part-1'].sets['Set-1'], stackDirection=
        STACK_3)
    myAssembly = mdb.models['Model-1'].rootAssembly
    myInstance = myAssembly.Instance(name='Part-1',part=p, dependent=OFF)
    region = (myInstance.cells,)
    myAssembly.setMeshControls(elemShape=WEDGE, regions=myInstance.cells)
    #elemType = mesh.ElemType(elemCode=C3D6, elemLibrary=STANDARD)
    #myAssembly.setElementType(regions=region, elemTypes=(elemType,))
                            # Mesh the part instance #
    myAssembly.seedPartInstance(regions=(myInstance,),deviationFactor=0.1, minSizeFactor=0.1, size=1.2)
    myAssembly.generateMesh(regions=(myInstance,))       
    
    myAssembly.generateMesh(regions=(myInstance,))
        ###################APPLYING PBC AND GETTING RESULT using EasyPBC plug-in#############
    mdb.models['Model-1'].rootAssembly.regenerate()
    import sys
    sys.path.insert(9, 
        r'C:\temp\abaqus_plugins\EasyPBC V.1.4')
    import easypbc
    import easypbc
    easypbc.feasypbc(part='Model-1', inst='Part-1', meshsens=1E-005, CPU=10, 
        E11=True, E22=True, E33=True, G12=True, G13=True, G23=True, 
        onlyPBC=False, CTE=False, intemp=0, fntemp=100)

MODELCTE()

