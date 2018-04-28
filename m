Return-Path: <martin.blumenstingl@googlemail.com>
Return-Path: <martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] pwm: meson: fix allocation of meson_pwm_channel array
Date: Sat, 28 Apr 2018 23:25:21 +0200
Message-Id: <20180428212521.29328-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc: khilman@baylibre.com, carlo@caione.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Using the pwm-meson driver on the 32-bit SoCs causes memory corruption.
The result are some hard-to-explain errors, for example
devm_clk_register crashes with a NULL dereference somewhere deep in the
common clock framework code.
In some cases the kernel even refused to boot when any of the PWM
controllers were enables on Meson8b.

The root cause seems to be an incorrect memory size in the devm_kcalloc
call in meson_pwm_probe. The code allocates an array of meson_pwm_channel
structs, but the size given is the size of the meson_pwm struct (which
seems like a small copy-and-paste error, as meson_pwm is allocated a few
lines above).
Even with this typo the code seemed to work fine on the 64-bit GX SoCs
(maybe due to the structs having the same size in the compiled result,
but I haven't checked this further).

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 0767deba8e62..822860b4801a 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -541,8 +541,8 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	meson->data = of_device_get_match_data(&pdev->dev);
 	meson->inverter_mask = BIT(meson->chip.npwm) - 1;
 
-	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm, sizeof(*meson),
-				GFP_KERNEL);
+	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
+				sizeof(*channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
-- 
2.17.0
