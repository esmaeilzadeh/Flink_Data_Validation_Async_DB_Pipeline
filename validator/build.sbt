import sbt.Package.ManifestAttributes
version := "0.1"

ThisBuild / organization := "esmaeilzadeh"
ThisBuild / name := "onlineProcessing"
ThisBuild / version := "0.1"
ThisBuild / scalaVersion := Build.v.scala

val flinkVersion = Build.v.flinkVersion
val scalatestVersion = Build.v.scalaTest
val circeVersion = "0.13.0"
lazy val job = (project in file("."))
  .settings(
    libraryDependencies ++= Seq(
      //testing
      "org.scalatest" %% "scalatest" % scalatestVersion,
      "org.scalatest" %% "scalatest" % scalatestVersion % "test",
      "io.github.embeddedkafka" %% "embedded-kafka" % "3.0.0" % "test",
      "org.apache.flink" %% "flink-clients" % flinkVersion,
      "org.apache.flink" %% "flink-scala" % flinkVersion,
      "org.apache.flink" %% "flink-streaming-scala" % flinkVersion,
      "org.apache.flink" %% "flink-connector-kafka" % flinkVersion,
      "org.apache.flink" % "flink-connector-base" % flinkVersion,
      "org.apache.flink" %% "flink-test-utils" % flinkVersion % Test,
      "org.scalatest" %% "scalatest-funsuite" % "3.2.9" % "test",
      "com.github.pureconfig" %% "pureconfig" % Build.v.pureConfig,
      "org.json4s" %% "json4s-native" % "3.6.10",
      "org.projectlombok" % "lombok" % "1.14.8",
      "com.github.nscala-time" %% "nscala-time" % "2.28.0",
      "com.github.pureconfig" %% "pureconfig" % "0.16.0",
      "com.beachape" %% "enumeratum" % "1.6.1",
      "com.beachape" %% "enumeratum-circe" % "1.6.1",
      "org.json4s" %% "json4s-native" % "3.6.10"
    )
  )
libraryDependencies ++= Seq(
  "io.circe" %% "circe-core",
  "io.circe" %% "circe-generic",
  "io.circe" %% "circe-parser",
  "io.circe" %% "circe-generic-extras",
).map(_ % circeVersion)
//libraryDependencies += "io.tabmo" %% "circe-validation-extra-rules" % "0.0.6"
libraryDependencies += "io.taig" %% "circe-validation" % "0.3.1"

version := "1.0"

val VersionPattern = """ThisBuild / version := "([^"]*)"""".r
libraryDependencies += "com.typesafe.play" %% "play-json" % Build.v.playVersion

resolvers += Resolver.sonatypeRepo("releases")

val validationVersion = "2.1.0"

libraryDependencies ++= Seq(
  "io.github.jto" %% "validation-core"      % validationVersion,
  "io.github.jto" %% "validation-playjson"  % validationVersion,
  "io.github.jto" %% "validation-jsonast"   % validationVersion,
  "io.github.jto" %% "validation-form"      % validationVersion,
  "io.github.jto" %% "validation-delimited" % validationVersion,
  "io.github.jto" %% "validation-xml"       % validationVersion
  // "io.github.jto" %%% "validation-jsjson"    % validationVersion
)
// https://mvnrepository.com/artifact/org.slf4j/nlog4j
libraryDependencies ++= Seq("org.slf4j" % "slf4j-api" % "1.7.5",
  "org.slf4j" % "slf4j-simple" % "1.7.5")

libraryDependencies ++= Seq(

  // Start with this one
  "org.tpolecat" %% "doobie-core"      % "1.0.0-RC1",

  // And add any of these as needed
  "org.tpolecat" %% "doobie-h2"        % "1.0.0-RC1",          // H2 driver 1.4.200 + type mappings.
  "org.tpolecat" %% "doobie-hikari"    % "1.0.0-RC1",          // HikariCP transactor.
  "org.tpolecat" %% "doobie-postgres"  % "1.0.0-RC1",          // Postgres driver 42.3.1 + type mappings.
  "org.tpolecat" %% "doobie-specs2"    % "1.0.0-RC1" % "test", // Specs2 support for typechecking statements.
  "org.tpolecat" %% "doobie-scalatest" % "1.0.0-RC1" % "test"  // ScalaTest support for typechecking statements.

)
// https://mvnrepository.com/artifact/io.estatico/newtype
libraryDependencies += "io.estatico" %% "newtype" % "0.4.4"

Compile / run  := Defaults.runTask(Compile / fullClasspath,
  Compile / run / mainClass,
  Compile / run / runner
).evaluated

//stays inside the sbt console when we press "ctrl-c" while a Flink programme executes with "run" or "runMain"
Compile / run / fork := true
Global / cancelable := true

enablePlugins(JavaAppPackaging)
enablePlugins(DockerPlugin)

//Assembly
// exclude Scala library from assembly
//test in assembly := {}
import sbt.Package.ManifestAttributes
import com.typesafe.sbt.SbtGit.git
packageOptions := Seq(ManifestAttributes(("Repository-Commit", git.gitHeadCommit.value.get)))
//packageOptions := Seq(ManifestAttributes(("Repository-Commit-Message", git.gitHeadMessage.value.get)))
assembly / assemblyOption  := (assembly / assemblyOption).value.copy(includeScala = true)
assemblyMergeStrategy in assembly := {
  case PathList("META-INF", _*) => MergeStrategy.discard
  case _                        => MergeStrategy.first
}