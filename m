From: Michael Walle <michael@walle.cc>
Subject: [PATCH 03/18] mfd: mfd-core: match device tree node against reg property
Date: Tue, 17 Mar 2020 21:50:02 +0100
Message-ID: <20200317205017.28280-4-michael@walle.cc>
References: <20200317205017.28280-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317205017.28280-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
List-Id: linux-pwm@vger.kernel.org

There might be multiple children with the device tree compatible, for
example if a MFD has multiple instances of the same function. In this
case only the first is matched and the other children get a wrong
of_node reference.
We distinguish them by looking at the reg property and match it against
the mfd_cell id element if the latter is non-zero and the reg property
exists in the device tree node.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mfd/mfd-core.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index e735565969b3..0e718e6cdbde 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -117,6 +117,7 @@ static int mfd_add_device(struct device *parent, int id,
 	struct device_node *np = NULL;
 	int ret = -ENOMEM;
 	int platform_id;
+	u32 of_id;
 	int r;
 
 	if (id == PLATFORM_DEVID_AUTO)
@@ -151,16 +152,23 @@ static int mfd_add_device(struct device *parent, int id,
 
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
-			if (of_device_is_compatible(np, cell->of_compatible)) {
-				if (!of_device_is_available(np)) {
-					/* Ignore disabled devices error free */
-					ret = 0;
-					goto fail_alias;
-				}
-				pdev->dev.of_node = np;
-				pdev->dev.fwnode = &np->fwnode;
-				break;
+			if (!of_device_is_compatible(np, cell->of_compatible))
+				continue;
+
+			/* match the reg property to the id */
+			if (!of_property_read_u32(np, "reg", &of_id))
+				if (cell->id && cell->id != of_id)
+					continue;
+
+			if (!of_device_is_available(np)) {
+				/* Ignore disabled devices error free */
+				ret = 0;
+				goto fail_alias;
 			}
+
+			pdev->dev.of_node = np;
+			pdev->dev.fwnode = &np->fwnode;
+			break;
 		}
 	}
 
-- 
2.20.1
