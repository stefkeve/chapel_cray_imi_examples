<table border="0" cellpadding="0" cellspacing="0" width="1083" style="border-collapse:
 collapse;table-layout:fixed;width:812pt">
 <colgroup><col width="236" style="mso-width-source:userset;mso-width-alt:8630;width:177pt">
 <col width="71" style="mso-width-source:userset;mso-width-alt:2596;width:53pt">
 <col width="72" style="mso-width-source:userset;mso-width-alt:2633;width:54pt">
 <col width="64" span="11" style="width:48pt">
 </colgroup><tbody>
 <tr height="25" style="height:18.75pt">
  <td colspan="9" height="25" class="xl99" style="height:18.75pt">Single locale
  (shared memory), 16 cores</td>
  <td rowspan="4" class="xl87" style="border-bottom:.5pt solid black">diff</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td rowspan="3" height="62" class="xl89" style="border-bottom:.5pt solid black;
  height:46.5pt;border-top:none">Example</td>
  <td colspan="4" class="xl95" style="border-right:.5pt solid black;border-left:
  none">Chapel<span style="mso-spacerun:yes">&nbsp; </span>(--fast)</td>
  <td colspan="4" class="xl98" style="border-left:none">OpenMPI (-O3)</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td colspan="4" height="20" class="xl92" style="border-right:.5pt solid black;
  height:15.0pt;border-left:none">Execution time in seconds</td>
  <td colspan="4" class="xl92" style="border-right:.5pt solid black;border-left:
  none">Execution time in seconds</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl73" style="height:15.75pt;border-top:none;border-left:
  none">run #1</td>
  <td class="xl73" style="border-top:none;border-left:none">run #2</td>
  <td class="xl73" style="border-top:none;border-left:none">run #3</td>
  <td class="xl74" style="border-top:none;border-left:none">avg</td>
  <td class="xl73" style="border-top:none;border-left:none">run #1</td>
  <td class="xl73" style="border-top:none;border-left:none">run #2</td>
  <td class="xl73" style="border-top:none;border-left:none">run #3</td>
  <td class="xl74" style="border-top:none;border-left:none">avg</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">01_pi</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.363816</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.362884</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.368599</td>
  <td class="xl69" align="right">0.3651</td>
  <td class="xl68" align="right" style="border-top:none">0.358666</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.357118</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.359353</td>
  <td class="xl69" align="right">0.358379</td>
  <td class="xl68" align="right" style="border-top:none">-0.00672</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl65" style="height:15.75pt;border-top:none">02_integral_simpson</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.682829</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.680332</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.679425</td>
  <td class="xl71" align="right" style="border-top:none">0.680862</td>
  <td class="xl68" align="right" style="border-top:none">0.660813</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.659823</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.66001</td>
  <td class="xl71" align="right" style="border-top:none">0.660215</td>
  <td class="xl68" align="right" style="border-top:none">-0.02065</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl65" style="height:15.75pt;border-top:none">03_montecarlo</td>
  <td colspan="9" class="xl78" style="border-right:.5pt solid black;border-left:
  none">&nbsp;</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" style="height:15.0pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pi_monte_carlo</td>
  <td class="xl66" align="right" style="border-left:none">6.044846</td>
  <td class="xl66" align="right" style="border-left:none">6.040195</td>
  <td class="xl67" align="right" style="border-left:none">6.052904</td>
  <td class="xl69" align="right">6.045982</td>
  <td rowspan="3" class="xl84">7.797814</td>
  <td rowspan="3" class="xl85">7.796834</td>
  <td rowspan="3" class="xl86">7.798696</td>
  <td rowspan="3" class="xl81">7.797781</td>
  <td class="xl68" align="right">1.7518</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" style="height:15.0pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pi_monte_carlo_2</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">6.031173</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">6.043297</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">6.035667</td>
  <td class="xl70" align="right" style="border-top:none">6.036712</td>
  <td class="xl68" align="right" style="border-top:none">1.761069</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" style="height:15.0pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pi_monte_carlo_dp</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">5.930737</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">5.92309</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">5.921104</td>
  <td class="xl70" align="right" style="border-top:none">5.924977</td>
  <td class="xl68" align="right" style="border-top:none">1.872804</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl65" style="height:15.75pt;border-top:none">04_circuit</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.019073</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.020017</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.026251</td>
  <td class="xl71" align="right" style="border-top:none">0.02178</td>
  <td class="xl68" align="right" style="border-top:none">0.000569</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.000639</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.000568</td>
  <td class="xl71" align="right" style="border-top:none">0.000592</td>
  <td class="xl68" align="right" style="border-top:none">-0.02119</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl65" style="height:15.75pt;border-top:none">05_consecutive_prime</td>
  <td colspan="9" class="xl78" style="border-right:.5pt solid black;border-left:
  none">&nbsp;</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" style="height:15.0pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>cons_prime</td>
  <td class="xl66" align="right" style="border-left:none">24.890891</td>
  <td class="xl66" align="right" style="border-left:none">24.425745</td>
  <td class="xl67" align="right" style="border-left:none">25.0941</td>
  <td class="xl69" align="right">24.80358</td>
  <td rowspan="2" class="xl84">19.15851</td>
  <td rowspan="2" class="xl85">19.15581</td>
  <td rowspan="2" class="xl86">19.15451</td>
  <td rowspan="2" class="xl81" style="border-bottom:1.0pt solid black">19.15628</td>
  <td class="xl68" align="right">-5.6473</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl72" style="height:15.75pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>cons_prime_dp</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">19.197037</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">19.218065</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">19.19641</td>
  <td class="xl71" align="right" style="border-top:none">19.20384</td>
  <td class="xl68" align="right" style="border-top:none">-0.04756</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl65" style="height:15.75pt;border-top:none">06_goldbach</td>
  <td colspan="9" class="xl78" style="border-right:.5pt solid black;border-left:
  none">&nbsp;</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" style="height:15.0pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>goldbach_dp</td>
  <td class="xl66" align="right" style="border-left:none">17.470954</td>
  <td class="xl66" align="right" style="border-left:none">17.483137</td>
  <td class="xl67" align="right" style="border-left:none">17.49012</td>
  <td class="xl69" align="right">17.4814</td>
  <td rowspan="2" class="xl84">17.38964</td>
  <td rowspan="2" class="xl85">17.43905</td>
  <td rowspan="2" class="xl86">17.74317</td>
  <td rowspan="2" class="xl81">17.52395</td>
  <td class="xl68" align="right">0.042551</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" style="height:15.0pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>goldbach_tp</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">17.480897</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">17.468393</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">17.47284</td>
  <td class="xl70" align="right" style="border-top:none">17.47404</td>
  <td class="xl68" align="right" style="border-top:none">0.049909</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">07_gap_prime</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">5.957679</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">5.997284</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">5.950351</td>
  <td class="xl70" align="right" style="border-top:none">5.968438</td>
  <td class="xl68" align="right" style="border-top:none">23.38532</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">23.38731</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">23.42428</td>
  <td class="xl70" align="right" style="border-top:none">23.39897</td>
  <td class="xl68" align="right" style="border-top:none">17.43053</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">08_green_numbers</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">17.465387</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">17.457493</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">17.46092</td>
  <td class="xl70" align="right" style="border-top:none">17.46127</td>
  <td class="xl68" align="right" style="border-top:none">18.25143</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">18.245</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">18.2549</td>
  <td class="xl70" align="right" style="border-top:none">18.25044</td>
  <td class="xl68" align="right" style="border-top:none">0.789178</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">09_array_sum</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.29751</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.286846</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.301624</td>
  <td class="xl70" align="right" style="border-top:none">0.295327</td>
  <td class="xl68" align="right" style="border-top:none">0.273029</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.273281</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.27337</td>
  <td class="xl70" align="right" style="border-top:none">0.273227</td>
  <td class="xl68" align="right" style="border-top:none">-0.0221</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">10_eratosthenes_sieve</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.753122</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.712944</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.684095</td>
  <td class="xl70" align="right" style="border-top:none">0.71672</td>
  <td class="xl68" align="right" style="border-top:none">0.387776</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.387565</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.406318</td>
  <td class="xl70" align="right" style="border-top:none">0.393886</td>
  <td class="xl68" align="right" style="border-top:none">-0.32283</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">11_sroot</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.022692</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.029635</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.020758</td>
  <td class="xl70" align="right" style="border-top:none">0.024362</td>
  <td class="xl68" align="right" style="border-top:none">0.001546</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.00165</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.001942</td>
  <td class="xl70" align="right" style="border-top:none">0.001713</td>
  <td class="xl68" align="right" style="border-top:none">-0.02265</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">12_gol</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">4.331413</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">4.339374</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">4.355066</td>
  <td class="xl70" align="right" style="border-top:none">4.341951</td>
  <td class="xl68" align="right" style="border-top:none">8.016186</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">8.015406</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">8.016186</td>
  <td class="xl70" align="right" style="border-top:none">8.015926</td>
  <td class="xl68" align="right" style="border-top:none">3.673975</td>
 </tr>
 <tr height="20" style="height:15.0pt">
  <td height="20" class="xl65" style="height:15.0pt;border-top:none">14_heat_conduction</td>
  <td colspan="9" class="xl75" style="border-right:.5pt solid black;border-left:
  none">&nbsp;</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl66" style="height:15.75pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>1d_heat_ftcs</td>
  <td class="xl66" align="right" style="border-left:none">0.01598</td>
  <td class="xl66" align="right" style="border-left:none">0.029692</td>
  <td class="xl67" align="right" style="border-left:none">0.025135</td>
  <td class="xl71" align="right">0.023602</td>
  <td class="xl68" align="right">0.23722</td>
  <td class="xl66" align="right" style="border-left:none">0.279924</td>
  <td class="xl67" align="right" style="border-left:none">0.264842</td>
  <td class="xl71" align="right">0.260662</td>
  <td class="xl68" align="right">0.23706</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl66" style="height:15.75pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>1d_heat_ftcs_wsr</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.021171</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.020964</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.024534</td>
  <td class="xl71" align="right">0.022223</td>
  <td class="xl68" align="right" style="border-top:none">0.221294</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.22295</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.304139</td>
  <td class="xl71" align="right">0.249461</td>
  <td class="xl68" align="right" style="border-top:none">0.227238</td>
 </tr>
 <tr height="21" style="height:15.75pt">
  <td height="21" class="xl66" style="height:15.75pt;border-top:none"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>2d_heat</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.020515</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.028735</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.019744</td>
  <td class="xl71" align="right">0.022998</td>
  <td class="xl68" align="right" style="border-top:none">0.039181</td>
  <td class="xl66" align="right" style="border-top:none;border-left:none">0.079912</td>
  <td class="xl67" align="right" style="border-top:none;border-left:none">0.04824</td>
  <td class="xl71" align="right">0.055778</td>
  <td class="xl68" align="right" style="border-top:none">0.03278</td>
 </tr>
 <!--[endif]-->
</tbody></table>
