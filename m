Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/3] MAINTAINERS: Add myself as reviewer for the PWM subsystem
Date: Mon, 23 Sep 2019 10:49:37 +0200
Message-Id: <20190923084937.20358-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
References: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

I spend some time in the nearer past reviewing pwm patches. Honor this
by adding me as a reviewer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e9cfed834b2..0fa11c5d2c7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13243,6 +13243,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
 
 PWM SUBSYSTEM
 M:	Thierry Reding <thierry.reding@gmail.com>
+R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
-- 
2.23.0
