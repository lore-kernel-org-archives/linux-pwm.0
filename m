Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/4] pwm: imx: some cleanup patches
Date: Mon,  7 Jan 2019 20:53:48 +0100
Message-Id: <20190107195352.3149-1-u.kleine-koenig@pengutronix.de>
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

Hello,

this are the imx specific patches that are still in my queue. They are
rebased to apply to v5.0-rc1.

Best regards
Uwe

Uwe Kleine-König (4):
  pwm: imx: remove if block where the condition is always wrong
  pwm: imx: set drvdata earlier simplifying the end of .probe
  pwm: imx: don't print an error on -EPROBE_DEFER
  pwm: imx: split into two drivers

 drivers/pwm/Kconfig                    |  17 +-
 drivers/pwm/Makefile                   |   3 +-
 drivers/pwm/pwm-imx1.c                 | 197 +++++++++++++++++++++++
 drivers/pwm/{pwm-imx.c => pwm-imx27.c} | 210 ++++++-------------------
 4 files changed, 263 insertions(+), 164 deletions(-)
 create mode 100644 drivers/pwm/pwm-imx1.c
 rename drivers/pwm/{pwm-imx.c => pwm-imx27.c} (60%)

-- 
2.20.1
