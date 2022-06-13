Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D89C433EF
	for <linux-pwm@archiver.kernel.org>; Mon, 13 Jun 2022 13:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358911AbiFMNMI (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 13 Jun 2022 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359325AbiFMNJt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jun 2022 09:09:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F431F2C3;
        Mon, 13 Jun 2022 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655119208; x=1686655208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Py8zRXdzOiFvbMocJpc5Z5DwAynLOWkd9TOuzKCbQu8=;
  b=eBulPHkUg4syZ9EmsaTAT5IRpb/e+7rNus4jc+AQ5VELvxBhUER4tDRs
   vYgit07mGTvAB412VaHowoD5wqjnHk86tq5rxqld0RewRNf8yomC/kPVJ
   NSOluJ++y5GYEAf7SmOZC2ZU9stzFx9JgLfQOxMtRNPy7zgKQqA7u/o5K
   lVATRxRoYBCmWhuxSHN8CR12vk6HXOF7KigfM3hgAA0fMIlr5IwQlI8O3
   xs3mIhU3f0WLYT8TUgR49ypHalEqpuoJjzBuY9/N2OtxO0DAioYiassse
   K9etMkTObI2r1qqq3V0JgLAmDQnHWNTuzl2OKybh7RIY5o78cku+A/Tur
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="163066307"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2022 04:20:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Jun 2022 04:20:06 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Jun 2022 04:20:04 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Mon, 13 Jun 2022 12:18:00 +0100
Message-ID: <20220613111759.1550578-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613111759.1550578-1-conor.dooley@microchip.com>
References: <20220613111759.1550578-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the newly introduced pwm driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1b4b77daa5f..d0b39fa4f309 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17091,6 +17091,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
 
-- 
2.36.1

