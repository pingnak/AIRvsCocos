<?xml version="1.0" encoding="utf-8"?>
<!--
    Install ANT from http://ant.apache.org/bindownload.cgi
    Basically, unzip it somewhere, and add it to the PATH environment variable
-->
<project basedir="." name="Download and Setup" default="setup" >

	<!-- Import settings from environment -->
	<property environment="env" />

	<!-- Impoty settings -->
    <property file="setup.properties"/>
    
    <condition property="is.windows">
        <os family="windows" />
    </condition>
    <target name="download.windows" description="Download Windows dependencies" if="is.windows" >
        <sequential>
            <echo>Getting Windows Tools...</echo>
            <!-- Download+extract a couple of things at a time -->
        	<parallel threadCount="2">
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${windows.python.url}"/>
					</get>
					<!-- Launch interactive Python installer -->
					<exec executable="msiexec" dir="${depends}" spawn="true" searchpath="true" >
						<arg line="/I ${windows.python.filename}" />
					</exec>
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${windows.AIRSDK.url}"/>
					</get>
					<unzip src="${depends}/${windows.AIRSDK.filename}" dest="${depends}/${windows.AIRSDK.unpacked}" />
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${windows.cocos2d.url}"/>
					</get>
					<unzip src="${depends}/${windows.cocos2d.filename}" dest="${depends}" />
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${windows.androidndk.url}"/>
					</get>
					<!-- Evil, self-extracting executable for ndk -->
					<exec executable="cmd" dir="${depends}" failonerror="true" searchpath="true" >
						<arg line="/c ${windows.androidndk.filename} -y" />
					</exec>
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${windows.androidsdk.url}"/>
					</get>
					<unzip src="${depends}/${windows.androidsdk.filename}" dest="${depends}" />
					<!-- Launch android manager, to download more -->
					<exec executable="${basedir}/${depends}/${windows.androidsdk.unpacked}/SDK Manager.exe" dir="${depends}" failonerror="true" searchpath="true" />
				</sequential>
        	</parallel>
			
			<!-- 
				Export configurator.  Note ANT was already installed and in the
				path, or we wouldn't have got here.
			-->
			<echo file="${configure.bat}" append="false">@echo off
REM Set up build environment.
set ANT_ROOT=${env.ANT_HOME}
REM set Path=%ANT_ROOT%\bin;%Path%
set AIR_ROOT=${basedir}\${depends}\${cwindows.AIRSDK.unpacked}
set Path=%AIR_ROOT%\bin;%Path%
set COCOS_CONSOLE_ROOT=${basedir}\${depends}\${windows.cocos2d.unpacked}\tools\cocos2d-console\bin
set Path=%COCOS_CONSOLE_ROOT%;%Path%
set COCOS_FRAMEWORKS=${basedir}\${depends}\${windows.cocos2d.unpacked}\frameworks
set Path=%COCOS_FRAMEWORKS%;%Path%
set ANDROID_SDK_ROOT=${basedir}\${depends}\${windows.androidsdk.unpacked}
set NDK_ROOT=${basedir}\${depends}\${windows.androidndk.unpacked}
			</echo>

        </sequential>
    </target>
    
    <condition property="is.osx">
        <and>
            <os family="mac"/>
            <os family="unix"/>
        </and>
    </condition>
    <target name="download.osx" description="Download OS X dependencies" if="is.osx" >
        <sequential>
            <echo>Getting OS X Tools...</echo>

            <!-- Download+extract a couple of things at a time -->
        	<parallel threadCount="2">
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${osx.AIRSDK.url}"/>
					</get>
					<unzip src="${depends}/${osx.AIRSDK.filename}" dest="${depends}/${osx.AIRSDK.unpacked}" />
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${osx.cocos2d.url}"/>
					</get>
					<unzip src="${depends}/${osx.cocos2d.filename}" dest="${depends}" />
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${osx.androidndk.url}"/>
					</get>
					<!-- Evil, self-extracting executable for ndk -->
					<exec executable="${osx.androidndk.filename}" dir="${depends}" failonerror="true" searchpath="true" >
						<arg line="-y" />
					</exec>
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${osx.androidsdk.url}"/>
					</get>
					<unzip src="${depends}/${osx.androidsdk.filename}" dest="${depends}" />
					<!-- Launch android manager, to download more -->
					<exec executable="${basedir}/${depends}/${osx.androidsdk.unpacked}/tools/android" dir="${depends}" failonerror="true" searchpath="true" />
				</sequential>
        	</parallel>
			<!-- 
				Export configurator.  Note ANT was already installed and in the
				path, or we wouldn't have got here.
			-->
			<echo file="${configure.sh}" append="false">#!/bin/sh
