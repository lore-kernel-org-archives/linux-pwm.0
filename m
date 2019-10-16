Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbfJPLGN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so27549158wrp.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:11 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 13:06:01 +0200
Message-Id: <20191016110601.1765415-4-thierry.reding@gmail.com>
In-Reply-To: <20191016110601.1765415-1-thierry.reding@gmail.com>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 3/3] pwm: stm32: Validate breakinput data from DT
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Both index and level can only be either 0 or 1 and the filter value is
limited to values between (and including) 0 and 15. Validate that the
device tree node contains values that are within these ranges.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index db1d675b45fb..7ff48c14fae8 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -530,6 +530,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 				       struct device_node *np)
 {
 	int nb, ret, array_size;
+	unsigned int i;
 
 	nb = of_property_count_elems_of_size(np, "st,breakinput",
 					     sizeof(struct stm32_breakinput));
@@ -551,6 +552,13 @@ static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 	if (ret)
 		return ret;
 
+	for (i = 0; i < priv->num_breakinputs; i++) {
+		if (priv->breakinputs[i].index > 1 ||
+		    priv->breakinputs[i].level > 1 ||
+		    priv->breakinputs[i].filter > 15)
+			return -EINVAL;
+	}
+
 	return stm32_pwm_apply_breakinputs(priv);
 }
 
-- 
2.23.0
