From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: pwm: Drop unneeded pwm_enable() call" to the regulator tree
Date: Fri, 03 Jun 2016 12:08:47 +0100
Message-ID: <E1b8my7-0004mI-St@finisterre>
References: <1464942192-25967-3-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464942192-25967-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.orgMark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.co>
List-Id: linux-pwm@vger.kernel.org

The patch

   regulator: pwm: Drop unneeded pwm_enable() call

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 830583004e615a4637eacc77866b84908414d7a0 Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Fri, 3 Jun 2016 10:23:00 +0200
Subject: [PATCH] regulator: pwm: Drop unneeded pwm_enable() call

Now that the PWM regulator driver implements the ->enable/disable() hooks
we can remove the pwm_enable() call from pwm_regulator_set_voltage().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pwm-regulator.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index fafa3488e960..ab3cc0235843 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -159,11 +159,6 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 		return ret;
 	}
 
-	ret = pwm_enable(drvdata->pwm);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to enable PWM: %d\n", ret);
-		return ret;
-	}
 	drvdata->volt_uV = min_uV;
 
 	/* Delay required by PWM regulator to settle to the new voltage */
-- 
2.8.1
