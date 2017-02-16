From: slemieux.tyco@gmail.com
Subject: [RESEND PATCH 0/3] pwm: lpc32xx: switch driver to one phandle argument for PWM consumers
Date: Thu, 16 Feb 2017 15:27:46 -0500
Message-ID: <20170216202749.20653-1-slemieux.tyco@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34512 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbdBPU2A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Feb 2017 15:28:00 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, vz@mleia.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The change adds private of_xlate() function to process one argument given along with a PWM phandle. LPC32xx SoCs have two independent single channel PWM controllers, the argument is used as a description of PWM output frequency, see previous discussion here:

  http://www.spinics.net/lists/arm-kernel/msg534068.html

The changes on actual board dts files are not needed at the moment, because all LPC32xx boards in upstream don't describe any PWM consumers.

Please refer to the following URL to view the previous patch #1 review discussion:
  http://www.spinics.net/lists/arm-kernel/msg549772.html

The "Reviewed-by" and "Acked-by" from the original posting are added into this resend.

Vladimir Zapolskiy (3):
  dt: pwm: lpc32xx: add description of clocks and #pwm-cells properties
  pwm: lpc32xx: switch driver to one phandle argument for PWM consumers
  pwm: lpc32xx: remove handling of PWM channels

 .../devicetree/bindings/pwm/lpc32xx-pwm.txt        |  7 +++++
 drivers/pwm/pwm-lpc32xx.c                          | 36 +++++++++++++++-------
 2 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.11.0
