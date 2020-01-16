From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 012/371] pwm: lpss: Release runtime-pm reference from the driver's remove callback
Date: Thu, 16 Jan 2020 12:11:20 -0500
Message-ID: <20200116171719.16965-12-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391242AbgAPRRg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Jan 2020 12:17:36 -0500
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 42885551cedb45961879d2fc3dc3c4dc545cc23e ]

For each pwm output which gets enabled through pwm_lpss_apply(), we do a
pm_runtime_get_sync().

This commit adds pm_runtime_put() calls to pwm_lpss_remove() to balance
these when the driver gets removed with some of the outputs still enabled.

Fixes: f080be27d7d9 ("pwm: lpss: Add support for runtime PM")
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-lpss.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 1e69c1c9ec09..7a4a6406cf69 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -216,6 +216,12 @@ EXPORT_SYMBOL_GPL(pwm_lpss_probe);
 
 int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
 {
+	int i;
+
+	for (i = 0; i < lpwm->info->npwm; i++) {
+		if (pwm_is_enabled(&lpwm->chip.pwms[i]))
+			pm_runtime_put(lpwm->chip.dev);
+	}
 	return pwmchip_remove(&lpwm->chip);
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_remove);
-- 
2.20.1
