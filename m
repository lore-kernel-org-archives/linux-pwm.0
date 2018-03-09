Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] pwm: rcar: Add suspend/resume support and cleanup for runtime_pm
Date: Fri,  9 Mar 2018 20:54:56 +0900
Message-Id: <1520596498-4801-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set improves power management for Renesas PWM driver.

Hien Dang (1):
  pwm: rcar: Use PM Runtime to control module clock

Yoshihiro Shimoda (1):
  pwm: rcar: add suspend/resume support

 drivers/pwm/pwm-rcar.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

-- 
1.9.1
