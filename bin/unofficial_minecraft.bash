#!/bin/bash

set -x

# Use dedicated GPU
export DRI_PRIME=1

LIBS=(
    libraries/org/tlauncher/tl_skin_cape_1.15.2/1.9/tl_skin_cape_1.15.2-1.9.jar
    libraries/org/ow2/asm/asm-tree/6.2/asm-tree-6.2.jar
    libraries/org/ow2/asm/asm/6.2/asm-6.2.jar
    libraries/org/ow2/asm/asm-commons/6.2/asm-commons-6.2.jar
    libraries/net/minecraft/launchwrapper/1.12/launchwrapper-1.12.jar
    libraries/org/tlauncher/patchy/1.1/patchy-1.1.jar
    libraries/oshi-project/oshi-core/1.1/oshi-core-1.1.jar
    libraries/net/java/dev/jna/jna/4.4.0/jna-4.4.0.jar
    libraries/net/java/dev/jna/platform/3.4.0/platform-3.4.0.jar
    libraries/com/ibm/icu/icu4j-core-mojang/51.2/icu4j-core-mojang-51.2.jar
    libraries/com/mojang/javabridge/1.0.22/javabridge-1.0.22.jar
    libraries/net/sf/jopt-simple/jopt-simple/5.0.3/jopt-simple-5.0.3.jar
    libraries/io/netty/netty-all/4.1.25.Final/netty-all-4.1.25.Final.jar
    libraries/com/google/guava/guava/21.0/guava-21.0.jar
    libraries/org/apache/commons/commons-lang3/3.5/commons-lang3-3.5.jar
    libraries/commons-io/commons-io/2.5/commons-io-2.5.jar
    libraries/commons-codec/commons-codec/1.10/commons-codec-1.10.jar
    libraries/net/java/jinput/jinput/2.0.5/jinput-2.0.5.jar
    libraries/net/java/jutils/jutils/1.0.0/jutils-1.0.0.jar
    libraries/com/mojang/brigadier/1.0.17/brigadier-1.0.17.jar
    libraries/com/mojang/datafixerupper/2.0.24/datafixerupper-2.0.24.jar
    libraries/com/google/code/gson/gson/2.8.0/gson-2.8.0.jar
    libraries/org/tlauncher/authlib/1.6.25/authlib-1.6.25.jar
    libraries/org/apache/commons/commons-compress/1.8.1/commons-compress-1.8.1.jar
    libraries/org/apache/httpcomponents/httpclient/4.3.3/httpclient-4.3.3.jar
    libraries/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar
    libraries/org/apache/httpcomponents/httpcore/4.3.2/httpcore-4.3.2.jar
    libraries/it/unimi/dsi/fastutil/8.2.1/fastutil-8.2.1.jar
    libraries/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.jar
    libraries/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.jar
    libraries/org/lwjgl/lwjgl/3.2.2/lwjgl-3.2.2.jar
    libraries/org/lwjgl/lwjgl-jemalloc/3.2.2/lwjgl-jemalloc-3.2.2.jar
    libraries/org/lwjgl/lwjgl-openal/3.2.2/lwjgl-openal-3.2.2.jar
    libraries/org/lwjgl/lwjgl-opengl/3.2.2/lwjgl-opengl-3.2.2.jar
    libraries/org/lwjgl/lwjgl-glfw/3.2.2/lwjgl-glfw-3.2.2.jar
    libraries/org/lwjgl/lwjgl-stb/3.2.2/lwjgl-stb-3.2.2.jar
    libraries/org/lwjgl/lwjgl-tinyfd/3.2.2/lwjgl-tinyfd-3.2.2.jar
    libraries/com/mojang/text2speech/1.11.3/text2speech-1.11.3.jar
    versions/1.15.2/1.15.2.jar
)

IFS=':'

cd /home/diogo/.minecraft || exit

/home/diogo/.tlauncher/jvms/jre1.8.0_51/bin/java \
    -Djava.net.preferIPv4Stack=true \
    -Xmn128M \
    -Xmx6953M \
    -Xss1M \
    -Djava.library.path=/home/diogo/.minecraft/versions/1.15.2/natives \
    -Dminecraft.launcher.brand=minecraft-launcher \
    -Dminecraft.launcher.version=2.0.1003 \
    -cp "${LIBS[*]}" \
    -Dminecraft.applet.TargetDirectory=/home/diogo/.minecraft \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+UseG1GC \
    -XX:G1NewSizePercent=20 \
    -XX:G1ReservePercent=20 \
    -XX:MaxGCPauseMillis=50 \
    -XX:G1HeapRegionSize=32M \
    -Dfml.ignoreInvalidMinecraftCertificates=true \
    -Dfml.ignorePatchDiscrepancies=true \
    org.tlauncher.LaunchNew \
    --username sANIK \
    --version 1.15.2 \
    --gameDir /home/diogo/.minecraft \
    --assetsDir /home/diogo/.minecraft/assets \
    --assetIndex 1.15 \
    --uuid 00000000-0000-0000-0000-000000000000 \
    --accessToken null \
    --userType legacy \
    --versionType release \
    --width 925 \
    --height 530 \
    --tweakClass org.tlauncher.tweaker.Tweaker

