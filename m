From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v2 0/4] pwm: kona: Drivers fixes
Date: Tue, 25 Nov 2014 11:40:37 -0800
Message-ID: <1416944441-12066-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:17061 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbaKYTl1 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Nov 2014 14:41:27 -0500
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Arun Ramamurthy <arunrama@broadcom.com>, Tim Kryger <tim.kryger@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

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

