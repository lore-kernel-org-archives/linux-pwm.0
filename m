From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 0/4] pwm: kona: Drivers fixes
Date: Fri, 14 Nov 2014 10:29:56 -0800
Message-ID: <1415989800-7515-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Arun Ramamurthy <arunrama@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This patchset contains fixes for Broadcom's Kona PWM driver.

These changes fix glitch issues when changing settings on different channels.
Kconfig change made to allow the driver to work on any Broadcom SoC rather
than just mobile devices.

Arun Ramamurthy (4):
  pwm: kona: Remove setting default smooth type and polarity for all
    channels
  pwm: kona: Fix incorrect enable after channel polarity change
  pwm: kona: Fix enable, disable and config procedures
  pwm: kona: Update dependency to ARCH_BCM

 drivers/pwm/Kconfig        |   2 +-
 drivers/pwm/pwm-bcm-kona.c | 112 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 81 insertions(+), 33 deletions(-)

-- 
2.1.3
