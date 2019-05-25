From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
Date: Sat, 25 May 2019 20:11:23 +0200
Message-ID: <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
a bit-mask. Rename and change the macro to be a bit-mask so that
conversion is not needed anymore. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c62a3ac924d0..84b28ba0f903 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -33,7 +33,7 @@
 #define MISC_A_CLK_DIV_SHIFT	8
 #define MISC_B_CLK_SEL_SHIFT	6
 #define MISC_A_CLK_SEL_SHIFT	4
-#define MISC_CLK_SEL_WIDTH	2
+#define MISC_CLK_SEL_MASK	0x3
 #define MISC_B_EN		BIT(1)
 #define MISC_A_EN		BIT(0)
 
@@ -463,7 +463,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
 		channel->mux.shift = mux_reg_shifts[i];
-		channel->mux.mask = BIT(MISC_CLK_SEL_WIDTH) - 1;
+		channel->mux.mask = MISC_CLK_SEL_MASK;
 		channel->mux.flags = 0;
 		channel->mux.lock = &meson->lock;
 		channel->mux.table = NULL;
-- 
2.21.0
