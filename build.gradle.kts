plugins {
    id("java")
    id("org.jetbrains.kotlin.jvm") version "1.9.0" // Ваша версия Kotlin
    id("jacoco")
}

group = "fedorovsa"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

tasks.test {
    useJUnitPlatform()
}