# Set up build environment.
export ANT_ROOT=${env.ANT_HOME}
export Path=%ANT_ROOT%\bin;%Path%
export AIR_ROOT=${basedir}\${depends}\${cosx.AIRSDK.unpacked}
export Path=%AIR_ROOT%\bin;%Path%
export COCOS_CONSOLE_ROOT=${basedir}\${depends}\${osx.cocos2d.unpacked}\tools\cocos2d-console\bin
export Path=%COCOS_CONSOLE_ROOT%;%Path%
export COCOS_FRAMEWORKS=${basedir}\${depends}\${osx.cocos2d.unpacked}\frameworks
export Path=%COCOS_FRAMEWORKS%;%Path%
export ANDROID_SDK_ROOT=${basedir}\${depends}\${osx.androidsdk.unpacked}
export NDK_ROOT=${basedir}\${depends}\${osx.androidndk.unpacked}
			</echo>
            
        </sequential>
    </target>
    
    <condition property="is.linux">
        <and>
            <os family="unix"/>
            <not><os family="mac"/></not>
        </and>
    </condition>
    <target name="download.linux" description="Download Linux dependencies" if="is.linux" >
        <sequential>
            <echo>Getting Linux/Unix Tools...</echo>
            <!-- Download+extract a couple of things at a time -->
        	<parallel threadCount="2">
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${linux.AIRSDK.url}"/>
					</get>
					<unzip src="${depends}/${linux.AIRSDK.filename}" dest="${depends}/${linux.AIRSDK.unpacked}" />
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${linux.cocos2d.url}"/>
					</get>
					<unzip src="${depends}/${linux.cocos2d.filename}" dest="${depends}" />
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${linux.androidndk.url}"/>
					</get>
					<!-- Evil, self-extracting executable for ndk -->
					<exec executable="${linux.androidndk.filename}" dir="${depends}" failonerror="true" searchpath="true" >
						<arg line="-y" />
					</exec>
				</sequential>
				<sequential>
					<get dest="${depends}" skipexisting="true"  >
						<url url="${linux.androidsdk.url}"/>
					</get>
					<unzip src="${depends}/${linux.androidsdk.filename}" dest="${depends}" />
					<!-- Launch android manager, to download more -->
					<exec executable="${basedir}/${depends}/${linux.androidsdk.unpacked}/tools/android" dir="${depends}" failonerror="true" searchpath="true" />
				</sequential>
        	</parallel>
			<!-- 
				Export configurator.  Note ANT was already installed and in the
				path, or we wouldn't have got here.
			-->
			<echo file="${configure.sh}" append="false">#!/bin/sh
# Set up build environment.
export ANT_ROOT=${env.ANT_HOME}
export Path=%ANT_ROOT%\bin;%Path%
export AIR_ROOT=${basedir}\${depends}\${clinux.AIRSDK.unpacked}
export Path=%AIR_ROOT%\bin;%Path%
export COCOS_CONSOLE_ROOT=${basedir}\${depends}\${linux.cocos2d.unpacked}\tools\cocos2d-console\bin
export Path=%COCOS_CONSOLE_ROOT%;%Path%
export COCOS_FRAMEWORKS=${basedir}\${depends}\${linux.cocos2d.unpacked}\frameworks
export Path=%COCOS_FRAMEWORKS%;%Path%
export ANDROID_SDK_ROOT=${basedir}\${depends}\${linux.androidsdk.unpacked}
export NDK_ROOT=${basedir}\${depends}\${linux.androidndk.unpacked}
			</echo>
            
        </sequential>
    </target>

    <!--
        Setup: 
            Depends: Check OS types and invoke the one that matches
    -->
    <target name="setup" description="Download Based On OS" depends="download.windows,download.osx,download.linux" >
    
    </target>    
</project>
