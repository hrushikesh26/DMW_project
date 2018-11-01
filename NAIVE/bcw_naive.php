<?php
if(isset($_POST['submit'])){
$codeno = $_POST["codeno"];
$ClumpThickness = $_POST["ClumpThickness"];
$CellSize = $_POST["CellSize"];
$CellShape = $_POST["CellShape"];
$Adhesion = $_POST["Adhesion"];
$EpiSize = $_POST["EpiSize"];
$BareNuclei = $_POST["BareNuclei"];
$Chromatin = $_POST["Chromatin"];
$Nucleoi = $_POST["Nucleoi"];
$Mitoses = $_POST["Mitoses"];
}
?>

<html>
<head>
<title>Predictor</title>
</head>

<body>
  <p>
  <form method="post">
  <br/>Sample code number: <input type="number" name="codeno">
  <br/>Clump Thickness: <input type="number" name="ClumpThickness">
  <br/>Uniformity of Cell Size: <input type="number" name="CellSize">
  <br/>Uniformity of Cell Shape: <input type="number" name="CellShape">
  <br/>Marginal Adhesion: <input type="number" name="Adhesion">
  <br/>Single Epithelial Cell Size: <input type="number" name="EpiSize">
  <br/>Bare Nuclei: <input type="number" name="BareNuclei">
  <br/>Bland Chromatin : <input type="number" name="Chromatin">
  <br/>Normal Nucleoi: <input type="number" name="Nucleoi">
  <br/>Mitoses : <input type="number" name="Mitoses">
  <br/><input type="submit" value="submit" name="submit">
  </form>
  </p>

<!--
#  Attribute                     Domain
1. Sample code number            id number
2. Clump Thickness               1 - 10
3. Uniformity of Cell Size       1 - 10
4. Uniformity of Cell Shape      1 - 10
5. Marginal Adhesion             1 - 10
6. Single Epithelial Cell Size   1 - 10
7. Bare Nuclei                   1 - 10
8. Bland Chromatin               1 - 10
9. Normal Nucleoli               1 - 10
10. Mitoses                       1 - 10
11. Class:                        (2 for benign, 4 for malignant)
-->

<?php
if (isset($_POST['submit']))
{
  // display the output
  echo "<p>";
  echo "<Values You Provided:>";
  echo "Sample code number: $codeno<br />";
  echo "Clump Thickness: $ClumpThickness<br />";
  echo "Uniformity of Cell Size: $CellSize<br />";
  echo "Uniformity of Cell Shape: $CellShape<br />";
  echo "Marginal Adhesion: $Adhesion<br />";
  echo "Single Epithelial Cell Size: $EpiSize<br />";
  echo "Bare Nuclei: $BareNuclei<br />";
  echo "Bland Chromatin: $Chromatin<br />";
  echo "Normal Nucleoi: $Nucleoi<br />";
  echo "Mitoses: $Mitoses<br />";


  $ans = exec("Rscript BCW_Naive.R $codeno $ClumpThickness $CellSize $CellShape $Adhesion $EpiSize $BareNuclei $Chromatin $Nucleoi $Mitoses");
  echo "<br />Naive Baye's <br />";
  echo "BCW <br /> $ans <br />";
  echo "</p>";
}
?>

</body>
</html>
