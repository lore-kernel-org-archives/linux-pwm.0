From: Denis Carikli <denis@eukrea.com>
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable mc13xxx-pwm support.
Date: Wed, 27 Nov 2013 16:39:31 +0100
Message-ID: <1385566771-366-3-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:58401 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866Ab3K0PkI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 27 Nov 2013 10:40:08 -0500
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Denis Carikli <denis@eukrea.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

The eukrea mbimx53sd has its display backlighgt
  connected to the pwm of its mc13xxx, so we turn
  it on.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index d479049..4bd1b13 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -241,6 +241,7 @@ CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
 CONFIG_PWM_IMX=y
+CONFIG_PWM_MC13XXX=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.7.9.5

