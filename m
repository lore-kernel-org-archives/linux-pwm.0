From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pwm: meson: handle unknown ID values
Date: Tue,  6 Sep 2016 14:50:47 +0200
Message-ID: <20160906125106.1511562-1-arnd@arndb.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58070 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754997AbcIFMvo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Sep 2016 08:51:44 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

When building with -Wmaybe-uninitialized, we get a couple of harmless
warnings about three functions in this new driver that don't look
safe to the compiler:

drivers/pwm/pwm-meson.c: In function 'meson_pwm_get_state':
drivers/pwm/pwm-meson.c:355:26: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c: In function 'meson_pwm_disable':
drivers/pwm/pwm-meson.c:263:13: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c: In function 'meson_pwm_apply':
drivers/pwm/pwm-meson.c:231:13: error: 'clk_shift' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c:231:36: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c:231:24: error: 'clk_enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Specifically, if we have a device with an id other than 0 or 1,
this would result in undefined behavior. This is currently not
possible, but the compiler cannot be expected to know this.

This patch adds a 'default' clause to let the compiler know
what to do instead, which shuts up the warning and makes the
code slightly more resiliant in case it gets extended to other
identifiers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/pwm-meson.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 566f5cb81021..25abd95dcc7b 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -242,6 +242,9 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 		clk_enable = MISC_B_CLK_EN;
 		enable = MISC_B_EN;
 		break;
+
+	default:
+		return;
 	}
 
 	value = readl(meson->base + REG_MISC_AB);
@@ -270,6 +273,9 @@ static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
 	case 1:
 		enable = MISC_B_EN;
 		break;
+
+	default:
+		return;
 	}
 
 	value = readl(meson->base + REG_MISC_AB);
@@ -349,6 +355,10 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	case 1:
 		mask = MISC_B_EN;
 		break;
+
+	default:
+		state->enabled = 0;
+		return;
 	}
 
 	value = readl(meson->base + REG_MISC_AB);
-- 
2.9.0
