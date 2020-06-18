From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 069/266] pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() failed case
Date: Wed, 17 Jun 2020 21:13:14 -0400
Message-ID: <20200618011631.604574-69-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit ca162ce98110b98e7d97b7157328d34dcfdd40a9 ]

Even in failed case of pm_runtime_get_sync(), the usage_count is
incremented. In order to keep the usage_count with correct value call
appropriate pm_runtime_put().

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-img.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index c9e57bd109fb..599a0f66a384 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -129,8 +129,10 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
 	ret = pm_runtime_get_sync(chip->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(chip->dev);
 		return ret;
+	}
 
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
@@ -331,8 +333,10 @@ static int img_pwm_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++) {
 		val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
-- 
2.25.1
