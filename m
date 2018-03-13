Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] pwm: rcar: Add suspend/resume support and cleanup for runtime_pm
Date: Tue, 13 Mar 2018 17:18:16 +0900
Message-Id: <1520929098-20873-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set improves power management for Renesas PWM driver.

Changes from v1:
 - Add Reviewed-by Geert-san in patch 1 (Thanks!).
 - Check a condition in suspend/resume if requested or not in patch 2.

Hien Dang (1):
  pwm: rcar: Use PM Runtime to control module clock

Yoshihiro Shimoda (1):
  pwm: rcar: add suspend/resume support

 drivers/pwm/pwm-rcar.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

-- 
1.9.1
