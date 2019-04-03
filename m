From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 11/12] misc: atmel_tclib: do not probe already used TCBs
Date: Wed,  3 Apr 2019 16:11:19 +0200
Message-ID: <20190403141120.32754-12-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

The TCBs that have children are using the new (proper) DT bindings and
don't need to be handled by tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/misc/atmel_tclib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index c79190525862..b610cc894cd8 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -79,6 +79,9 @@ static int __init tc_probe(struct platform_device *pdev)
 	struct resource	*r;
 	unsigned int	i;
 
+	if (of_get_child_count(pdev->dev.of_node))
+		return 0;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
-- 
2.20.1
