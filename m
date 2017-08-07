From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 4/4] ARM: configs: keystone: Enable TIECAP PWM driver
Date: Mon, 7 Aug 2017 17:19:43 +0530
Message-ID: <20170807114943.22612-5-vigneshr@ti.com>
References: <20170807114943.22612-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:63530 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdHGLuS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Aug 2017 07:50:18 -0400
In-Reply-To: <20170807114943.22612-1-vigneshr@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Enable PWM_TIECAP driver to support ECAP IP present in 66AK2G SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index d47ea43d097e..445ad438b451 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -182,6 +182,8 @@ CONFIG_KEYSTONE_NAVIGATOR_DMA=y
 CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=y
+CONFIG_PWM=y
+CONFIG_PWM_TIECAP=m
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_RESET_TI_SCI=m
 CONFIG_RESET_TI_SYSCON=m
-- 
2.13.3
