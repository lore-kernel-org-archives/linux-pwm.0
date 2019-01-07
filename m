Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/4] pwm patches for the next merge window
Date: Mon,  7 Jan 2019 20:49:35 +0100
Message-Id: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
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

this is the set of generic pwm patches I already send out before rebased
to v5.0-rc1. I didn't receive any feedback for them but consider patches
1 to 3 ready to apply. For the fourth patch some feedback would be
great.

Uwe Kleine-König (4):
  pwm: don't use memcmp to compare struct state variables
  pwm: drop per-chip dbg_show callback
  pwm: rearrange structures to group members by purpose
  [RFC] Documentation: pwm: rework documentation for the framework

 Documentation/pwm-sysfs.txt |  44 +++++++
 Documentation/pwm.txt       | 229 +++++++++++++++---------------------
 drivers/pwm/core.c          |  10 +-
 include/linux/pwm.h         |  36 +++---
 4 files changed, 161 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/pwm-sysfs.txt

-- 
2.20.1
