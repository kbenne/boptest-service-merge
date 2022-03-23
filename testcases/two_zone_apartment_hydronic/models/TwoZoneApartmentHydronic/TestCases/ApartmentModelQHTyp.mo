﻿within TwoZoneApartmentHydronic.TestCases;
model ApartmentModelQHTyp "Hydronic Test case"
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Area Afloor = 22;
    parameter Modelica.SIunits.Temperature T_start = 21+273.15;
    parameter Modelica.SIunits.MassFlowRate mflow_n=2480/3600/4
    "nominal flow rate";
    parameter Real qint=1 "Presence or not of Internal gains";
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatNigZ(
    occSta=8*3600,
    occEnd=20*3600,
    TSetHeaUno=294.15,
    TSetHeaOcc=289.15,
    TSetHeaWee=289.15)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  TwoZoneApartmentHydronic.Components.HydronicSystem hydronicSystem(mflow_n=
        2480/3600/2, QhpDes=5000)
    annotation (Placement(transformation(extent={{-20,-14},{14,20}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-80,-10},{-40,30}}),  iconTransformation(extent=
           {{-268,-10},{-248,10}})));
  TwoZoneApartmentHydronic.Components.Rooms.DayZone DayZon(
    Afloor=Afloor,
    mflow_n=mflow_n,
    qint=qint,
    Tstart=T_start,
    zonName="Day")
    annotation (Placement(transformation(extent={{48,28},{72,52}})));
  TwoZoneApartmentHydronic.Components.Rooms.NightZone NigZone(
    Afloor=Afloor,
    mflow_n=mflow_n,
    qint=qint,
    Tstart=T_start,
    zonName="Night")
    annotation (Placement(transformation(extent={{46,-52},{70,-28}})));
  TwoZoneApartmentHydronic.Components.Thermostat_T thermostatDayZ(
    occSta=8*3600,
    occEnd=20*3600,
    TSetHeaUno=294.15,
    TSetHeaOcc=289.15,
    TSetHeaWee=289.15)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  inner IDEAS.BoundaryConditions.SimInfoManager
                       sim(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://TwoZoneApartmentHydronic/Resources/ITA_Milano-Linate.160800_IGDG.mos"))
    annotation (Placement(transformation(extent={{-104,-2},{-82,20}})));
equation
  connect(hydronicSystem.ports_b[1], DayZon.supplyWater) annotation (Line(
        points={{12.8667,16.6},{12,16.6},{12,16},{54,16},{54,22},{53.52,22}},
                                                   color={0,127,255}));
  connect(hydronicSystem.ports_b[2], NigZone.supplyWater) annotation (Line(
        points={{12.8667,9.8},{24,9.8},{24,-64},{52,-64},{52,-58},{51.52,-58}},
                                                                       color={0,
          127,255}));
  connect(weaBus, hydronicSystem.weaBus) annotation (Line(
      points={{-60,10},{-54,10},{-54,10.14},{-17.7333,10.14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, NigZone.weaBus) annotation (Line(
      points={{-60,10},{-60,-40},{35.2,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, DayZon.weaBus) annotation (Line(
      points={{-60,10},{-60,40},{37.2,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(DayZon.returnWater, hydronicSystem.ports_a[1]) annotation (Line(
        points={{66.48,22},{66,22},{66,0},{14,0},{14,-10.6},{12.8667,-10.6}},
                                                               color={0,127,255}));
  connect(NigZone.returnWater, hydronicSystem.ports_a[2]) annotation (Line(
        points={{64.48,-58},{66,-58},{66,-80},{20,-80},{20,-3.8},{12.8667,-3.8}},
        color={0,127,255}));
  connect(DayZon.surf_conBou[2], NigZone.surf_surBou) annotation (Line(points={{61.44,
          37.36},{61.44,0},{67.6,0},{67.6,-42.88}},      color={191,0,0}));
  connect(sim.weaDatBus, weaBus) annotation (Line(
      points={{-82.11,9},{-72,9},{-72,10},{-60,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(NigZone.TRooAir, thermostatNigZ.TZon) annotation (Line(points={{78.4,-35.44},
          {78,-35.44},{78,-100},{-80,-100},{-80,-70},{-62,-70}}, color={0,0,127}));
  connect(DayZon.TRooAir, thermostatDayZ.TZon) annotation (Line(points={{80.4,44.56},
          {80.4,98},{-80,98},{-80,70},{-62,70}}, color={0,0,127}));
  connect(thermostatNigZ.ValCon, hydronicSystem.ValConNigZon) annotation (Line(
        points={{-39,-64},{-32,-64},{-32,-12},{-18.3567,-12},{-18.3567,-11.28}},
        color={0,0,127}));
  connect(thermostatDayZ.ValCon, hydronicSystem.ValConDayZon) annotation (Line(
        points={{-39,76},{-32,76},{-32,-5.84},{-18.3567,-5.84}}, color={0,0,127}));
  connect(thermostatNigZ.Occ, NigZone.occupation) annotation (Line(points={{-39,
          -70},{-10,-70},{-10,-29.92},{41.2,-29.92}}, color={0,0,127}));
  connect(thermostatDayZ.Occ, DayZon.occupation) annotation (Line(points={{-39,70},
          {0,70},{0,50.08},{43.2,50.08}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Radau"),
    Documentation(revisions="<html>
<ul>
<li>
August 6, 2021, by Ettore Zanetti:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<h3>Building Design and use </h3>
<h4>Architecture</h4>
<p>
The building is a two room apartment model representing a real case study  in Milan, which consists of two rooms and one bathroom.  
The bathroom and the nightzone are considered together in a single thermal zone. So in total two thermal zones are considered. The aparment is an newly built
heavy construction.
The height of each room is 2.7 m, while the other dimensions are reported in the plan below. </p>
<p align=\"center\">
<img src=\"../../../doc/images/SmallApartmentPlan.png\"
     alt=\"SmallApartmentPlan.png\" />
</p>
<h4>Constructions</h4>
<p>As can be seen from the plan, there are four different types of walls that, with the floor and the ceiling, constitute the boundaries of the thermal zones.
 All the geometrical and thermal characteristics of the various stratigraphies are highlighted below.
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>External wall</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Exterior plaster</td>
<td>0.005</td>
<td>0.300</td>
<td>840</td>
<td>1300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>EPS 120 thermal insulation panel</td>
<td>0.1</td>
<td>0.034</td>
<td>1250</td>
<td>23</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Masonry brick</td>
<td>0.3</td>
<td>0.207</td>
<td>840</td>
<td>750</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Gypsum plaster</td>
<td>0.02</td>
<td>0.570</td>
<td>1000</td>
<td>1300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Internal partition</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass wool insulation panel (CTGS Par70)</td>
<td>0.07</td>
<td>0.040</td>
<td>840</td>
<td>40</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Elevator separator</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Gypsum plaster</td>
<td>0.02</td>
<td>0.570</td>
<td>1000</td>
<td>1300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Concrete </td>
<td>0.3</td>
<td>2.15</td>
<td>880</td>
<td>2400</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass wool insulation panel (Par45)</td>
<td>0.045</td>
<td>0.038</td>
<td>1030</td>
<td>13</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Apartments separator</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass wool insulation panel (CTGS Par70)</td>
<td>0.07</td>
<td>0.040</td>
<td>840</td>
<td>40</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Glass wool insulation panel (CTGS Par70)</td>
<td>0.07</td>
<td>0.040</td>
<td>840</td>
<td>40</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>6</td>
<td>Plasterboard panel (WALLBOARD 13)</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>710</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>7</td>
<td>Gyproc Duragyp panel</td>
<td>0.0125</td>
<td>0.250</td>
<td>1000</td>
<td>1025</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Ceiling</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Ceramic tiles</td>
<td>0.015</td>
<td>1.000</td>
<td>840</td>
<td>2300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Concrete slab with additive</td>
<td>0.064</td>
<td>1.000</td>
<td>880</td>
<td>1800</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Expanded polystyrene</td>
<td>0.026</td>
<td>0.034</td>
<td>1300</td>
<td>25</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Isover fonasoft</td>
<td>0.006</td>
<td>0.113</td>
<td>2100</td>
<td>450</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Light substrate</td>
<td>0.105</td>
<td>0.100</td>
<td>1200</td>
<td>400</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>6</td>
<td>Reinforced concrete (1% steel) </td>
<td>0.230</td>
<td>2.300</td>
<td>1000</td>
<td>2300</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>7</td>
<td>Gypsum and sand plaster</td>
<td>0.200</td>
<td>0.800</td>
<td>1000</td>
<td>1600</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
<p></p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Radiant floor</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>c <br>[J/(kg K)]</th>
<th>d <br>[kg/m<sup>3</sup>]</th>
<th>absIR <br> [-]</th>
<th>absSol <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Ceramic tiles</td>
<td>0.015</td>
<td>1.000</td>
<td>840</td>
<td>2300</td>
<td>0.9</td>
<td>0.6</td>
</tr>
<tr>
<td>2</td>
<td>Concrete slab with additive</td>
<td>0.064</td>
<td>1.000</td>
<td>880</td>
<td>1800</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Expanded polystyrene</td>
<td>0.026</td>
<td>0.034</td>
<td>1300</td>
<td>25</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>4</td>
<td>Isover fonasoft</td>
<td>0.006</td>
<td>0.113</td>
<td>2100</td>
<td>450</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>5</td>
<td>Light substrate</td>
<td>0.105</td>
<td>0.100</td>
<td>1200</td>
<td>400</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>6</td>
<td>Reinforced concrete (1% steel) </td>
<td>0.230</td>
<td>2.300</td>
<td>1000</td>
<td>2300</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>7</td>
<td>Gypsum and sand plaster</td>
<td>0.200</td>
<td>0.800</td>
<td>1000</td>
<td>1600</td>
<td>0.9</td>
<td>0.6</td>
</tr>
</table>
</p>
<p>These properties are defined in the model of each thermal zone respectively in the component <code>matExtWal</code>, <code>IntWall</code>,
<code>ElevatorSep</code>, <code>AptSep</code>, <code>roof</code> and <code>slaCon</code>. All the stratigraphies are defined starting from  outside to 
room-side except for the radiant floor that requires the opposite order, as reported in Buildings envelope user guide.
<p> Considering the two glazing systems of the small apartment, they have the same stratigrafy and the same shading system 
and differ only for the dimensions. These characteristics are reported in the tables below. 
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"3\"><b>Glazing system dimensions</b></td></tr>
<tr>
<th>Room</th>
<th>height <br>[m]</th>
<th>length <br>[m]</th>
</tr>
<tr>
<td>Day Zone</td>
<td>2.35</td>
<td>2.5</td>
</tr>
<tr>
<td>Night Zone</td>
<td>2.35</td>
<td>1.6</td>
</table>
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"8\"><b>Glazing system physical properties</b></td></tr>
<tr>
<th>N</th>
<th>Description</th>
<th>x <br>[m]</th>
<th>k <br>[W/(mK)]</th>
<th>tauSol <br>[-]</th>
<th>rhoSol <br>[-]</th>
<th>tauIR <br> [-]</th>
<th>absIR <br>[-]</th>
</tr>
<tr>
<td>1</td>
<td>Glass</td>
<td>0.003</td>
<td>1</td>
<td rowspan=\"3\">0.6</td>
<td>0.075</td>
<td>0</td>
<td>0.84</td>
</tr>
<tr>
<td>2</td>
<td>Air</td>
<td>0.013</td>
<td>-</td>
<td>-</td>
<td>-</td>
<td>-</td>
</tr>
<tr>
<td>3</td>
<td>Glass</td>
<td>0.003</td>
<td>1</td>
<td>0.075</td>
<td>0</td>
<td>0.84</td>
</tr>
</p><p>
</table>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"4\"><b>Shading system physical properties</b></td></tr>
<tr>
<th>tauSol <br>[-]</th>
<th>rhoSol <br>[-]</th>
<th>tauIR <br> [-]</th>
<th>absIR <br>[-]</th>
</tr>
<tr>
<td>0.1</td>
<td>0.8</td>
<td>0</td>
<td>0.84</td>
</tr>
</table>
</p>
<p>The dimensions of the glazing system of the two thermal zones that face towards outside are two parameters that have been defined in the zone components, while the glazing system and shading system physical properties
have been defined in the record \"Window24\".

<p>In the thermal zone model it is also included the radiant slab component taken from the Buildings library.The properties are reported in the following table.  
</p>
<p>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"2\"><b>Radiant slab properties</b></td></tr>
<tr>
<td>Pipe distance [m]</th>
<td>0.1</th>
</tr>
<tr>
<td>Interface layer in which pipes are located [-]</td>
<td>2</td>
</tr>
</table>
<table border = \"1\" summary=\"Peak temperature\">
<tr><td colspan=\"2\"><b>Pipe properties</b></td></tr>
<tr>
<td>Outer diameter [m]</th>
<td>0.017</th>
</tr>
<tr>
<td>Inner diameter [m]</th>
<td>0.015</th>
</tr>
<tr>
<td>Roughness [m]</td>
<td>0.000007</td>
</tr>
<tr>
<td>Density [kg/m<sup>3</sup>]</td>
<td>983</td>
</tr>
<tr>
<td>Thermal conductivity [W/(m K)]</td>
<td>0.4</td>
</tr>
</table>
</p>
<p>
<h4>Occupancy schedule</h4>
<p>The maximum occupation is two people, one per thermal zone, from 8 P.M. to 8 A.M. for the weekdays. The thermal zones are considered always occupied 
during the weekend.</p>
<h4>Internal loads and schedules</h4>
<p>The heating setpoint is considered 21 [°C] for occupied periods and 16 [°C] for unoccupied periods. The main heat gains come from people, appliances and lighting. For people it corresponds to 60 (W/person) of sensible gains divided equally between
convective and radiative contributions and 20 (W) of latent gains, with no CO2 generation. For the appliances and lighting 4 (W/m2) of sensible gains were considred divided 
equally between convective and radiative contributions. Lastly, infilatrations was considered a constant value of 0.5 (vol/h) for each thermal zone.</p>
<h4>Climate data</h4>
<p>The climate is assumed to be near Milan, Italy with a latitude and longitude of 45.44,9.27. The climate data comes from the Milano Linate TMY set. </p>
<h3>HVAC System Design</h3>
<h4>Primary and secondary system designs</h4>
<p>Only heating is considered. The HVAC system is made up of two floor heating circuits, one per thermal zone that can be controlled with an on-off valve.
The generation system is an air source 5kW heat pump modelled after a Daikin heat pump. Below is reported a schematic view of the HVAC system.</p>
<p align=\"center\">
<img src=\"../../../doc/images/HVACscheme.png\"
     alt=\"HVACscheme.png\" />
</p>
<h4>Equipment specifications and performance maps</h4>
<p> The flow rate for each thermal zone floor heating circuit is 620 [l/h], while the heat pump perfomance map is the default map present in the IDEAS heat pump
model coming from a Darikin heat pump.
</p>
<h4>Rule-based or local-loop controllers (if included)</h4>
The default controller has two levels of control. The first level is done by the thermostars using an hysteresis controller with 2 [K] bandiwidth. When the room temperature
is lower than setpoint minus half the bandwidth the thermostat will open the floor heating circuit valve. Viceversa, when the room temperature is higher than setpoint plus half
the bandwidth the thermostat will close the valve. The second level controller controls the heat pump supply temperature using a climatic curve based on the external temperature and an hysteresis controller.
The figure below reports a scheme of the controls.
<p align=\"center\">
<img src=\"../../../doc/images/ControlScheme.png\"
     alt=\"ControlScheme.png\" />
</p>

<h3>Model IO's</h3>
<h4>Inputs</h4>
The model inputs are:
<ul>
<li>
<code>hydronicSystem_oveTHea_u</code> [K] [min=274.15, max=318]: Supply water setpoint
</li>
<li>
<code>hydronicSystem_oveMNigZ_u</code> [1] [min=0.0, max=1]: Night zone valve on-off
</li>
<li>
<code>hydronicSystem_oveMDayZ_u</code> [1] [min=0.0, max=1]: Day zone valve on-off
</li>
</ul>
<h4>Outputs</h4>
The model outputs are:
<ul>
<li>
<code>DayZon_reaPowQint_y</code> [W] [min=None, max=None]: Day zone internal heat gains
</li>
<li>
<code>DayZon_MFloHea_y</code> [kg/s] [min=None, max=None]: Mass flow rate floor heating circuit Day zone
</li>
<li>
<code>hydronicSystem_reaCOPhp_y</code> [1] [min=None, max=None]: Heat pump COP
</li>
<li>
<code>NigZone_TsupFloHea_y</code> [K] [min=None, max=None]: Supply temperature to Night zone floor heating circuit
</li>
<li>
<code>hydronicSystem_PeleHeaPum_y</code> [W] [min=None, max=None]: Electical consumption heat pump 
</li>
<li>
<code>NigZone_reaPLig_y</code> [W] [min=None, max=None]: Night zone lighting power consumption
</li>
<li>
<code>NigZone_TretFloHea_y</code> [T] [min=None, max=None]: Return temperature Night zone floor heating circuit
</li>
<li>
<code>DayZon_reaPLig_y</code> [W] [min=None, max=None]: Day zone lighting power consumption
</li>
<li>
<code>NigZone_reaPPlu_y</code> [W] [min=None, max=None]: Night zone plug loads
</li>
<li>
<code>NigZone_reaPowQint_y</code> [W] [min=None, max=None]: Night zone overall heat gains
</li>
<li>
<code>DayZon_TavgFloHea_y</code> [K] [min=None, max=None]: Average floor heating temperature Day zone
</li>
<li>
<code>NigZone_TavgFloHea_y</code> [K] [min=None, max=None]: Average floor heating temperature Night zone
</li>
<li>
<code> DayZon_reaTRooAir_y </code> [K] [min=None, max=None]: Air temperature Day zone
</li>
<li>
<code> DayZon_reaCO2RooAir_y </code> [ppm] [min=None, max=None]: CO2 concentration Day zone
</li>
<li>
<code> NigZone_reaCO2RooAir_y </code> [ppm] [min=None, max=None]: CO2 concentration Night zone
</li>
<li>
<code>  DayZon_TretFloHea_y</code> [K] [min=None, max=None]: Return temperature Day zone floor heating circuit
</li>
<li>
<code> DayZon_reaPPlu_y </code> [W] [min=None, max=None]: Day zone plug loads
</li>

<li>
<code> hydronicSystem_reaMNigZ_y </code> [1] [min=None, max=None]: Night zone valve status
</li>
<li>
<code> NigZone_reaTRooAir_y </code> [K] [min=None, max=None]: Air temperature Night zone
</li>
<li>
<code> hydronicSystem_TretFloHea_y </code> [K] [min=None, max=None]: Return water temperature to heat pump
</li>
<li>
<code> hydronicSystem_reaTHeat_y </code> [K] [min=None, max=None]: Heat pump supply water temperature 
</li>
<li>
<code>DayZon_reaPowFlooHea_y </code> [W] [min=None, max=None]: Thermal power supplied to Day zone floor heating circuit
</li>
<li>
<code> NigZone_MFloHea_y</code> [kg/s] [min=None, max=None]: Mass flow rate floor heating circuit Night zone
</li>
<li>
<code>NigZone_reaPowFlooHea_y </code> [W] [min=None, max=None]: Thermal power supplied to Night zone floor heating circuit
</li>
<li>
<code> hydronicSystem_reaMDayZ_y</code> [1] [min=None, max=None]: Day zone valve status
</li>
<li>
<code> DayZon_TsupFloHea_y </code> [K] [min=None, max=None]: Supply temperature to Day zone floor heating circuit
</li>

</ul>
<h3>Additional System Design</h3>
<h4>Lighting</h4>
<p>
Artificial lighting is provided by LED lights in the thermal zones.
</p>
<h4>Shading</h4>
<p>
There are no shades on the building.
</p>
<h4>Onsite Generation and Storage</h4>
<p>
There is no energy generation or storage on the site.
</p>
<h3>Model Implementation Details</h3>
<h4>Moist vs. dry air</h4>
<p>
A moist air model is used, but condensation is not modeled in the HVAC
and humidity is not monitored.

</p>
<h4>Pressure-flow models</h4>
<p>
The pump is an ideal constant head pump and provided each floor heating circuit with exactly 620 [l/h] if the circuit valve is open.
</p>
<h4>Infiltration models</h4>
<p>
A constant infiltration flowrate is assumed to be 0.5 ACH.
</p>
<h4>Other assumptions</h4>
<p>
The supply air temperature is directly specified.
</p>
<p>
CO2 generation is modelled but no generation is considered. So the CO2 concentration will be in equilibrium with the external environment CO2.
</p>
<h3>Scenario Information</h3>
<h4>Time Periods</h4>
<p>
The <b>Peak Heat Day</b> (specifier for <code>/scenario</code> API is <code>'peak_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with the
maximum 15-minute system heating load in the year.
</ul>
<ul>
Start Time: Day 308.
</ul>
<ul>
End Time: Day 322.
</ul>
</p>
<p>
The <b>Typical Heat Day</b> (specifier for <code>/scenario</code> API is <code>'typical_heat_day'</code>) period is:
<ul>
This testing time period is a two-week test with one-week warmup period utilizing
baseline control.  The two-week period is centered on the day with day with
the maximum 15-minute system heating load that is closest from below to the
median of all 15-minute maximum heating loads of all days in the year.
</ul>
<ul>
Start Time: Day 16.
</ul>
<ul>
End Time: Day 30.
</ul>
</p>
<h4>Energy Pricing</h4>
<p>
The <b>Constant Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'constant'</code>) profile is:
<ul>
Based on the ARERA 2021 (Autorità di Regolazione per Energia Reti e Ambiente ,\"Italian authority for grid and environment regulation\") estimates <a href=\"https://www.arera.it/it/inglese/index.htm\">
https://www.arera.it/it/inglese/index.htm</a>. The price for the whole heating season, 10/15 to 04/15 is considered as 0.2 [€/kWh].
</ul>
<ul>
Specifier for <code>/scenario</code> API is <code>'constant'</code>.
</ul>
</p>
<p>
The <b>Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'dynamic'</code>) profile is:
<ul>
Based on the ARERA 2021 estimates for the bi daily profile, price is 0.22 [€/kWh] for the period between 8:00 A.M. and 7 P.M. and 0.19 [€/kWh] for the period between 8 P.M. and 7 A.M. for the whole heating season. 
</ul>
</p>

<p>
The <b>Highly Dynamic Electricity Price</b> (specifier for <code>/scenario</code> API is <code>'highly_dynamic'</code>) profile is:
<ul>
Based on the the
day-ahead energy prices as determined from the GSE <a href=\"https://www.mercatoelettrico.org/it/mercati/mercatoelettrico/mpe.aspx\">
https://www.mercatoelettrico.org/it/mercati/mercatoelettrico/mpe.aspx</a> with the addition of taxes and distribution costs estimated from ARERA for the year 2019.

</ul>
</p>

<h4>Emission Factors</h4>
<p>
The <b>Electricity Emissions Factor</b> profile is:
<ul>
Based on the average electricity generation mix for Italy for the year of
2017.  It is 0.312 kgCO2/kWh.
For reference,
see <a href=\"https://www.isprambiente.gov.it/en\">
https://www.isprambiente.gov.it/en</a>  
</ul>
</p>


</html>
"));
end ApartmentModelQHTyp;
