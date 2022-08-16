Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C8DC25B0E
	for <linux-pwm@archiver.kernel.org>; Tue, 16 Aug 2022 12:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiHPMOX (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiHPMNq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2022 08:13:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409774E16;
        Tue, 16 Aug 2022 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660651755; x=1692187755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EW5WWQcuhe1n/gF8QxR46HQULYTGKaa7UvnqyPxMU0w=;
  b=KaUQKI41ccBUDFy5Y7n5shcPdLA/POWQXyfvLXvcXQNMxjbcLgGqZU9I
   RBBa/mjDXVlat4cPIMSAy1CQJkN2jqSfcMEpOkkJeIJtqEcDgTjpaz/3T
   6GuBaYtv9KcHR4tSEnCjDMQiZcdsoAEg/piVJEaZLeR2r7wNydqCdvxMe
   c/ItqMNtysgMrOrKxhv43Z5a/BVX9DxrjOG2RrAbCOZk/IlX59dd+Xwy9
   50ZE23lWoprcTejYtgbnUrH4u1LeenicSIs4xQmW+OtXXZc89ZUfRKJwZ
   lCyaNQ8Z6VMJL6M8FEnoSzz6YbgP+IB42lLO+FmFAPeYyGW4/aopG7j16
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="176569956"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 05:09:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 05:09:06 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 16 Aug 2022 05:09:04 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 4/4] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Tue, 16 Aug 2022 13:08:30 +0100
Message-ID: <20220816120829.719749-5-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220816120829.719749-1-conor.dooley@microchip.com>
References: <20220816120829.719749-1-conor.dooley@microchip.com>
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
index 8a5012ba6ff9..5db66c743595 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17532,6 +17532,7 @@ F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/
 F:	drivers/spi/spi-microchip-core.c
-- 
2.36.1

