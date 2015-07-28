From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 14/22] pwm: Probe PWM chip devices on demand
Date: Tue, 28 Jul 2015 15:19:45 +0200
Message-ID: <1438089593-7696-15-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

When looking up a PWM chip through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/pwm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3a7769fe53de..4727cbf69d96 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -496,6 +496,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
 	struct pwm_chip *chip;
 
+	fwnode_ensure_device(&np->fwnode);
+
 	mutex_lock(&pwm_lock);
 
 	list_for_each_entry(chip, &pwm_chips, list)
-- 
2.4.3
