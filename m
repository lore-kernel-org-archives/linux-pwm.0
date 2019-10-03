From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] backlight: pwm_bl: Add missing curly branches in else branch
Date: Thu,  3 Oct 2019 14:35:02 -0700
Message-ID: <20191003213502.102110-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add curly braces to an 'else' branch in pwm_backlight_update_status()
to match the corresponding 'if' branch.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..130abff2705f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -125,8 +125,9 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		state.duty_cycle = compute_duty_cycle(pb, brightness);
 		pwm_apply_state(pb->pwm, &state);
 		pwm_backlight_power_on(pb);
-	} else
+	} else {
 		pwm_backlight_power_off(pb);
+	}
 
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
-- 
2.23.0.444.g18eeb5a265-goog
