From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v4 4/4] ARM: prima2_defconfig: enable PWM and sirf PWM driver
Date: Wed,  5 Mar 2014 18:01:17 +0800
Message-ID: <1394013677-6423-2-git-send-email-21cnbao@gmail.com>
References: <1394013677-6423-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:42373 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaCEKBu (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Mar 2014 05:01:50 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so849246pdi.19
        for <linux-pwm@vger.kernel.org>; Wed, 05 Mar 2014 02:01:50 -0800 (PST)
In-Reply-To: <1394013677-6423-1-git-send-email-21cnbao@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index 23591db..303204a 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -50,6 +50,8 @@ CONFIG_DMADEVICES_DEBUG=y
 CONFIG_DMADEVICES_VDEBUG=y
 CONFIG_SIRF_DMA=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_SIRF=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
-- 
1.7.5.4

