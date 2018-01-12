From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] pwm: lpss-platform: Cleanly exit probe on boards without resources
Date: Fri, 12 Jan 2018 12:38:02 +0100
Message-ID: <20180112113802.3888-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754403AbeALLiE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Jan 2018 06:38:04 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org

Some boards which do not use the pwm-controller have an empty or invalid
resource-table in ACPI the for pwm-controller. Currently this causes these
error messages to get logged:
[    3.281966] pwm-lpss 80862288:00: invalid resource
[    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22

This commit silences these error messages on these boards by cleanly
exiting pwm_lpss_probe_platform() if there is no memory resource.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 5d6ed1507d29..5e5f4d018178 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -52,7 +52,14 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 		return -ENODEV;
 
 	info = (const struct pwm_lpss_boardinfo *)id->driver_data;
+
+	/*
+	 * Some boards which don't use the pwm controller have an empty
+	 * resources table, so if we cannot get the resource, return -ENODEV.
+	 */
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
 
 	lpwm = pwm_lpss_probe(&pdev->dev, r, info);
 	if (IS_ERR(lpwm))
-- 
2.14.3
