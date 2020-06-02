From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM subsystem
Date: Tue,  2 Jun 2020 14:32:41 +0200
Message-ID: <20200602123241.3363904-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMct (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:32:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C27C061A0E
        for <linux-pwm@vger.kernel.org>; Tue,  2 Jun 2020 05:32:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so12575690ejb.4
        for <linux-pwm@vger.kernel.org>; Tue, 02 Jun 2020 05:32:48 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org

Lee has kindly offered his help in sharing the patch review workload for
the PWM subsystem. If this works out well between Lee, Uwe and myself it
may be a good idea to maintain the subsystem as a group.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..b8889bed5d1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13736,6 +13736,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
 PWM SUBSYSTEM
 M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+M:	Lee Jones <lee.jones@linaro.org>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
-- 
2.24.1
