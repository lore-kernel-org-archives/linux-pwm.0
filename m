Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] pwm: imx: document known limitations
Date: Tue, 30 Jul 2019 14:45:27 +0200
Message-Id: <20190730124527.25228-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190730124227.4854-1-u.kleine-koenig@pengutronix.de>
References: <20190730124227.4854-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1:
 - s/independant/independent/

 drivers/pwm/pwm-imx27.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 434a351fb626..91c23cbbc167 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -3,6 +3,10 @@
  * simple driver for PWM (Pulse Width Modulator) controller
  *
  * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
+ *
+ * Limitations:
+ * - When disabled the output is driven to 0 independent of the configured
+ *   polarity.
  */
 
 #include <linux/bitfield.h>
-- 
2.20.1
